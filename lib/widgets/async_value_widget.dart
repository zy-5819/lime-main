import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lime/constant/exception_message.dart';
import 'package:lime/widgets/robot_loading_widget.dart';

class AsyncValueWidget<T> extends HookConsumerWidget {
  const AsyncValueWidget({
    Key? key,
    required this.value,
    required this.data,
    this.loading = true,
  }) : super(key: key);

  final AsyncValue<T> value;
  final Widget Function(T) data;
  final bool? loading;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return value.when(
      data: data,
      error: (e, _) {
        debugPrint(e.toString());
        return Center(
          child: Text(
            Em.exception(e),
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: Theme.of(context).colorScheme.primary),
          ),
        );
      },
      loading: () => loading!
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  RobotLoadingWidget(),
                ],
              ),
            )
          : Container(),
    );
  }
}

class AsyncValueRefreshWidget<T> extends HookConsumerWidget {
  const AsyncValueRefreshWidget({
    Key? key,
    required this.value,
    required this.data,
    required this.onRefresh,
  }) : super(key: key);

  final AsyncValue<T> value;
  final Widget Function(T) data;
  final Future<void> Function() onRefresh;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return value.when(
      data: (T t) {
        return RefreshIndicator(
          onRefresh: onRefresh,
          child: data.call(t),
        );
      },
      error: (e, _) {
        return RefreshIndicator(
          onRefresh: onRefresh,
          child: ListView(
            children: [
              SizedBox(height: 0.35.sh),
              Text(
                Em.exception(e),
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: Theme.of(context).colorScheme.primary),
              ),
            ],
          ),
        );
      },
      loading: () => const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            RobotLoadingWidget(),
          ],
        ),
      ),
    );
  }
}

class AsyncValueSliverWidget<T> extends StatelessWidget {
  const AsyncValueSliverWidget({
    Key? key,
    required this.value,
    required this.data,
  }) : super(key: key);

  final AsyncValue<T> value;
  final Widget Function(T) data;
  @override
  Widget build(BuildContext context) {
    return value.when(
      data: data,
      error: (e, _) => SliverToBoxAdapter(
        child: Center(
            child: Text(
          Em.exception(e),
          // '出现错误了…',
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: Theme.of(context).colorScheme.primary),
        )),
      ),
      loading: () => const SliverToBoxAdapter(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
