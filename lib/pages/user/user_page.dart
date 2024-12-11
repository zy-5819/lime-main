import 'dart:async';
import 'dart:io';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lime/constant/exception_message.dart';
import 'package:lime/constant/strings.dart';
import 'package:lime/models/server_version.dart';
import 'package:lime/nav/args.dart';
import 'package:lime/nav/routes.dart';
import 'package:lime/providers/theme_provider.dart';
import 'package:lime/providers/top_level_providers.dart';
import 'package:lime/services/ota_service.dart';
import 'package:lime/theme/capella_theme.dart';
import 'package:lime/util/log_util.dart';
import 'package:lime/widgets/async_value_widget.dart';
part 'src/avator_item.dart';

class UserPage extends StatefulHookConsumerWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UserPageState();
}

class _UserPageState extends ConsumerState<UserPage>
    with SingleTickerProviderStateMixin {
  late AnimationController animation;

  @override
  void initState() {
    super.initState();
    animation = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));
  }

  @override
  void dispose() {
    animation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final user = ref.watch(userResponseProvider);
    final isPro = true;

    final theme = Theme.of(context);
    return SafeArea(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        decoration: BoxDecoration(
            color: theme.colorScheme.secondaryContainer.withOpacity(0.3),
            borderRadius: BorderRadius.circular(12.r)),
        child: Theme(
          data: Theme.of(context).copyWith(
              listTileTheme: ListTileThemeData(horizontalTitleGap: 8.w)),
          child: Column(
            children: [
              const _AvatorItem(),
              Expanded(
                child: Scaffold(
                  backgroundColor: Colors.transparent,
                  body: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        _buildThemeChanges(),
                        if (isPro) _buildUserCode(),
                        if (isPro) _buildUserScanTheCode(),
                        _buildSettings(),
                        _buildLightDark(),
                        // if (isPro &&
                        //     (user.role == 'admin' || user.role == 'operator'))
                        _buildOperationLogs(),
                        if (Platform.isAndroid) _softVersion(),
                        _buildServerUrl(),
                        // if (user.userRole == UserRole.admin)
                        _buildAdmin(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAdmin() {
    return ListTile(
      leading: Padding(
        padding: EdgeInsets.all(8.r),
        child: Icon(Icons.admin_panel_settings_outlined, size: 24.sp),
      ),
      title: const Text('admin', maxLines: 1),
      trailing: const Icon(Icons.keyboard_arrow_right_rounded),
      onTap: () {},
    );
  }

  Widget _buildServerUrl() {
    final version = ref.read(serverVersionProvider);
    if (version == ServerVersion.official.toString()) {
      return const SizedBox.shrink();
    } else {
      final url = ref.read(sharedPreferencesProvider).getString(kTestServerUrl);
      return ListTile(
        leading: Padding(
          padding: EdgeInsets.all(8.r),
          child: Icon(Icons.cloud_outlined, size: 24.sp),
        ),
        title: const Text('服务器', maxLines: 1),
        trailing: Container(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: Text(url ?? ''),
        ),
      );
    }
  }

  Widget _buildOperationLogs() {
    return ListTile(
      leading: Padding(
        padding: EdgeInsets.all(8.r),
        child: Icon(Icons.elderly_woman, size: 24.sp),
      ),
      title: const Text('操作日志'),
      trailing: const Icon(Icons.keyboard_arrow_right_rounded),
      onTap: () => Navigator.of(context).pushNamed(Routes.userAuditLogs),
    );
  }

  Widget _buildLightDark() {
    return ListTile(
      leading: Padding(
        padding: EdgeInsets.all(8.r),
        child: Icon(Icons.light_mode_outlined, size: 24.sp),
      ),
      title: const Text('主题'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ValueListenableBuilder(
              valueListenable: AdaptiveTheme.of(context).modeChangeNotifier,
              builder: (_, AdaptiveThemeMode mode, child) {
                String res = '';
                switch (mode) {
                  case AdaptiveThemeMode.light:
                    res = '日间模式';
                    break;
                  case AdaptiveThemeMode.dark:
                    res = '夜间模式';
                    break;
                  case AdaptiveThemeMode.system:
                    res = '跟随系统';
                    break;
                }
                return Text(res);
              }),
          const Icon(Icons.keyboard_arrow_right_rounded),
        ],
      ),
      onTap: () => AdaptiveTheme.of(context).toggleThemeMode(),
    );
  }

  ///设置
  Widget _buildSettings() {
    return ListTile(
      leading: Padding(
        padding: EdgeInsets.all(8.r),
        child: Icon(Icons.settings_outlined, size: 24.sp),
      ),
      title: const Text('设置'),
      trailing: const Icon(Icons.keyboard_arrow_right_rounded),
      onTap: () => Navigator.of(context).pushNamed(Routes.userSettings),
    );
  }

  ///跳转至展示用户码的页面
  Widget _buildUserCode() {
    return ListTile(
      leading: Padding(
        padding: EdgeInsets.all(8.r),
        child: Icon(Icons.qr_code, size: 24.sp),
      ),
      title: const Text('我的二维码'),
      trailing: const Icon(Icons.keyboard_arrow_right_rounded),
      onTap: () => Navigator.of(context).pushNamed(Routes.userCode),
    );
  }

  Future<void> _scanTheCode(String code) async {
    return showDialog<void>(
        context: context,
        builder: ((context) {
          return AlertDialog(
            title: Text(
              '是否登录该设备',
              style: TextStyle(fontSize: 20.sp),
            ),
            actions: [
              TextButton(
                  onPressed: Navigator.of(context).pop,
                  child: const Text('取消')),
              TextButton(
                onPressed: () async {
                  try {
                    // await ref
                    //     .watch(authServiceProvider)
                    //     .confirmDeviceLogin(code, true);
                    await Fluttertoast.showToast(msg: '登录成功');
                  } catch (e) {
                    unawaited(Fluttertoast.showToast(msg: Em.exception(e)));
                  } finally {
                    if (context.mounted) {
                      Navigator.of(context).pop();
                    }
                  }
                },
                child: const Text('确认'),
              ),
            ],
          );
        }));
  }

  ///跳转至扫码页面
  Widget _buildUserScanTheCode() {
    return ListTile(
      leading: Padding(
        padding: EdgeInsets.all(8.r),
        child: Icon(Icons.center_focus_weak, size: 24.sp),
      ),
      title: const Text('扫一扫'),
      trailing: const Icon(Icons.keyboard_arrow_right_rounded),
      onTap: () => Navigator.of(context).pushNamed(Routes.myMobileScanner,
          arguments: MyMobileScannerArgs(onScannedAsync: _scanTheCode)),
    );
  }

  ///切换主题颜色
  Widget _buildThemeChanges() {
    final theme = Theme.of(context);
    final colors = Map.fromIterables(ThemeType.values,
        ThemeType.values.map((e) => e.toColor(theme.brightness)));
    return ListTile(
      leading: Padding(
        padding: EdgeInsets.all(8.r),
        child: Icon(Icons.color_lens_outlined, size: 24.sp),
      ),
      title: const Text('颜色'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 24.h,
            child: Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: theme.colorScheme.primary),
            ),
          ),
          const Icon(Icons.keyboard_arrow_right_rounded),
        ],
      ),
      onTap: () async {
        await showDialog<Color>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: SingleChildScrollView(
                child: BlockPicker(
                  pickerColor: theme.colorScheme.primary,
                  onColorChanged: (color) => _updateTheme(colors, color),
                  availableColors: colors.values.toList(growable: false),
                  layoutBuilder: _buildPickerLayout,
                  itemBuilder: _buildPickerItem,
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildPickerLayout(
      BuildContext context, List<Color> colors, PickerItem child) {
    Orientation orientation = MediaQuery.of(context).orientation;
    const portraitCrossAxisCount = 3;
    const landscapeCrossAxisCount = 5;
    return SizedBox(
      width: 300,
      height: 200,
      child: GridView.count(
        crossAxisCount: orientation == Orientation.portrait
            ? portraitCrossAxisCount
            : landscapeCrossAxisCount,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
        children: [for (Color color in colors) child(color)],
      ),
    );
  }

  Widget _buildPickerItem(
      Color color, bool isCurrentColor, void Function() changeColor) {
    const borderRadius = 40.0;
    const blurRadius = 5.0;
    const iconSize = 24.0;
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        color: color,
        boxShadow: [
          BoxShadow(
              color: color.withOpacity(0.8),
              offset: const Offset(1, 2),
              blurRadius: blurRadius)
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: changeColor,
          borderRadius: BorderRadius.circular(borderRadius),
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 250),
            opacity: isCurrentColor ? 1 : 0,
            child: Icon(
              Icons.done,
              size: iconSize,
              color: useWhiteForeground(color) ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  void _updateTheme(Map<ThemeType, Color> colors, Color selectedColor) {
    final theme = colors.entries
        .firstWhere((element) => element.value == selectedColor)
        .key;
    ref.read(themeProvider.notifier).update(theme);
    ref.read(sharedPreferencesProvider).setString(kTheme, theme.toString());

    AdaptiveTheme.of(context).setTheme(
        light: CapellaTheme(themeColor: theme).lightThemeData,
        dark: CapellaTheme(themeColor: theme).darkThemeData);
  }

  Widget _softVersion() {
    return ListTile(
      leading: Padding(
        padding: EdgeInsets.all(8.r),
        child: Icon(Icons.info_outline, size: 24.sp),
      ),
      title: const Text('软件版本'),
      trailing: Stack(
        children: [
          const Icon(Icons.keyboard_arrow_right_rounded),
          OtaService.instance.canUpadte
              ? Positioned(
                  child: Container(
                    width: 8.sp,
                    height: 8.sp,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                  ),
                )
              : const SizedBox(),
        ],
      ),
      onTap: _simpleDialog,
    );
  }

  Future<void> _simpleDialog() async {
    if (OtaService.instance.processProvider.value! > 0 &&
        OtaService.instance.processProvider.value! < 1) {
      await _showProgress();
    } else {
      await showDialog<String>(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 0.3.sw,
                    height: 0.3.sw,
                    child: FittedBox(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 0.5.sw,
                            width: 0.5.sw,
                            child: SvgPicture.asset(
                              kAppIcon,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          SizedBox(height: 20.h),
                          Text(
                            '当前软件版本号:${OtaService.instance.curVersion}',
                            style: TextStyle(
                                fontSize: 30.sp,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              content: !OtaService.instance.canUpadte
                  ? const Text('已是最新版本', style: TextStyle(color: Colors.grey))
                  : Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('可更新版本:${OtaService.instance.serverVersion}',
                            style: const TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold)),
                        SizedBox(height: 10.h),
                        Flexible(
                            child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Text(
                                  '更新说明:\n${OtaService.instance.updateDescription?.replaceAll('<br>', '\r')}',
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 13.sp))
                            ],
                          ),
                        ))
                      ],
                    ),
              actions: OtaService.instance.canUpadte
                  ? [
                      Center(
                        child: FractionallySizedBox(
                          widthFactor: 0.5, // 按钮宽度为父容器的50%
                          child: ElevatedButton(
                            onPressed: () async {
                              Navigator.of(context).pop();
                              unawaited(OtaService.instance
                                  .doUpdateWithAndriod(context));
                              await _showProgress();
                            },
                            child: const Text('下载更新'),
                          ),
                        ),
                      )
                    ]
                  : [],
            );
          });
    }
  }

  Future<void> _showProgress() async {
    await showDialog<void>(
      context: context,
      builder: (context) => ValueListenableBuilder(
        valueListenable: OtaService.instance.processProvider,
        builder: (BuildContext context, double? value, Widget? child) {
          if (value != null) {
            if (value.toInt() == 1) {
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                Navigator.of(context).pop();
              });
            }
          } else {
            Navigator.of(context).pop();
            Fluttertoast.showToast(
              msg: '下载失败',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.black45,
              textColor: Colors.white,
              fontSize: 16.0,
            );
            return const SizedBox();
          }

          return SimpleDialog(
              title: Center(
                child: Text('下载进度:${(value * 100).toInt()}%'),
              ),
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: LinearProgressIndicator(
                    value: value,
                    minHeight: 20.h,
                    backgroundColor:
                        Theme.of(context).colorScheme.secondaryContainer,
                  ),
                ),
              ]);
        },
      ),
    );
  }
}
