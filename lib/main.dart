import 'package:csean_mobile/application/bloc.dart';
import 'package:csean_mobile/injection.dart';
import 'package:csean_mobile/session_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'domain/services/services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Injection.init();
  runApp(const CseanMobile());
}

class CseanMobile extends StatelessWidget {
  const CseanMobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (ctx) {
            final cseanService = getIt<CseanService>();
            final loggingService = getIt<LoggingService>();
            return SessionBloc(
              cseanService,
              loggingService,
            )..add(const SessionEvent.appStarted(init: true));
          },
        ),
        BlocProvider(
          create: (ctx) {
            final authService = getIt<AuthService>();
            return SignInBloc(authService, ctx.read<SessionBloc>());
          },
        ),
        BlocProvider(
          create: (ctx) {
            final authService = getIt<AuthService>();
            return SignUpBloc(authService, ctx.read<SessionBloc>());
          },
        ),
        BlocProvider(create: (ctx) {
          final cseanService = getIt<CseanService>();
          return OnboardingBloc(cseanService);
        }),
        BlocProvider(create: (ctx) => MainTabBloc()),
        BlocProvider(
          create: (ctx) {
            final cseanService = getIt<CseanService>();
            final settingsService = getIt<SettingsService>();
            return HomeBloc(cseanService, settingsService);
          },
        ),
        BlocProvider(
          create: (ctx) {
            final cseanService = getIt<CseanService>();
            final settingsService = getIt<SettingsService>();
            return ProfileBloc(
              cseanService,
              settingsService,
            );
          },
        ),
        BlocProvider(
          create: (ctx) {
            final cseanService = getIt<CseanService>();
            return CommunityEventsBloc(cseanService);
          },
        ),
        BlocProvider(
          create: (ctx) {
            final cseanService = getIt<CseanService>();
            return CommunityEventBloc(cseanService);
          },
        ),
        BlocProvider(
          create: (ctx) {
            final cseanService = getIt<CseanService>();
            return TransactionsBloc(cseanService);
          },
        ),
        BlocProvider(
          create: (ctx) {
            final cseanService = getIt<CseanService>();
            return PaymentBloc(cseanService);
          },
        ),
        BlocProvider(
          create: (ctx) {
            final cseanService = getIt<CseanService>();
            return SupportBloc(cseanService);
          },
        ),
        BlocProvider(
          create: (ctx) {
            final cseanService = getIt<CseanService>();
            return BlogsBloc(cseanService);
          },
        ),
        BlocProvider(
          create: (ctx) {
            final cseanService = getIt<CseanService>();
            return BlogBloc(cseanService);
          },
        ),
        BlocProvider(
          create: (ctx) {
            final cseanService = getIt<CseanService>();
            return MessagesBloc(cseanService);
          },
        ),
        BlocProvider(
          create: (ctx) {
            final cseanService = getIt<CseanService>();
            return ProgressTrackerBloc(cseanService);
          },
        ),
        BlocProvider(
          create: (ctx) {
            final cseanService = getIt<CseanService>();
            return ProgressRequestBloc(cseanService);
          },
        ),
        BlocProvider(
          create: (ctx) {
            final cseanService = getIt<CseanService>();
            return DataBloc(
              cseanService,
              ctx.read<CommunityEventBloc>(),
              ctx.read<CommunityEventsBloc>(),
              ctx.read<MessagesBloc>(),
              ctx.read<ProfileBloc>(),
              ctx.read<HomeBloc>(),
              ctx.read<TransactionsBloc>(),
              ctx.read<PaymentBloc>(),
              ctx.read<ProgressTrackerBloc>(),
              ctx.read<SupportBloc>(),
            );
          },
        ),
        BlocProvider(
          create: (ctx) {
            final cseanService = getIt<CseanService>();
            return ForumsBloc(cseanService);
          },
        ),
        BlocProvider(
          create: (ctx) {
            final cseanService = getIt<CseanService>();
            return ResourcesBloc(cseanService);
          },
        ),
        BlocProvider(
          create: (ctx) {
            final cseanService = getIt<CseanService>();
            return ResourceBloc(cseanService);
          },
        ),
        BlocProvider(
          create: (ctx) {
            final cseanService = getIt<CseanService>();
            return TopicsBloc(cseanService);
          },
        ),
        BlocProvider(
          create: (ctx) {
            final loggingService = getIt<LoggingService>();
            final settingsService = getIt<SettingsService>();
            final deviceInfoService = getIt<DeviceInfoService>();
            return MainBloc(
              loggingService,
              settingsService,
              deviceInfoService,
            )..add(const MainEvent.init());
          },
        ),
        BlocProvider(
          create: (ctx) {
            final settingsService = getIt<SettingsService>();
            final deviceInfoService = getIt<DeviceInfoService>();
            return SettingsBloc(settingsService, deviceInfoService, ctx.read<MainBloc>());
          },
        ),
      ],
      child: BlocBuilder<SessionBloc, SessionState>(
        builder: (ctx, state) => const SessionWrapper(),
      ),
    );
  }
}
