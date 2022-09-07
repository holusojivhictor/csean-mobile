import 'package:csean_mobile/presentation/settings/widgets/settings_card.dart';
import 'package:csean_mobile/presentation/settings/widgets/settings_list_tile.dart';
import 'package:flutter/material.dart';

import 'card_header_text.dart';

class AboutCard extends StatelessWidget {
  const AboutCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const CardHeaderText(title: 'ABOUT'),
        SettingsCard(
          child: Column(
            children: [
              SettingsListTile(
                title: 'Content policy',
                leadingIcon: Icons.article_outlined,
                trailing: const Icon(Icons.east),
                onTap: () {},
              ),
              SettingsListTile(
                title: 'Privacy policy',
                leadingIcon: Icons.settings_outlined,
                trailing: const Icon(Icons.east),
                onTap: () {},
              ),
              SettingsListTile(
                title: 'User agreement',
                leadingIcon: Icons.person_outline_rounded,
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
