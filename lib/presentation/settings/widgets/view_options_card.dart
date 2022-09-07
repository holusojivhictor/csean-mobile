import 'package:csean_mobile/application/bloc.dart';
import 'package:csean_mobile/domain/assets.dart';
import 'package:csean_mobile/domain/enums/enum.dart';
import 'package:csean_mobile/presentation/settings/widgets/settings_card.dart';
import 'package:csean_mobile/presentation/shared/item_popup_menu_filter.dart';
import 'package:csean_mobile/presentation/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'card_header_text.dart';
import 'settings_list_tile.dart';
import 'settings_switch_list_tile.dart';

class ViewOptionsCard extends StatelessWidget {
  const ViewOptionsCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const CardHeaderText(title: 'VIEW OPTIONS'),
        SettingsCard(
          child: BlocBuilder<SettingsBloc, SettingsState>(
            builder: (ctx, state) => state.map(
              loading: (_) => const Loading(useScaffold: false),
              loaded: (state) => Column(
                children: [
                  SettingsListTile(
                    title: 'Language',
                    leadingIcon: Icons.language_outlined,
                    trailing: ItemPopupMenuFilter<AppLanguageType>(
                      toolTipText: 'App Language',
                      selectedValue: state.currentLanguage,
                      values: AppLanguageType.values,
                      onSelected: (newVal) => context.read<SettingsBloc>().add(SettingsEvent.languageChanged(newValue: newVal)),
                      icon: const Icon(Icons.expand_more),
                      itemText: (val, _) => Assets.translateAppLanguageType(val),
                    ),
                  ),
                  SettingsSwitchListTile(
                    title: 'Demo profile picture',
                    leadingIcon: Icons.face_outlined,
                    value: state.useDemoProfilePicture,
                    onChanged: (newVal) => context.read<SettingsBloc>().add(SettingsEvent.useDemoProfilePictureChanged(newValue: newVal)),
                  ),
                  SettingsSwitchListTile(
                    title: 'Press back to exit',
                    leadingIcon: Icons.settings_outlined,
                    value: state.doubleBackToClose,
                    onChanged: (newVal) => context.read<SettingsBloc>().add(SettingsEvent.doubleBackToCloseChanged(newValue: newVal)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
