import 'package:csean_mobile/theme.dart';
import 'package:flutter/material.dart';

class SettingsCard extends StatelessWidget {
  final Widget child;
  const SettingsCard({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: Styles.settingsCardShape,
      margin: Styles.edgeInsetAll10,
      shadowColor: Colors.transparent,
      elevation: 0.0,
      child: Container(
        margin: Styles.edgeInsetAll5,
        padding: Styles.edgeInsetAll5,
        child: child,
      ),
    );
  }
}
