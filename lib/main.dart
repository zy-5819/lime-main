import 'dart:async';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:flutter_swipe_action_cell/core/swipe_action_navigator_observer.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lime/constant/strings.dart';
import 'package:lime/models/user_access_info.dart';
import 'package:lime/nav/keys.dart';
import 'package:lime/nav/routes.dart';
import 'package:lime/providers/theme_provider.dart';
import 'package:lime/providers/top_level_providers.dart';
import 'package:lime/services/ota_service.dart';
import 'package:lime/theme/capella_theme.dart';
import 'package:lime/util/env.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final envFuture = Env.load();
  final systemChromeFuture =
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await OtaService.instance.start();
  final savedThemeMode = await AdaptiveTheme.getThemeMode();
  final prefse = await SharedPreferences.getInstance();
  final userAccess = UserAccessInfo.fromString(
      prefse.getString(SharedPreferenceKeys.kUserAccess));
  final initialRoute = userAccess.hasToken && userAccess.validExpiry
      ? Routes.bottomTabs
      : Routes.bottomTabs;

  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(prefse),
      ],
      child: MyApp(
        initialRoute: initialRoute,
        adaptiveThemeMode: savedThemeMode,
      ),
    ),
  );
  //FlutterNativeSplash.remove();
}

class MyApp extends HookConsumerWidget {
  const MyApp({
    Key? key,
    required this.initialRoute,
    this.adaptiveThemeMode,
  }) : super(key: key);

  final String initialRoute;
  final AdaptiveThemeMode? adaptiveThemeMode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = ref.watch(themeProvider);
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return Portal(
          child: AdaptiveTheme(
            light: CapellaTheme(themeColor: t).lightThemeData,
            dark: CapellaTheme(themeColor: t).darkThemeData,
            initial: adaptiveThemeMode ?? AdaptiveThemeMode.system,
            builder: (light, dark) => MaterialApp(
                navigatorKey: navigatorKey,
                scrollBehavior: _NoStrechScrollBehavior(),
                localizationsDelegates: const [
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: const [Locale('zh')],
                navigatorObservers: [
                  SwipeActionNavigatorObserver(),
                  FlutterSmartDialog.observer,
                ],
                debugShowCheckedModeBanner: false,
                //应用标题
                title: 'Capella',
                //应用主题样式
                theme: light,
                darkTheme: dark,
                //路由
                routes: routes,
                //根路由
                initialRoute: initialRoute,
                //builder
                builder: FlutterSmartDialog.init(
                  builder: (context, child) {
                    return _Unfocus(
                      child: MediaQuery(
                        data: MediaQuery.of(context)
                            .copyWith(textScaler: const TextScaler.linear(1.0)),
                        child: child!,
                      ),
                    );
                  },
                )),
          ),
        );
      },
    );
  }
}

class _Unfocus extends HookConsumerWidget {
  const _Unfocus({
    Key? key,
    required this.child,
  }) : super(key: key);
  final Widget child;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: child,
    );
  }
}

class _NoStrechScrollBehavior extends ScrollBehavior {
  static const ScrollPhysics _bouncingPhysics =
      BouncingScrollPhysics(parent: RangeMaintainingScrollPhysics());
  static const ScrollPhysics _clampingPhysics =
      ClampingScrollPhysics(parent: RangeMaintainingScrollPhysics());

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    switch (getPlatform(context)) {
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
      case TargetPlatform.android:
        return _bouncingPhysics;
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return _clampingPhysics;
    }
  }
}
