import 'package:csean_mobile/application/bloc.dart';
import 'package:csean_mobile/domain/assets.dart';
import 'package:csean_mobile/presentation/shared/custom_card.dart';
import 'package:csean_mobile/presentation/shared/sliver_loading.dart';
import 'package:csean_mobile/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SliverMembershipCard extends StatelessWidget {
  const SliverMembershipCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (ctx, state) => state.map(
        loading: (_) => const SliverLoading(),
        loaded: (state) => SliverToBoxAdapter(
          child: CustomCard(
            clipBehavior: Clip.hardEdge,
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 13),
            shape: Styles.mainCardShape,
            color: Colors.grey.withOpacity(0.25),
            child: Padding(
              padding: Styles.edgeInsetAll10,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    child: Image(
                      height: 100,
                      width: 125,
                      image: AssetImage('assets/place-holder/gummy-macbook.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          state.userAccount.subscription ? 'Subscription status is active' : 'Subscription status is not active',
                          style: theme.textTheme.bodyText1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.start,
                        ),
                        const SizedBox(height: 10),
                        buildDotRow(theme, 'Referee unattested'),
                        const SizedBox(height: 7),
                        buildDotRow(theme, Assets.translateMembershipTypeHome(state.membershipType)),
                        const SizedBox(height: 7),
                        buildDotRow(theme, state.userAccount.subscription ? 'Payment verified' : 'Pending payment'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Row buildDotRow(ThemeData theme, String text) {
    return Row(
      children: [
        const CircleAvatar(
          radius: 4,
          backgroundColor: Colors.black,
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: theme.textTheme.bodyText1,
        ),
      ],
    );
  }
}
