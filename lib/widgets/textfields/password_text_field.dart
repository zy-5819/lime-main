import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PasswordTextField extends StatefulWidget {
  ///密码输入框
  const PasswordTextField({
    super.key,
    required this.controller,
    this.hintText,
    this.textInputAction,
    this.suffix,
    this.obscureText,
    this.onEditingComplete,
    this.onChanged,
    this.error = false,
    this.focusNode,
    this.prefixIcon,
    this.margin,
    this.contentPadding,
    this.autoFocus = false,
    this.borderColor,
    this.inputFormatters,
  });

  final TextEditingController controller;
  final String? hintText;
  final TextInputAction? textInputAction;
  final Widget? suffix;
  final bool? obscureText;
  final VoidCallback? onEditingComplete;
  final void Function(String)? onChanged;
  final FocusNode? focusNode;
  final Widget? prefixIcon;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? contentPadding;
  final bool autoFocus;
  final Color? borderColor;

  ///提示输入框内容是否符合要求，当不符合要求时，输入框将显示为错误样式，因为文本高度设置为0，所以将不会显示文本信息
  final bool error;
  final List<TextInputFormatter>? inputFormatters;

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  late ValueNotifier<bool> _hideClearButton;
  late FocusNode _node;

  @override
  void initState() {
    super.initState();
    _node = widget.focusNode ?? FocusNode();
    _node.addListener(() {
      _hideClearButton.value =
          !_node.hasFocus || widget.controller.text.trim().isEmpty;
    });
    _hideClearButton =
        ValueNotifier(widget.controller.text.trim().isEmpty || !_node.hasFocus);
  }

  @override
  void dispose() {
    _hideClearButton.dispose();
    if (widget.focusNode == null) {
      _node.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.margin ?? EdgeInsets.zero,
      child: TextField(
        focusNode: _node,
        controller: widget.controller,
        textAlignVertical: TextAlignVertical.center,
        textInputAction: widget.textInputAction ?? TextInputAction.next,
        obscureText: widget.obscureText ?? true,
        onEditingComplete: _onEditingComplete,
        onChanged: _onChanged,
        autofocus: widget.autoFocus,
        inputFormatters: widget.inputFormatters,
        decoration: InputDecoration(
          contentPadding: widget.contentPadding ?? EdgeInsets.all(16.r),
          isCollapsed: true,
          hintText: widget.hintText,
          errorText: widget.error ? '' : null,
          suffixIcon: _buildSuffix(),
          prefixIcon: widget.prefixIcon,
          errorStyle: const TextStyle(height: 0.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r)),
        ),
      ),
    );
  }

  void _onChanged(String v) {
    widget.onChanged?.call(v);
    _hideClearButton.value = v.trim().isEmpty;
  }

  void _onEditingComplete() {
    widget.onEditingComplete?.call();
  }

  Widget _buildSuffix() {
    return ValueListenableBuilder(
      valueListenable: _hideClearButton,
      builder: (context, bool value, child) {
        if (value) {
          return const SizedBox.shrink();
        } else {
          return IconButton(
            onPressed: () {
              widget.controller.clear();
              widget.onChanged?.call('');
              _hideClearButton.value = true;
            },
            icon: Icon(
              Icons.highlight_off,
              color: Theme.of(context)
                  .colorScheme
                  .onSurfaceVariant
                  .withOpacity(0.5),
            ),
            style: ButtonStyle(
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              minimumSize: WidgetStateProperty.all(Size.zero),
              padding: WidgetStateProperty.all(EdgeInsets.zero),
            ),
          );
        }
      },
    );
  }
}
