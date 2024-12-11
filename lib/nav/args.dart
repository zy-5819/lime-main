class VerifyPhoneNumberArguments {
  ///绑定的手机号
  final String phoneNumber;

  ///是否为新绑定的手机号
  final bool newPhone;
  VerifyPhoneNumberArguments(this.phoneNumber, this.newPhone);
}

class MyMobileScannerArgs {
  MyMobileScannerArgs({
    this.onScanned,
    this.onScannedAsync,
  });

  final void Function(String)? onScanned;
  final Future<void> Function(String)? onScannedAsync;
}