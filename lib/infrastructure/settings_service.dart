import 'package:collection/collection.dart' show IterableExtension;
import 'package:csean_mobile/domain/app_constants.dart';
import 'package:csean_mobile/domain/enums/enum.dart';
import 'package:csean_mobile/domain/models/model.dart';
import 'package:csean_mobile/domain/services/logging_service.dart';
import 'package:csean_mobile/domain/services/settings_service.dart';
import 'package:devicelocale/devicelocale.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsServiceImpl extends SettingsService {
  final _appThemeKey = 'AppTheme';
  final _appLanguageKey = 'AppLanguageKey';
  final _isFirstInstallKey = 'FirstInstall';
  final _doubleBackToCloseKey = 'DoubleBackToCloseKey';
  final _isProfileHeaderSetKey = 'ProfileHeaderSetKey';
  final _headerPathKey = 'HeaderPathKey';
  final _useDemoImageKey = 'UseDemoImageKey';
  final _autoThemeModeKey = 'AutoThemeModeKey';

  bool _initialized = false;

  late SharedPreferences _prefs;
  final LoggingService _logger;

  SettingsServiceImpl(this._logger);

  @override
  AppThemeType get appTheme => AppThemeType.values[_prefs.getInt(_appThemeKey)!];

  @override
  set appTheme(AppThemeType theme) => _prefs.setInt(_appThemeKey, theme.index);

  @override
  AppLanguageType get language => AppLanguageType.values[_prefs.getInt(_appLanguageKey)!];

  @override
  set language(AppLanguageType lang) => _prefs.setInt(_appLanguageKey, lang.index);

  @override
  bool get isFirstInstall => _prefs.getBool(_isFirstInstallKey)!;

  @override
  set isFirstInstall(bool itIs) => _prefs.setBool(_isFirstInstallKey, itIs);

  @override
  bool get doubleBackToClose => _prefs.getBool(_doubleBackToCloseKey)!;

  @override
  set doubleBackToClose(bool value) => _prefs.setBool(_doubleBackToCloseKey, value);

  @override
  bool get isProfileHeaderSet => _prefs.getBool(_isProfileHeaderSetKey)!;

  @override
  set isProfileHeaderSet(bool value) => _prefs.setBool(_isProfileHeaderSetKey, value);

  @override
  String get headerPath => _prefs.getString(_headerPathKey)!;

  @override
  set headerPath(String value) => _prefs.setString(_headerPathKey, value);

  @override
  bool get useDemoImage => _prefs.getBool(_useDemoImageKey)!;

  @override
  set useDemoImage(bool value) => _prefs.setBool(_useDemoImageKey, value);

  @override
  AutoThemeModeType get autoThemeMode => AutoThemeModeType.values[_prefs.getInt(_autoThemeModeKey)!];

  @override
  set autoThemeMode(AutoThemeModeType themeMode) => _prefs.setInt(_autoThemeModeKey, themeMode.index);

  @override
  AppSettings get appSettings => AppSettings(
    appTheme: appTheme,
    appLanguage: language,
    useDarkMode: false,
    isFirstInstall: isFirstInstall,
    doubleBackToClose: doubleBackToClose,
    isProfileHeaderSet: isProfileHeaderSet,
    useDemoImage: useDemoImage,
    themeMode: autoThemeMode,
  );

  @override
  Future<void> init() async {
    if (_initialized) {
      _logger.info(runtimeType, 'Settings are already initialized!');
      return;
    }

    _logger.info(runtimeType, 'Initializing settings...Getting shared preferences instance...');

    _prefs = await SharedPreferences.getInstance();

    if (_prefs.get(_isFirstInstallKey) == null) {
      _logger.info(runtimeType, 'This is the first install of the app');
      isFirstInstall = true;
    }

    if (_prefs.get(_appThemeKey) == null) {
      _logger.info(runtimeType, 'Setting light as the default theme');
      appTheme = AppThemeType.light;
    }

    if (_prefs.get(_appLanguageKey) == null) {
      language = await _getDefaultLangToUse();
    }

    if (_prefs.get(_doubleBackToCloseKey) == null) {
      _logger.info(runtimeType, 'Double back to close will be set to its default (true)');
      doubleBackToClose = true;
    }

    if (_prefs.get(_isProfileHeaderSetKey) == null) {
      _logger.info(runtimeType, 'Is profile header set will be set to its default (false)');
      isProfileHeaderSet = false;
    }

    if (_prefs.get(_headerPathKey) == null) {
      headerPath = '';
    }

    if (_prefs.get(_useDemoImageKey) == null) {
      _logger.info(runtimeType, 'Use demo image will be set to its default (false)');
      useDemoImage = false;
    }

    if (_prefs.get(_autoThemeModeKey) == null) {
      _logger.info(runtimeType, 'Auto theme mode set to true as default');
      autoThemeMode = AutoThemeModeType.off;
    }

    _initialized = true;
    _logger.info(runtimeType, 'Settings were initialized successfully');
  }

  Future<AppLanguageType> _getDefaultLangToUse() async {
    try {
      _logger.info(runtimeType, '_getDefaultLangToUse: Trying to retrieve device lang...');
      final deviceLocale = await Devicelocale.currentAsLocale;
      if (deviceLocale == null) {
        _logger.warning(
          runtimeType,
          "_getDefaultLangToUse: Couldn't retrieve the device locale, defaulting to english",
        );
        return AppLanguageType.english;
      }

      final appLang = languagesMap.entries.firstWhereOrNull((val) => val.value.code == deviceLocale.languageCode);
      if (appLang == null) {
        _logger.info(
          runtimeType,
          "_getDefaultLangToUse: Couldn't find an appropriate app language for = ${deviceLocale.languageCode}_${deviceLocale.countryCode}, defaulting to english",
        );
        return AppLanguageType.english;
      }

      _logger.info(
        runtimeType,
        '_getDefaultLangToUse: Found an appropriate language to use for = ${deviceLocale.languageCode}_${deviceLocale.countryCode}, that is = ${appLang.key}',
      );
      return appLang.key;
    } catch (e, s) {
      _logger.error(runtimeType, '_getDefaultLangToUse: Unknown error occurred', e, s);
      return AppLanguageType.english;
    }
  }
}