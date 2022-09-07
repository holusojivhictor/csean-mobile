import 'package:csean_mobile/application/bloc.dart';
import 'package:csean_mobile/domain/assets.dart';
import 'package:csean_mobile/domain/enums/auto_theme_mode_type.dart';
import 'package:csean_mobile/domain/enums/enum.dart';
import 'package:csean_mobile/presentation/settings/widgets/settings_card.dart';
import 'package:csean_mobile/presentation/settings/widgets/settings_list_tile.dart';
import 'package:csean_mobile/presentation/settings/widgets/settings_switch_list_tile.dart';
import 'package:csean_mobile/presentation/shared/extensions/app_theme_type_extensions.dart';
import 'package:csean_mobile/presentation/shared/item_popup_menu_filter.dart';
import 'package:csean_mobile/presentation/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'card_header_text.dart';

class DisplaySettingsCard extends StatelessWidget {
  const DisplaySettingsCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const CardHeaderText(title: 'DISPLAY'),
        SettingsCard(
          child: BlocBuilder<SettingsBloc, SettingsState>(
            builder: (ctx, state) => state.map(
              loading: (_) => const Loading(useScaffold: false),
              loaded: (state) => Column(
                children: [
                  SettingsListTile(
                    title: 'Auto Dark Mode',
                    leadingIcon: Icons.settings_outlined,
                    trailing: ItemPopupMenuFilter<AutoThemeModeType>(
                      toolTipText: 'Auto Theme Mode',
                      selectedValue: state.themeMode,
                      values: AutoThemeModeType.values,
                      onSelected: (newVal) => context.read<SettingsBloc>().add(SettingsEvent.autoThemeModeTypeChanged(newValue: newVal)),
                      icon: const Icon(Icons.expand_more),
                      itemText: (val, _) => Assets.translateAutoThemeModeType(val),
                    ),
                  ),
                  SettingsSwitchListTile(
                    title: 'Dark Mode',
                    leadingIcon: Icons.dark_mode_outlined,
                    value: state.currentTheme.darkMode(),
                    onChanged: state.themeMode == AutoThemeModeType.off ? (newVal) => context.read<SettingsBloc>().add(SettingsEvent.themeChanged(newValue: Assets.translateThemeTypeBool(newVal))) : null,
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
