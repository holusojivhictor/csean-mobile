import 'package:csean_mobile/presentation/home/widgets/content_choice_bar.dart';
import 'package:csean_mobile/presentation/home/widgets/custom_main_drawer.dart';
import 'package:csean_mobile/presentation/home/widgets/sliver_demo_contents.dart';
import 'package:csean_mobile/presentation/home/widgets/sliver_home_greet.dart';
import 'package:csean_mobile/presentation/home/widgets/sliver_main_title.dart';
import 'package:csean_mobile/presentation/home/widgets/sliver_membership_card.dart';
import 'package:csean_mobile/presentation/home/widgets/sliver_subscription_card.dart';
import 'package:csean_mobile/presentation/payments_manager/payments_manager_page.dart';
import 'package:csean_mobile/presentation/shared/clickable_title.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'widgets/clickable_title.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin<HomePage> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ResponsiveBuilder(
      builder: (ctx, size) => Scaffold(
        drawer: const CustomMainDrawer(),
        body: CustomScrollView(
          slivers: [
            const SliverMainTitle(),
            const SliverHomeGreet(),
            const ContentChoiceBar(),
            const HomeClickableTitle(),
            const SliverDemoContents(),
            SliverClickableTitle(title: 'Subscription', onClick: () => Navigator.push(context, MaterialPageRoute(builder: (ctx) => const PaymentsManagerPage())), buttonText: 'View plan'),
            const SliverSubscriptionCard(),
            const SliverClickableTitle(title: 'Membership card'),
            const SliverMembershipCard(),
          ],
        ),
      ),
    );
  }
}
