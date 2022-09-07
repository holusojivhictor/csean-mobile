import 'dart:async';

import 'package:csean_mobile/application/bloc.dart';
import 'package:csean_mobile/presentation/settings/widgets/settings_card.dart';
import 'package:csean_mobile/presentation/settings/widgets/settings_list_tile.dart';
import 'package:csean_mobile/presentation/shared/custom_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'card_header_text.dart';

class LogOutCard extends StatelessWidget {
  const LogOutCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const CardHeaderText(title: 'SYSTEM'),
        SettingsCard(
          child: Column(
            children: [
              SettingsListTile(
                title: 'Log out',
                leadingIcon: Icons.person_outline_rounded,
                trailing: const Icon(Icons.logout),
                onTap: () => _logOut(context),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _logOut(BuildContext context) async {
    final bloc = context.read<SessionBloc>();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => CommonAlertDialog(
        titleText: 'Log out',
        contentText: 'Are you sure you want to log out your account?',
        cancelText: 'Cancel',
        actionText: 'Okay',
        cancelOnPressed: () {
          Navigator.of(context).pop();
        },
        actionOnPressed: () {
          Navigator.of(context).pop();
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (ctx) => const CustomAlertDialog(text: 'Signing user out...'),
          );
          Timer(const Duration(seconds: 2), () {
            Navigator.of(context).pop();
            bloc.add(const SessionEvent.logsOut());
          });
        },
      ),
    );
  }
}
