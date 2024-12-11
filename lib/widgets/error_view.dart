import 'package:flutter/material.dart';

class ErrorView extends StatelessWidget {
  const ErrorView({super.key, this.errorMsg});

  final String? errorMsg;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        errorMsg ?? '',
        style: Theme.of(context)
            .textTheme
            .titleLarge!
            .copyWith(color: Theme.of(context).colorScheme.primary),
      ),
    );
  }
}
