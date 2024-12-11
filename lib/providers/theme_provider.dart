import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lime/constant/strings.dart';
import 'package:lime/providers/top_level_providers.dart';
import 'package:lime/theme/capella_theme.dart';

class ThemeNotifier extends StateNotifier<ThemeType> {
  ThemeNotifier([ThemeType? theme]) : super(theme ?? ThemeType.purple);

  void update(ThemeType? theme) {
    if (theme != null) state = theme;
  }
}

final themeProvider =
    StateNotifierProvider.autoDispose<ThemeNotifier, ThemeType>((ref) {
  final theme =
      _getThemeColor(ref.watch(sharedPreferencesProvider).getString(kTheme));
  return ThemeNotifier(theme);
});

ThemeType _getThemeColor(String? theme) {
  for (var v in ThemeType.values) {
    if (v.toString() == theme) {
      return v;
    }
  }
  return ThemeType.yellow;
}
