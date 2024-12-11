import 'package:hooks_riverpod/hooks_riverpod.dart';

extension AsyncValueExtensions<T> on AsyncValue<T> {
  T valueOrDefault(T defaultValue) {
    return maybeWhen(data: (data) => data, orElse: () => defaultValue);
  }
}
