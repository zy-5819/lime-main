part of '../message_page.dart';

class _ExceptionMessage extends HookConsumerWidget {
  const _ExceptionMessage();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const EmptyScreen(
      title: '暂无异常消息',
      canClick: false,
    );
  }
}
