import 'package:csean_mobile/application/bloc.dart';
import 'package:csean_mobile/domain/enums/enum.dart';
import 'package:csean_mobile/presentation/main_tab_page.dart';
import 'package:csean_mobile/presentation/shared/extensions/app_theme_type_extensions.dart';
import 'package:csean_mobile/presentation/shared/loading.dart';
import 'package:csean_mobile/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainBloc, MainState>(
      builder: (ctx, state) => state.map<Widget>(
        loading: (_) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: CseanMobileTheme.light(),
            home: const Loading(),
          );
        },
        loaded: (s) {
          final autoThemeModeOn = s.autoThemeMode == AutoThemeModeType.on;
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: s.appTitle,
            theme: autoThemeModeOn ? CseanMobileTheme.light() : s.theme.getThemeData(s.theme),
            darkTheme: autoThemeModeOn ? CseanMobileTheme.dark() : null,
            home: const MainTabPage(),
          );
        },
      ),
    );
  }
}
