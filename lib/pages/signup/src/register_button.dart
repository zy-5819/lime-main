part of '../signup_page.dart';

class _RegisterButton extends HookConsumerWidget {
  final GlobalKey<FormState> formKey;
  //final Account account;
  final String? userName;
  final String? displayName;
  final String? password;
  final String? sessionId;
  final String? vCode;

  const _RegisterButton({
    required this.formKey,
    //required this.account,
    this.userName,
    this.displayName,
    this.password,
    this.sessionId,
    this.vCode,
  });

  Future<void> _register(
    //Account account,
    String? userName,
    String? displayName,
    String? password,
    String? sessionId,
    String? vCode,
    BuildContext context,
    WidgetRef ref,
    Future<void> Function(String) onAlert,
  ) async {
    // final navigator = Navigator.of(context);
    // if (!ref.watch(_isCheckedProvider)) {
    //   await Fluttertoast.showToast(msg: '请先同意用户协议');
    //   return;
    // }

    // final msg = await account.register(
    //     userName, displayName, password, sessionId, vCode);
    // if (msg != null) {
    //   await onAlert(msg);
    // } else {
    //   navigator.pop();
    //   await Fluttertoast.showToast(
    //     msg: "注册成功",
    //     toastLength: Toast.LENGTH_SHORT,
    //     timeInSecForIosWeb: 1,
    //   );
    // }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () async {
            // if (formKey.currentState!.validate()) {
            //   await _register(
            //     account,
            //     userName,
            //     displayName,
            //     password,
            //     sessionId,
            //     vCode,
            //     context,
            //     ref,
            //     (message) => showOkAlertDialog(
            //         context: context, message: message, okLabel: "确定"),
            //   );
            // } else {
            //   await showOkAlertDialog(
            //       context: context, message: "存在信息填写错误，请更正后重试！");
            // }
          },
          child: const Text("注册"),
        ),
      ),
    );
  }
}
