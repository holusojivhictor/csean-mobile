import 'package:flutter/material.dart';

class SliverTitle extends StatelessWidget {
  final String title;
  const SliverTitle({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      sliver: SliverToBoxAdapter(
        child: Row(
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.headline2!.copyWith(fontWeight: FontWeight.w100),
            ),
          ],
        ),
      ),
    );
  }
}
