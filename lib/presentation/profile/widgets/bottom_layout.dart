import 'package:csean_mobile/presentation/profile_edit/profile_edit_page.dart';
import 'package:csean_mobile/presentation/shared/animation/animated_page_route.dart';
import 'package:csean_mobile/theme.dart';
import 'package:flutter/material.dart';

class BottomLayout extends StatelessWidget {
  final String fullName;
  final String email;
  final String occupation;
  final String chapterName;
  final String companyName;
  final String address;
  final String city;
  final String membershipType;

  const BottomLayout({
    Key? key,
    required this.fullName,
    required this.email,
    required this.occupation,
    required this.chapterName,
    required this.companyName,
    required this.address,
    required this.city,
    required this.membershipType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Padding(
        padding: Styles.edgeInsetAll10,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              fullName,
              style: theme.textTheme.headline6!.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            Text(
              email,
              style: theme.textTheme.headline4,
            ),
            const SizedBox(height: 5),
            Text(
              '$occupation,  $chapterName Chapter',
              style: theme.textTheme.headline4!.copyWith(fontSize: 17, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Text(
              '$companyName, $address',
              style: theme.textTheme.headline4!.copyWith(fontSize: 17),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Text(
                  city,
                  style: theme.textTheme.headline4!.copyWith(fontSize: 15),
                ),
                const SizedBox(width: 5),
                const CircleAvatar(
                  radius: 3,
                  backgroundColor: Colors.black,
                ),
                const SizedBox(width: 5),
                Text(
                  membershipType,
                  style: theme.textTheme.headline4!.copyWith(fontSize: 15),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: ElevatedButton(
                style: ButtonStyle(
                  elevation: MaterialStateProperty.all(0),
                  backgroundColor: MaterialStateProperty.all(theme.scaffoldBackgroundColor),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      side: BorderSide(color: theme.indicatorColor),
                    ),
                  ),
                ),
                child: Text('Edit profile', style: theme.textTheme.bodyText1),
                onPressed: () => _goToEditPage(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _goToEditPage(BuildContext context) {
    final route = AnimatedPageRoute(page: const ProfileEditPage());
    Navigator.push(context, route);
  }
}
