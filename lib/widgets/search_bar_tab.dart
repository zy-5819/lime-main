import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchBarTab extends StatefulWidget {
  const SearchBarTab({
    super.key,
    this.controller,
    this.height,
    this.onSubmit,
    this.hintText,
    this.onChanged,
  });

  final TextEditingController? controller;
  final double? height;
  final void Function(String)? onSubmit;
  final String? hintText;
  final void Function(String)? onChanged;

  @override
  State<SearchBarTab> createState() => _SearchBarTabState();
}

class _SearchBarTabState extends State<SearchBarTab> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = widget.controller ?? TextEditingController();
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 56.h,
        child: Row(children: [
          Expanded(
            child: TextField(
              style: TextStyle(fontSize: 16.sp),
              maxLines: 1,
              minLines: 1,
              autofocus: false,
              controller: controller,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.done,
              onSubmitted: widget.onSubmit,
              onChanged: widget.onChanged,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.onPrimary)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.primary)),
                prefixIcon: const Icon(Icons.search),
                suffixIcon: AnimatedBuilder(
                    animation: controller,
                    builder: ((context, child) => controller.text == ""
                        ? const SizedBox.shrink()
                        : IconButton(
                            onPressed: () {
                              controller.clear();
                              widget.onSubmit?.call("");
                            },
                            icon: const Icon(Icons.highlight_off),
                          ))),
                hintText: widget.hintText,
              ),
            ),
          )
        ]));
  }
}
