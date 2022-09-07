import 'package:csean_mobile/presentation/settings/widgets/about_card.dart';
import 'package:csean_mobile/presentation/settings/widgets/account_card.dart';
import 'package:csean_mobile/presentation/settings/widgets/build_version_card.dart';
import 'package:csean_mobile/presentation/settings/widgets/display_settings_card.dart';
import 'package:csean_mobile/presentation/settings/widgets/log_out_card.dart';
import 'package:csean_mobile/presentation/settings/widgets/support_card.dart';
import 'package:csean_mobile/presentation/settings/widgets/view_options_card.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ResponsiveBuilder(
          builder: (ctx, size) => ListView(
            shrinkWrap: true,
            children: const [
              AccountCard(),
              DisplaySettingsCard(),
              ViewOptionsCard(),
              AboutCard(),
              SupportCard(),
              BuildVersionCard(),
              LogOutCard(),
            ],
          ),
        ),
      ),
    );
  }
}
