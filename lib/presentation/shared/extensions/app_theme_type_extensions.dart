import 'package:csean_mobile/domain/enums/enum.dart';
import 'package:csean_mobile/theme.dart';
import 'package:flutter/material.dart';

extension AppThemeTypeExtensions on AppThemeType {
  ThemeData getThemeData(AppThemeType theme) {
    switch (theme) {
      case AppThemeType.light:
        return CseanMobileTheme.light();
      case AppThemeType.dark:
        return CseanMobileTheme.dark();
      default:
        throw Exception('Invalid theme type = $theme');
    }
  }

  bool darkMode() {
    switch (this) {
      case AppThemeType.light:
        return false;
      case AppThemeType.dark:
        return true;
      default:
        throw Exception('Invalid theme type = $this');
    }
  }
}