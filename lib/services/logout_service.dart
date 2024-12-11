// import 'package:capella_app/constant/strings.dart';
// import 'package:capella_app/constant/styles.dart';
// import 'package:capella_app/controllers/logout_notifier.dart';
// import 'package:capella_app/models/user_access_info.dart';
// import 'package:capella_app/providers/top_level_providers.dart';
// import 'package:flutter/material.dart';
// import 'package:grpc/grpc.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class LogoutService {
//   final Ref _ref;
//   late SharedPreferences _prefs;

//   LogoutService(this._ref) {
//     _prefs = _ref.watch(sharedPreferencesProvider);
//   }

//   String? get _token {
//     return UserAccessInfo.fromString(
//             _prefs.getString(SharedPreferenceKeys.kUserAccess))
//         .token;
//   }

//   @protected
//   CallOptions get options {
//     return CallOptions(
//       timeout: kTimeout,
//       metadata: {'Authorization': 'Bearer $_token'},
//     );
//   }

//   @protected
//   void onLoggedOutDetected() {
//     logoutNotifier.unavailable = true;
//   }
// }

// class FeatureFlagsService extends LogoutService {
//   FeatureFlagsService(super.ref);

//   List<String> get _flags {
//     return (UserAccessInfo.fromString(
//                     _prefs.getString(SharedPreferenceKeys.kUserAccess))
//                 .flags ??
//             'basic')
//         .toLowerCase()
//         .split(',')
//         .map((e) => e.trim())
//         .where((e) => e.isNotEmpty)
//         .toList();
//   }

//   bool get isBasic => _flags.contains('basic');

//   bool get isPro => !isBasic;
// }
