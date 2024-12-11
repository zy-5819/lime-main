// import 'package:capella_app/api/generated/models.pb.dart';
// import 'package:capella_app/models/user_role.dart';
// import 'package:flutter/material.dart';

// extension UserDtoExtensions on UserDto {
//   UserRole get userRole {
//     switch (role) {
//       case 'admin':
//         return UserRole.admin;
//       case 'operator':
//         return UserRole.operator;
//       case 'app-user':
//         return UserRole.appUser;
//     }
//     return UserRole.appUser;
//   }

//   List<String> get flagList {
//     return featureFlags.split(',').toList();
//   }
// }

// extension UserRoleExtensions on UserRole {
//   String get role {
//     switch (this) {
//       case UserRole.admin:
//         return 'admin';
//       case UserRole.operator:
//         return 'operator';
//       case UserRole.appUser:
//         return 'app-user';
//     }
//   }

//   Color get color {
//     switch (this) {
//       case UserRole.admin:
//         return Colors.red;
//       case UserRole.operator:
//         return Colors.orange;
//       case UserRole.appUser:
//         return Colors.blue;
//     }
//   }
// }
