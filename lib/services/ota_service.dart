import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:lime/util/log_util.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:html/parser.dart' as htmlparser;
import 'package:install_plugin/install_plugin.dart';

class OtaService {
  static final OtaService _instance = OtaService._();
  static OtaService get instance => _instance;

  late String? curVersion, serverVersion, appName, updateDescription, apkPath;
  bool canUpadte = false;
  final _client = HttpClient();
  final processProvider = ValueNotifier<double?>(0);

  OtaService._();
  Future<void> start() async {
    curVersion = '';
    serverVersion = '';
    appName = '';
    apkPath = '';
    updateDescription = '';
    await _run();
  }

  Future<void> _run() async {
    await _getCurVersion();
    await _getServerVersion();
    canUpadte = _compareVersion();
  }

  Future<void> _getCurVersion() async {
    // 获取版本信息
    final pkg = await PackageInfo.fromPlatform();
    appName = pkg.packageName;
    curVersion = '${pkg.version}-${pkg.buildNumber}';
  }

  Future<String> _contactUrlWithAndroid() async {
    //获取版本详情页面的html内容
    var content = '';
    try {
      final request =
          await _client.postUrl(Uri.parse('https://www.pgyer.com/Yuqa'));
      request.headers.set('Content-Type', 'application/x-www-form-urlencoded');
      var data =
          utf8.encode(Uri(queryParameters: {'password': 'tj2022'}).query);
      request.add(data);
      final response = await request.close();

      if (!(response.statusCode >= 200 && response.statusCode <= 299)) {
        throw "HTTP ${response.statusCode}: ${response.reasonPhrase}";
      } else {
        String responseBody = await response.transform(utf8.decoder).join();
        var jsonMap = json.decode(responseBody) as Map;
        if (jsonMap['code'] == '0') {
          var href = (jsonMap['extra'] as Map)['href'] as String;

          final newRequest = await _client.getUrl(Uri.parse(href));
          final newResponse = await newRequest.close();
          if (!(newResponse.statusCode >= 200 &&
              newResponse.statusCode <= 299)) {
            throw "HTTP ${newResponse.statusCode}: ${newResponse.reasonPhrase}";
          } else {
            content = await newResponse.transform(utf8.decoder).join();
          }
        }
      }
    } catch (e) {
      Log.w('Failed to get ota source');
    }
    return content;
  }

  /// 获取服务端版本
  Future<void> _getServerVersion() async {
    if (Platform.isIOS) {
      // try {
      //   final request = await _client.postUrl(Uri.parse(
      //       'https://itunes.apple.com/cn/lookup?id=-R43YRLWPZ.com.cq.tongji.capella-app'));
      //   final response = await request.close();

      //   if (!(response.statusCode >= 200 && response.statusCode <= 299)) {
      //     throw "HTTP ${response.statusCode}: ${response.reasonPhrase}";
      //   } else {
      //     String responseBody = await response.transform(utf8.decoder).join();
      //     serverVersion = ((json.decode(responseBody) as Map)[0]
      //         as Map)["version"] as String;
      //   }
      // } catch (e) {
      //   Log.w('Failed to get ota source');
      // }
    } else if (Platform.isAndroid) {
      try {
        var content = await _contactUrlWithAndroid();
        var document = htmlparser.parse(content);
        var contents =
            document.body?.getElementsByClassName('version-info').map((e) {
          return e.innerHtml
              .trim()
              .replaceAll(RegExp(r'<.*?>'), '')
              .replaceAll(RegExp(r'\s+'), ' ')
              .replaceAll('(', '')
              .replaceAll(')', '')
              .trim()
              .toLowerCase();
        });
        var version = contents
            ?.firstWhere((v) => v.contains('版本'))
            .replaceAll(RegExp('版本'), '')
            .trim();
        var index = version?.indexOf('build');
        if (index != null && index != -1) {
          version = version?.substring(0, index);
        }

        var buildNumber = contents?.firstWhere((v) => v.contains('build'));
        if (buildNumber != null) {
          if (buildNumber.contains('版本')) {
            if (version != null) {
              buildNumber = buildNumber
                  .replaceAll(RegExp('版本'), '')
                  .replaceAll(RegExp(version), '')
                  .trim();
            }
          }
          buildNumber = buildNumber.replaceAll('build', '').trim();
        }
        serverVersion = '$version-$buildNumber';
        updateDescription = document.body
            ?.getElementsByClassName('update-description')
            .last
            .innerHtml
            .trim();
      } catch (e) {
        Log.w('Not find element');
      }
    }

    return;
  }

