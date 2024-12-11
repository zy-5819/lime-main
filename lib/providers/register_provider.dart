import 'package:hooks_riverpod/hooks_riverpod.dart';

final phonePdr = StateProvider.autoDispose((ref) => "");
final userNamePdr = StateProvider.autoDispose((ref) => "");
final displayNamePdr = StateProvider.autoDispose((ref) => "");
final passwordPdr = StateProvider.autoDispose((ref) => "");
final password2Pdr = StateProvider.autoDispose((ref) => "");
final vCodePdr = StateProvider.autoDispose((ref) => "");

enum RegisterTag {
  userName,
  displayName,
  password,
  password2,
  phone,
  vCode,
}

final registerTextPdr =
    Provider.family<AutoDisposeStateProvider<String>, RegisterTag>((ref, tag) {
  switch (tag) {
    case RegisterTag.userName:
      return userNamePdr;
    case RegisterTag.displayName:
      return displayNamePdr;
    case RegisterTag.password:
      return passwordPdr;
    case RegisterTag.password2:
      return password2Pdr;
    case RegisterTag.phone:
      return phonePdr;
    case RegisterTag.vCode:
      return vCodePdr;
  }
});
