import 'dart:async';
import 'dart:ui';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lime/constant/strings.dart';
import 'package:lime/models/server_version.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();
final sharedPreferencesProvider =
    Provider<SharedPreferences>((ref) => throw UnimplementedError());

final serverVersionProvider = Provider.autoDispose<String>((ref) {
  return ref.watch(sharedPreferencesProvider).getString(kServerVersion) ??
      ServerVersion.official.toString();
});