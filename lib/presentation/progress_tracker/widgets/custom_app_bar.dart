import 'package:csean_mobile/domain/extensions/date_time_extensions.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SliverPadding(
      padding: const EdgeInsets.only(bottom: 15),
      sliver: SliverToBoxAdapter(
        child: ListTile(
          minLeadingWidth: 10,
          leading: const Icon(Icons.insights, color: Colors.black),
          title: Text(
            'Progress Tracker',
            style: theme.textTheme.headline2,
          ),
          subtitle: Text(
            DateTime.now().formatDate(),
            style: theme.textTheme.headline4,
          ),
          trailing: IconButton(
            padding: EdgeInsets.zero,
            alignment: Alignment.centerRight,
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.close_rounded, color: Colors.black),
          ),
        ),
      ),
    );
  }
}