import 'package:csean_mobile/application/bloc.dart';
import 'package:csean_mobile/domain/models/model.dart';
import 'package:csean_mobile/presentation/shared/loading.dart';
import 'package:csean_mobile/presentation/shared/sliver_nothing_found.dart';
import 'package:csean_mobile/presentation/shared/sliver_scaffold_with_fab.dart';
import 'package:csean_mobile/presentation/shared/utils/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waterfall_flow/waterfall_flow.dart';

import 'widgets/topic_card.dart';

class TopicsPage extends StatelessWidget {
  const TopicsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<TopicsBloc, TopicsState>(
      builder: (ctx, state) => state.map(
        loading: (_) => const Loading(),
        loaded: (state) => SliverScaffoldWithFab(
          appbar: AppBar(
            title: Text(
              'Topics',
              style: theme.textTheme.headline2,
            ),
            automaticallyImplyLeading: false,
            leading: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Icon(Icons.keyboard_backspace_rounded, color: theme.indicatorColor),
            ),
            centerTitle: true,
            backgroundColor: Colors.transparent,
            elevation: 0.0,
          ),
          slivers: [
            if (state.topics.isNotEmpty) _buildGrid(context, state.topics) else const SliverNothingFound(),
          ],
        ),
      ),
    );
  }

  Widget _buildGrid(BuildContext context, List<TopicCardModel> topics) {
    return SliverWaterfallFlow(
      gridDelegate: SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
        crossAxisCount: SizeUtils.getCrossAxisCountForGrids(context, forPortrait: 1),
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
      ),
      delegate: SliverChildBuilderDelegate(
            (context, index) => TopicCard.item(topic: topics[index]),
        childCount: topics.length,
      ),
    );
  }
}
