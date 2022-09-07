import 'package:csean_mobile/application/bloc.dart';
import 'package:csean_mobile/domain/enums/enum.dart';
import 'package:csean_mobile/domain/services/device_info_service.dart';
import 'package:csean_mobile/domain/services/settings_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'settings_bloc.freezed.dart';
part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final SettingsService _settingsService;
  final DeviceInfoService _deviceInfoService;
  final MainBloc _mainBloc;

  SettingsBloc(
    this._settingsService,
    this._deviceInfoService,
    this._mainBloc,
  ) : super(const SettingsState.loading());

  _LoadedState get currentState => state as _LoadedState;

  @override
  Stream<SettingsState> mapEventToState(SettingsEvent event) async* {
    final s = await event.map(
      init: (_) async {
        final settings = _settingsService.appSettings;
        return SettingsState.loaded(
          currentTheme: settings.appTheme,
          currentLanguage: settings.appLanguage,
          appVersion: _deviceInfoService.version,
          doubleBackToClose: settings.doubleBackToClose,
          isProfileHeaderSet: settings.isProfileHeaderSet,
          useDemoProfilePicture: settings.useDemoImage,
          themeMode: settings.themeMode,
        );
      },
      themeChanged: (event) async {
        if (event.newValue == _settingsService.appTheme) {
          return currentState;
        }
        _settingsService.appTheme = event.newValue;
        _mainBloc.add(MainEvent.themeChanged(newValue: event.newValue));
        return currentState.copyWith.call(currentTheme: event.newValue);
      },
      languageChanged: (event) async {
        if (event.newValue == _settingsService.language) {
          return currentState;
        }
        _settingsService.language = event.newValue;
        return currentState.copyWith.call(currentLanguage: event.newValue);
      },
      doubleBackToCloseChanged: (event) async {
        _settingsService.doubleBackToClose = event.newValue;
        return currentState.copyWith.call(doubleBackToClose: event.newValue);
      },
      isProfileHeaderSetChanged: (event) async {
        _settingsService.isProfileHeaderSet = event.newValue;
        return currentState.copyWith.call(isProfileHeaderSet: event.newValue);
      },
      useDemoProfilePictureChanged: (event) async {
        _settingsService.useDemoImage = event.newValue;
        return currentState.copyWith.call(useDemoProfilePicture: event.newValue);
      },
      autoThemeModeTypeChanged: (event) async {
        if (event.newValue == _settingsService.autoThemeMode) {
          return currentState;
        }
        _settingsService.autoThemeMode = event.newValue;
        _mainBloc.add(MainEvent.themeModeChanged(newValue: event.newValue));
        return currentState.copyWith.call(themeMode: event.newValue);
      },
    );

    yield s;
  }

  bool doubleBackToClose() => _settingsService.doubleBackToClose;
}
