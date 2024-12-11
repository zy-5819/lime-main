part of '../login_page.dart';

class _WebAddressTextField extends ConsumerStatefulWidget {
  const _WebAddressTextField();

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      __WebAddressTextFieldState();
}

class __WebAddressTextFieldState extends ConsumerState<_WebAddressTextField> {
  final controller = TextEditingController();
  late bool secure;

  @override
  void initState() {
    super.initState();
    var url =
        ref.read(sharedPreferencesProvider).getString(kTestServerUrl) ?? '';
    var params = url.split('://');
    secure = params.isNotEmpty ? params[0] == 'https' : false;
    controller.text = params.length == 2 ? params[1] : '';
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PasswordTextField(
      autoFocus: false,
      prefixIcon: _SecurityButton(
        secure: secure,
        securityChanged: (s) {
          secure = s;
          updateWebAddress();
        },
      ),
      controller: controller,
      onChanged: (v) => updateWebAddress(),
      obscureText: false,
      hintText: "服务器地址",
    );
  }

  void updateWebAddress() {
    ref.read(sharedPreferencesProvider).setString(kTestServerUrl,
        '${(secure ? 'https://' : 'http://')}${controller.text}');
  }
}

class _SecurityButton extends StatefulWidget {
  ///
  const _SecurityButton({
    required this.secure,
    this.securityChanged,
  });

  final bool secure;
  final void Function(bool secure)? securityChanged;

  @override
  State<_SecurityButton> createState() => __SecurityButtonState();
}

class __SecurityButtonState extends State<_SecurityButton> {
  late bool secure;

  @override
  void initState() {
    super.initState();
    secure = widget.secure;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          secure = !secure;
          widget.securityChanged?.call(secure);
        });
      },
      borderRadius: BorderRadius.circular(12.r),
      child: Ink(
        padding: EdgeInsets.all(15.r),
        child: AnimatedCrossFade(
          firstChild: const Icon(
            Icons.lock_outline_rounded,
            color: Colors.green,
          ),
          secondChild: const Icon(
            Icons.lock_open_rounded,
            color: Colors.red,
          ),
          crossFadeState:
              secure ? CrossFadeState.showFirst : CrossFadeState.showSecond,
          duration: const Duration(milliseconds: 300),
        ),
      ),
    );
  }
}
