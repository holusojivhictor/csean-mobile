import 'package:csean_mobile/domain/enums/enum.dart';
import 'package:csean_mobile/domain/services/device_info_service.dart';
import 'package:csean_mobile/domain/services/logging_service.dart';
import 'package:csean_mobile/domain/services/settings_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'main_bloc.freezed.dart';
part 'main_event.dart';
part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  final LoggingService _logger;
  final SettingsService _settingsService;
  final DeviceInfoService _deviceInfoService;

  MainBloc(this._logger, this._settingsService, this._deviceInfoService) : super(const MainState.loading());

  _MainLoadedState get currentState => state as _MainLoadedState;

  @override
  Stream<MainState> mapEventToState(MainEvent event) async* {
    final s = await event.when(
      init: () async => _init(init: true),
      themeChanged: (theme) async => _loadAppData(theme, _settingsService.autoThemeMode),
      themeModeChanged: (themeMode) async => _loadAppData(_settingsService.appTheme, themeMode),
    );
    yield s;
  }

  Future<MainState> _init({bool init = false}) async {
    _logger.info(runtimeType, '_init: Initializing all...');

    final settings = _settingsService.appSettings;

    final state = _loadAppData(settings.appTheme, settings.themeMode);

    if (init) {
      await Future.delayed(const Duration(milliseconds: 100));
    }

    return state;
  }

  Future<MainState> _loadAppData(AppThemeType theme, AutoThemeModeType autoThemeMode, {bool isInitialized = true}) async {
    _logger.info(runtimeType, '_init: Is first install = ${_settingsService.isFirstInstall}' '-- versionChanged = ${_deviceInfoService.versionChanged}');

    return MainState.loaded(
      appTitle: _deviceInfoService.appName,
      initialized: isInitialized,
      theme: theme,
      autoThemeMode: autoThemeMode,
      firstInstall: _settingsService.isFirstInstall,
      versionChanged: _deviceInfoService.versionChanged,
    );
  }
}