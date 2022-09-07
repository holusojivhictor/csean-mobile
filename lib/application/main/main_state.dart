part of 'main_bloc.dart';

@freezed
class MainState with _$MainState {
  const factory MainState.loading() = _MainLoadingState;
  const factory MainState.loaded({
    required String appTitle,
    required AppThemeType theme,
    required AutoThemeModeType autoThemeMode,
    required bool initialized,
    required bool firstInstall,
    required bool versionChanged,
  }) = _MainLoadedState;

  const MainState._();
}