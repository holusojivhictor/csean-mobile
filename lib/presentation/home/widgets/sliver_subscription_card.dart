import 'package:csean_mobile/application/bloc.dart';
import 'package:csean_mobile/domain/app_constants.dart';
import 'package:csean_mobile/presentation/shared/custom_card.dart';
import 'package:csean_mobile/presentation/shared/loading.dart';
import 'package:csean_mobile/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SliverSubscriptionCard extends StatelessWidget {
  const SliverSubscriptionCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SliverToBoxAdapter(
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (ctx, state) => state.map(
          loading: (_) => const Loading(useScaffold: false),
          loaded: (state) => CustomCard(
            clipBehavior: Clip.hardEdge,
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 13),
            shape: Styles.mainCardShape,
            color: Colors.grey.withOpacity(0.25),
            child: Padding(
              padding: Styles.edgeInsetAll10,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Annual Due',
                          style: theme.textTheme.headline6!.copyWith(fontWeight: FontWeight.w600, fontSize: 18),
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.start,
                        ),
                        const SizedBox(height: 6),
                        RichText(
                          text: TextSpan(
                            text: getCurrency(),
                            style: Theme.of(context).textTheme.bodyText2!.copyWith(fontFamily: 'DejaVuSans'),
                            children: <TextSpan> [
                              TextSpan(
                                text: '${state.subscriptionAmount}',
                                style: theme.textTheme.headline6!.copyWith(fontWeight: FontWeight.w600, fontSize: 18),
                              ),
                              const TextSpan(
                                text: ' /annum',
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          state.userAccount.subscription ? 'Subscription status is active' : 'Subscription status is not active',
                          style: theme.textTheme.bodyText1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.start,
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 4,
                              backgroundColor: theme.primaryColor,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              state.userAccount.subscription ? '100% paid' : '0% paid',
                              style: theme.textTheme.bodyText1,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    child: Image(
                      height: 100,
                      width: 125,
                      image: AssetImage('assets/place-holder/abstract-done.png'),
                      fit: BoxFit.cover,
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
}
