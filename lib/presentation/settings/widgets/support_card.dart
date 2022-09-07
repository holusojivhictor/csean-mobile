import 'package:csean_mobile/presentation/settings/widgets/settings_card.dart';
import 'package:flutter/material.dart';

import 'card_header_text.dart';
import 'settings_list_tile.dart';

class SupportCard extends StatelessWidget {
  const SupportCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const CardHeaderText(title: 'SUPPORT'),
        SettingsCard(
          child: Column(
            children: [
              SettingsListTile(
                title: 'Help center',
                leadingIcon: Icons.help_outline_outlined,
                trailing: const Icon(Icons.east),
                onTap: () {},
              ),
              SettingsListTile(
                title: 'Report an issue',
                leadingIcon: Icons.mail_outline_outlined,
                trailing: const Icon(Icons.east),
                onTap: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }
}
