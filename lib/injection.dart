import 'package:csean_mobile/infrastructure/forum_service.dart';
import 'package:csean_mobile/infrastructure/payment_service.dart';
import 'package:csean_mobile/infrastructure/profile_service.dart';
import 'package:csean_mobile/infrastructure/support_service.dart';

import 'domain/services/services.dart';
import 'infrastructure/infrastructure.dart';
import 'package:get_it/get_it.dart';

final GetIt getIt = GetIt.instance;

class Injection {
  static Future<void> init() async {
    final deviceInfoService = DeviceInfoServiceImpl();
    getIt.registerSingleton<DeviceInfoService>(deviceInfoService);
    await deviceInfoService.init();

    final loggingService = LoggingServiceImpl();
    getIt.registerSingleton<LoggingService>(loggingService);

    final authService = AuthServiceImpl();
    getIt.registerSingleton<AuthService>(authService);

    final onboardingService = OnboardingServiceImpl();
    getIt.registerSingleton<OnboardingService>(onboardingService);

    final profileService = ProfileServiceImpl();
    getIt.registerSingleton<ProfileService>(profileService);

    final eventsService = EventsServiceImpl();
    getIt.registerSingleton<EventsService>(eventsService);

    final resourcesService = ResourcesServiceImpl();
    getIt.registerSingleton<ResourcesService>(resourcesService);

    final forumService = ForumServiceImpl();
    getIt.registerSingleton<ForumService>(forumService);

    final progressTrackerService = ProgressTrackerServiceImpl();
    getIt.registerSingleton<ProgressTrackerService>(progressTrackerService);

    final paymentService = PaymentServiceImpl();
    getIt.registerSingleton<PaymentService>(paymentService);

    final supportService = SupportServiceImpl();
    getIt.registerSingleton<SupportService>(supportService);

    final settingsService = SettingsServiceImpl(loggingService);
    await settingsService.init();
    getIt.registerSingleton<SettingsService>(settingsService);
    getIt.registerSingleton<CseanService>(CseanServiceImpl(
      authService,
      onboardingService,
      eventsService,
      resourcesService,
      forumService,
      profileService,
      progressTrackerService,
      paymentService,
      supportService,
    ));
  }
}