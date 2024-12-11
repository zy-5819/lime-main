part of '../signup_page.dart';

// final _accountProvider = Provider<Account>((ref) => Account());
// final _authProvider = Provider<AuthService>((ref) => AuthService(ref));

final _signupUserNameProvider = StateProvider.autoDispose((ref) => "");
//final _signupDisplayNameProvider = StateProvider.autoDispose((ref) => "");
final _signupPwdProvider = StateProvider.autoDispose((ref) => "");
final _signupPwd2Provider = StateProvider.autoDispose((ref) => "");
//final _signupPhoneProvider = StateProvider.autoDispose((ref) => "");
//final _signupVCodeProvider = StateProvider.autoDispose((ref) => "");

final _usernameErrorProvider =
    StateProvider.autoDispose<String?>((ref) => null);
//final _pwdErrorProvider = StateProvider.autoDispose<String?>((ref) => null);
//final _pwd2ErrorProvider = StateProvider.autoDispose<String?>((ref) => null);
final _phoneErrorProvider = StateProvider.autoDispose<String?>((ref) => null);

final _signupVerifyStrProvider =
    StateProvider.autoDispose<String>((ref) => "获取验证码");
final _signupIsAvailableGetVCodeProvider =
    StateProvider.autoDispose<bool>((ref) => true);

final _isCheckedProvider = StateProvider((ref) {
  return false;
});

final signupSessionIdProvider = StateProvider.autoDispose((ref) => "");
