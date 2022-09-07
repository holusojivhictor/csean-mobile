import 'package:csean_mobile/application/bloc.dart';
import 'package:csean_mobile/presentation/chapter_info/chapter_info_page.dart';
import 'package:csean_mobile/presentation/learning_resources/learning_resources_page.dart';
import 'package:csean_mobile/presentation/payments_manager/payments_manager_page.dart';
import 'package:csean_mobile/presentation/progress_tracker/progress_tracker_page.dart';
import 'package:csean_mobile/presentation/shared/animation/animated_page_route.dart';
import 'package:csean_mobile/presentation/support/support_page.dart';
import 'package:csean_mobile/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomMainDrawer extends StatelessWidget {
  const CustomMainDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.61,
      child: Drawer(
        child: ListView(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 30,
                  child: Container(
                    margin: Styles.edgeInsetAll5,
                    child: Container(
                      margin: Styles.edgeInsetAll5,
                      padding: Styles.edgeInsetAll10,
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.6),
                        borderRadius: Styles.mainCardBorderRadius,
                      ),
                      child: Image.asset(
                        'assets/auth/black_hole.png',
                        fit: BoxFit.contain,
                        filterQuality: FilterQuality.high,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 70,
                  child: Container(
                    margin: Styles.edgeInsetAll5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'CSEAN',
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        const SizedBox(height: 5),
                        Text(
                          'Cyber Security Experts Association of Nigeria',
                          style: Theme.of(context).textTheme.headline3!.copyWith(color: Colors.black54),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            _buildClickableTitle('POPULAR', context),
            DrawerListItem(
              iconData: Icons.dashboard_outlined,
              itemText: 'Dashboard',
              onTap: () => Navigator.pop(context),
            ),
            DrawerListItem(
              iconData: Icons.event,
              itemText: 'Events',
              onTap: () {
                Navigator.pop(context);
                _goToTab(context, 1);
              },
            ),
            DrawerListItem(
              iconData: Icons.library_books_outlined,
              itemText: 'Blogs',
              onTap: () {
                Navigator.pop(context);
                _goToTab(context, 3);
              },
            ),
            _buildClickableTitle('SPACES', context),
            DrawerListItem(
              iconData: Icons.forum_outlined,
              itemText: 'Forums',
              onTap: () {
                Navigator.pop(context);
                _goToTab(context, 2);
              },
            ),
            DrawerListItem(
              iconData: Icons.account_balance_wallet_outlined,
              itemText: 'Subscription Manager',
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, SlideAnimatedPageRoute(page: const PaymentsManagerPage()));
              },
            ),
            DrawerListItem(
              iconData: Icons.schedule_outlined,
              itemText: 'Progress Tracker',
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, SlideAnimatedPageRoute(page: const ProgressTrackerPage()));
              },
            ),
            DrawerListItem(
              iconData: Icons.help_outline_outlined,
              itemText: 'Chapter Info',
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, SlideAnimatedPageRoute(page: const ChapterInfoPage()));
              },
            ),
            DrawerListItem(
              iconData: Icons.local_library_outlined,
              itemText: 'Learning Resources',
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, SlideAnimatedPageRoute(page: const LearningResourcesPage()));
              },
            ),
            DrawerListItem(
              iconData: Icons.email_outlined,
              itemText: 'Communication',
              onTap: () {},
            ),
            _buildClickableTitle('HELP', context),
            DrawerListItem(
              iconData: Icons.contact_support_outlined,
              itemText: 'Support',
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, SlideAnimatedPageRoute(page: const SupportPage()));
              },
            ),
            DrawerListItem(
              iconData: Icons.settings_outlined,
              itemText: 'Settings',
              onTap: () {
                Navigator.pop(context);
                _goToTab(context, 4);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _goToTab(BuildContext context, int newIndex) => context.read<MainTabBloc>().add(MainTabEvent.goToTab(index: newIndex));

  Widget _buildClickableTitle(String title, BuildContext context, {Function? onClick, String? buttonText}) {
    final theme = Theme.of(context);
    final endText = buttonText != null
        ? Text(buttonText, style: theme.textTheme.bodyText1)
        : null;
    return ListTile(
      dense: true,
      onTap: () => onClick?.call(),
      visualDensity: const VisualDensity(vertical: -4, horizontal: -2),
      trailing: endText,
      title: Text(
        title,
        textAlign: TextAlign.start,
        style: theme.textTheme.bodyText1!.copyWith(letterSpacing: 0.15, color: Colors.grey),
      ),
    );
  }
}


class DrawerListItem extends StatelessWidget {
  final IconData iconData;
  final String itemText;
  final void Function()? onTap;

  const DrawerListItem({
    Key? key,
    required this.iconData,
    required this.itemText,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap != null ? () => onTap!() : null,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Row(
          children: [
            Icon(iconData, color: Colors.black54, size: 21),
            const SizedBox(width: 10),
            Text(
              itemText,
              style: Theme.of(context).textTheme.headline4!.copyWith(),
            ),
          ],
        ),
      ),
    );
  }
}
