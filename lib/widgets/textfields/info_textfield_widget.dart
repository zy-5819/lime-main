import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class InfoTextFieldWidget extends StatefulHookConsumerWidget {
  const InfoTextFieldWidget(
      {super.key,
      this.name = '',
      this.description = '',
      this.buttonContent = const Text('修改'),
      this.onSave,
      this.hintText});

  final String name;
  final String description;
  final Widget buttonContent;
  final void Function(String name, String description)? onSave;
  final String? hintText;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _InfoTextfieldWidget2State();
}

class _InfoTextfieldWidget2State extends ConsumerState<InfoTextFieldWidget> {
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late ValueNotifier<bool> _emptyName;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _descriptionController = TextEditingController();
    _emptyName = ValueNotifier(widget.name.trim().isEmpty);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _emptyName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _nameController.value = TextEditingValue(
      text: widget.name,
      selection: TextSelection.fromPosition(
        TextPosition(
          affinity: TextAffinity.downstream,
          offset: widget.name.length,
        ),
      ),
    );

    _descriptionController.value = TextEditingValue(
      text: widget.description,
      selection: TextSelection.fromPosition(
        TextPosition(
            affinity: TextAffinity.downstream,
            offset: widget.description.length),
      ),
    );
    return Column(
      children: [
        SizedBox(height: 10.h),
        InfoTextField(
          controller: _nameController,
          label: '名 称',
          autofocus: true,
          maxLines: 1,
          onTextChanged: (v) => _emptyName.value = v.trim().isEmpty,
          hintText: widget.hintText,
        ),
        SizedBox(height: 10.h),
        InfoTextField(
          controller: _descriptionController,
          label: '备 注',
          maxLines: null,
          hintText: '请输入备注信息',
        ),
        SizedBox(height: 10.h),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 5.w),
          width: double.infinity,
          child: ValueListenableBuilder(
            valueListenable: _emptyName,
            builder: (context, bool value, child) {
              return ElevatedButton(
                // style: ButtonStyle(
                //     backgroundColor: MaterialStateProperty.all(
                //         Theme.of(context).colorScheme.surface)),
                onPressed: value
                    ? null
                    : () => widget.onSave?.call(
                          _nameController.text,
                          _descriptionController.text,
                        ),
                child: widget.buttonContent,
              );
            },
          ),
        )
      ],
    );
  }
}

class InfoTextField extends ConsumerStatefulWidget {
  const InfoTextField({
    Key? key,
    required this.controller,
    required this.label,
    this.autofocus = false,
    this.maxLines,
    this.onTextChanged,
    this.hintText,
    this.margin,
    this.onEditingComplete,
  }) : super(key: key);

  final TextEditingController controller;
  final String label;
  final bool autofocus;
  final int? maxLines;
  final void Function(String)? onTextChanged;
  final String? hintText;
  final EdgeInsetsGeometry? margin;
  final VoidCallback? onEditingComplete;

  @override
  ConsumerState<InfoTextField> createState() => _InfoTextFieldState();
}

class _InfoTextFieldState extends ConsumerState<InfoTextField> {
  late AutoDisposeStateProvider<bool> _isEmptyProvider;

  @override
  void initState() {
    super.initState();
    _isEmptyProvider = StateProvider.autoDispose<bool>(
        (ref) => widget.controller.text.trim().isEmpty);
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isEmpty = ref.watch(_isEmptyProvider);
    return Container(
      padding: EdgeInsets.only(left: 24.w, top: 4.h, bottom: 4.h),
      margin: widget.margin,
      decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            widget.label,
            style: TextStyle(
              fontSize: 16.sp,
              color: Colors.grey,
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: TextField(
              style: TextStyle(fontSize: 15.sp),
              maxLines: widget.maxLines,
              minLines: 1,
              autofocus: widget.autofocus,
              controller: widget.controller,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              textAlignVertical: isEmpty ? null : TextAlignVertical.center,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  suffixIcon: isEmpty
                      ? null
                      : IconButton(
                          onPressed: () {
                            widget.controller.clear();
                            widget.onTextChanged?.call('');
                            ref
                                .read(_isEmptyProvider.notifier)
                                .update((state) => true);
                          },
                          icon: Icon(Icons.highlight_off,
                              color: cs.surfaceContainerHighest),
                        ),
                  hintText: widget.hintText),
              onChanged: (v) {
                widget.onTextChanged?.call(v);
                ref
                    .read(_isEmptyProvider.notifier)
                    .update((state) => v.trim().isEmpty);
              },
              onEditingComplete: widget.onEditingComplete,
            ),
          )
        ],
      ),
    );
  }
}