  /// 版本比较 是否更新
  bool _compareVersion() {
    bool flag = false;
    var serverVersionList = serverVersion?.trim().split(RegExp('[.-]'));
    var curVersionList = curVersion?.trim().split(RegExp('[.-]'));
    if (serverVersionList?.length == curVersionList?.length &&
        curVersionList != null) {
      for (var i = 0; i < curVersionList.length; i++) {
        if (int.parse(curVersionList[i]) < int.parse(serverVersionList![i])) {
          flag = true;
          break;
        }
      }
    }
    return flag;
  }

  ///andriod端更新应用
  Future<void> doUpdateWithAndriod(BuildContext context) async {
    var data = await _contactUrlWithAndroid();
    var document = htmlparser.parse(data);
    var content = document
        .getElementsByTagName('script')
        .firstWhere((element) => element.outerHtml.contains('finalCode'))
        .outerHtml;

    var sig = '';
    var akey = '';
    var sigReg = RegExp(r" sig = '(.*?)',");
    var match1 = sigReg.firstMatch(content);
    if (match1 != null) {
      sig = match1.group(1) ?? '';
    }
    RegExp akeyReg = RegExp(r" aKey = '(.*?)',");
    var match2 = akeyReg.firstMatch(content);
    if (match2 != null) {
      akey = match2.group(1) ?? '';
    }

    final appData = await getApplicationSupportDirectory();
    final otaDir = Directory(p.join(appData.path, 'ota'));
    Log.i('Downloading software update...');
    final apkFile = File("${p.join(otaDir.path, 'app')}.apk");

    //请求安装包资源
    final request = await _client.getUrl(
      Uri.parse('https://www.pgyer.com/app/install/$akey?sig=$sig&lang=cn'),
    );
    final response = await request.close();
    int contentLength = response.contentLength;
    // 下载安装包
    try {
      if (!await apkFile.exists()) {
        await apkFile.create(recursive: true);
      }
      int appLenth = 0;
      apkPath = apkFile.path;
      appLenth = await apkFile.length();
      //判断资源文件是否已经下载
      if (contentLength != appLenth) {
        await apkFile.writeAsString('');
        IOSink fileSink = apkFile.openWrite();
        int bytesReceived = 0;
        response.listen((List<int> chunk) {
          bytesReceived += chunk.length;
          fileSink.add(chunk);
          processProvider.value = bytesReceived / contentLength;
        }, onDone: () async {
          Log.i('Installing software update...');
          try {
            await fileSink.close();
            await InstallPlugin.installApk(apkFile.path);
            // 如果安装成功则重启程序
            Log.i('Software update installation completed.');
          } catch (e) {
            Log.w('Unable to install software update: $e');
          }
        }, onError: () {
          Log.w('Download Error');
          fileSink.close();
        });
      } else {
        processProvider.value = 1;
        await InstallPlugin.installApk(apkFile.path);
        // 如果安装成功则重启程序
        Log.i('Software update installation completed.');
      }
    } catch (e) {
      processProvider.value = null;
      Log.w('Failed to download ota source');
      return;
    }
  }

  // ///ios端更新应用
  // static void _doUpdateWithIos(
  //     {required BuildContext context,
  //     required String title,
  //     required String content}) {
  //   showCupertinoDialog<int>(
  //       context: context,
  //       builder: (cxt) {
  //         return CupertinoAlertDialog(
  //           title: Text(title),
  //           content: Column(
  //             children: <Widget>[
  //               Container(
  //                 margin: const EdgeInsets.only(top: 5, bottom: 15),
  //                 child: Text(
  //                   content,
  //                   textAlign: TextAlign.left,
  //                   style: const TextStyle(
  //                     fontFamily: "Times",
  //                     height: 1.2,
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           ),
  //           actions: <Widget>[
  //             CupertinoDialogAction(
  //               child: const Text("Cancel"),
  //               onPressed: () async {},
  //             ),
  //             CupertinoDialogAction(
  //               child: const Text("Update"),
  //               // 用户点击更新后 跳转的app 下载页面进行下载安装
  //               onPressed: () async {
  //                 String newVersionUrl =
  //                     'https://apps.apple.com/cn/app/-R43YRLWPZ.com.cq.tongji.capella-app';
  //                 try {
  //                   if (await canLaunchUrl(Uri.parse(newVersionUrl))) {
  //                     await launchUrl(Uri.parse(newVersionUrl));
  //                   } else {
  //                     throw Exception(
  //                         'Could not launch ${Uri.parse(newVersionUrl)}');
  //                   }
  //                 } catch (e) {
  //                   Log.w('Could not launch ${Uri.parse(newVersionUrl)}');
  //                 }
  //               },
  //             )
  //           ],
  //         );
  //       });
  // }
}
