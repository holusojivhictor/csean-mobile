part of 'main_bloc.dart';

@freezed
class MainEvent with _$MainEvent {
  const factory MainEvent.init() = _Init;

  const factory MainEvent.themeChanged({
    required AppThemeType newValue,
  }) = _ThemeChanged;

  const factory MainEvent.themeModeChanged({
    required AutoThemeModeType newValue,
  }) = _ThemeModeChanged;
}