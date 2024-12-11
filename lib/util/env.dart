import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class Env {
  static final kChannelHost = Env.get("CHANNEL_HOST", 'edge2.comlife.com.cn');
  static final kChannelPort = int.parse(Env.get("CHANNEL_PORT", '443'));
  static final kChannelUseSecureTransport =
      bool.tryParse(Env.get('CHANNEL_USE_SECURE_TRANSPORT', 'true')) ?? true;
  static const String kBuildEnvironment =
      String.fromEnvironment('build_env', defaultValue: 'dev');

  static late final Map<String, String> _items;
  Env._();

  static Future<void> load() async {
    final manifest = await rootBundle.loadString('AssetManifest.json');
    final manifestMap = json.decode(manifest) as Map<String, dynamic>;
    final envFiles = manifestMap.keys
        .where((String key) => key.startsWith('env/') && key.endsWith(".env"))
        .toList();

    _items = <String, String>{};
    await _addBuildConfig(_items, envFiles, '');
    await _addBuildConfig(_items, envFiles, kBuildEnvironment);
  }

  static Future<void> _addFromAsset(
      Map<String, String> map, String asset) async {
    final content = await rootBundle.loadString(asset);
    for (final line in content.split('\n').map((e) => e.trim())) {
      if (line.startsWith('#')) {
        continue;
      }

      final sepratorIndex = line.indexOf('=');
      if (sepratorIndex >= 0) {
        map[line.substring(0, sepratorIndex).trim()] =
            line.substring(sepratorIndex + 1).trim();
      }
    }
  }

  static String get(String key, [String defaultValue = '']) {
    return _items.containsKey(key) ? _items[key]! : defaultValue;
  }

  static Future<void> _addBuildConfig(Map<String, String> map,
      List<String> envFiles, String buildConfig) async {
    final env = 'env/$buildConfig.env';
    final localEnv = 'env/$buildConfig.local.env';

    if (envFiles.contains(env)) {
      await _addFromAsset(map, env);
    }

    if (envFiles.contains(localEnv)) {
      await _addFromAsset(map, localEnv);
    }
  }
}
