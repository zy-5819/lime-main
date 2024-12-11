// import 'package:capella_app/api/generated/app/account.pbgrpc.dart';
// import 'package:grpc/grpc.dart';
// import 'package:capella_app/services/channel.dart';

// class Account {
//   final stub = AccountRpcClient(channel);

//   Future<String?> checkPhoneNumberAvailability(String phonenumber) async {
//     try {
//       await stub.checkPhoneNumberAvailability(
//           PhoneNumberCheckRequest(phoneNumber: phonenumber));
//       return null;
//     } on GrpcError catch (e) {
//       return e.message;
//     }
//   }

//   Future<String?> checkUserNameAvailability(String? username) async {
//     if (username == "") return "用户名不能为空";
//     try {
//       await stub
//           .checkUserNameAvailability(UserNameCheckRequest(userName: username));
//       return null;
//     } on GrpcError catch (e) {
//       return e.message;
//     }
//   }

//   Future<String?> register(String? userName, String? displayName,
//       String? password, String? sessionId, String? vCode) async {
//     try {
//       await stub.register(AccountRegisterRequest(
//           userName: userName,
//           displayName: displayName,
//           password: password,
//           verificationSessionId: sessionId,
//           verificationCode: vCode));
//       return null;
//     } on GrpcError catch (e) {
//       return e.message;
//     }
//   }
// }
