import 'package:csean_mobile/application/bloc.dart';
import 'package:csean_mobile/presentation/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SliverHomeGreet extends StatelessWidget {
  const SliverHomeGreet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      sliver: SliverToBoxAdapter(
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (ctx, state) => state.map(
            loading: (_) => const Loading(useScaffold: false),
            loaded: (state) {
              final firstName = state.userAccount.firstName;
              final lastName = state.userAccount.lastName;
              return RichText(
                text: TextSpan(
                  text: 'Hello, \n',
                  style: theme.textTheme.headline6!.copyWith(fontWeight: FontWeight.bold, fontSize: 22),
                  children: <TextSpan> [
                    TextSpan(
                      text: '$firstName $lastName 👋',
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
