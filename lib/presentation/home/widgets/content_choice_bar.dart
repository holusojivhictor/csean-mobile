import 'package:csean_mobile/application/bloc.dart';
import 'package:csean_mobile/presentation/home/widgets/custom_choice_chip.dart';
import 'package:csean_mobile/presentation/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/enums/enum.dart';

class ContentChoiceBar extends StatefulWidget {
  const ContentChoiceBar({Key? key}) : super(key: key);

  @override
  State<ContentChoiceBar> createState() => _ContentChoiceBarState();
}

class _ContentChoiceBarState extends State<ContentChoiceBar> {
  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      sliver: SliverToBoxAdapter(
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (ctx, state) => state.map(
            loading: (_) => const Loading(useScaffold: false),
            loaded: (state) => Row(
              children: [
                CustomChoiceChip(
                  labelText: 'Overview',
                  selected: state.contentType == ContentType.event,
                  onSelected: (value) {
                    context.read<HomeBloc>().add(const HomeEvent.contentChanged(contentType: ContentType.event));
                  },
                ),
                CustomChoiceChip(
                  labelText: 'Productivity',
                  selected: state.contentType == ContentType.blog,
                  onSelected: (value) {
                    context.read<HomeBloc>().add(const HomeEvent.contentChanged(contentType: ContentType.blog));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
