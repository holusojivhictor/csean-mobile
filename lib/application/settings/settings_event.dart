part of 'settings_bloc.dart';

@freezed
class SettingsEvent with _$SettingsEvent {
  const factory SettingsEvent.init() = _Init;

  const factory SettingsEvent.themeChanged({
    required AppThemeType newValue,
  }) = _ThemeChanged;

  const factory SettingsEvent.languageChanged({
    required AppLanguageType newValue,
  }) = _LanguageChanged;

  const factory SettingsEvent.doubleBackToCloseChanged({
    required bool newValue,
  }) = _DoubleBackToCloseChanged;

  const factory SettingsEvent.isProfileHeaderSetChanged({
    required bool newValue,
  }) = _IsProfileHeaderSetChanged;

  const factory SettingsEvent.useDemoProfilePictureChanged({
    required bool newValue,
  }) = _UseDemoProfilePictureChanged;

  const factory SettingsEvent.autoThemeModeTypeChanged({
    required AutoThemeModeType newValue,
  }) = _AutoThemeModeTypeChanged;
}