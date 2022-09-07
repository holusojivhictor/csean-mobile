import 'package:csean_mobile/theme.dart';
import 'package:flutter/material.dart';

class SettingsListTile extends StatelessWidget {
  final String title;
  final IconData leadingIcon;
  final Widget? trailing;
  final void Function()? onTap;

  const SettingsListTile({
    Key? key,
    required this.title,
    required this.leadingIcon,
    this.trailing,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title, style: Theme.of(context).textTheme.headline4),
      dense: true,
      minLeadingWidth: 20,
      contentPadding: Styles.edgeInsetHorizontal5,
      onTap: onTap != null ? () => onTap!() : null,
      leading: Icon(leadingIcon),
      trailing: trailing,
    );
  }
}
