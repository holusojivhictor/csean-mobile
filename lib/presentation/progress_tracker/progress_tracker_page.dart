import 'package:csean_mobile/application/bloc.dart';
import 'package:csean_mobile/domain/enums/enum.dart';
import 'package:csean_mobile/domain/models/model.dart';
import 'package:csean_mobile/presentation/shared/clickable_title.dart';
import 'package:csean_mobile/presentation/shared/loading.dart';
import 'package:csean_mobile/presentation/shared/sliver_nothing_found.dart';
import 'package:csean_mobile/presentation/shared/sliver_scaffold_with_fab.dart';
import 'package:csean_mobile/presentation/shared/utils/modal_bottom_sheet_utils.dart';
import 'package:csean_mobile/presentation/shared/utils/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:waterfall_flow/waterfall_flow.dart';

import 'widgets/activity_card.dart';
import 'widgets/custom_app_bar.dart';
import 'widgets/request_card.dart';

class ProgressTrackerPage extends StatelessWidget {
  const ProgressTrackerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProgressTrackerBloc, ProgressTrackerState>(
      builder: (ctx, state) => state.map(
        loading: (_) => const Loading(),
        loaded: (state) {
          final targetPoints = state.tracker.targetPoint;
          final totalPoints = state.report.totalPoints;
          return SliverScaffoldWithFab(
            slivers: [
              const CustomAppBar(),
              CustomCircularProgressIndicator(value: totalPoints/targetPoints),
              SliverClickableTitle(title: 'Recent PDUs', textStyle: Theme.of(context).textTheme.headline4),
              if (state.activities.isNotEmpty) _buildActivityList(context, state.activities) else const SliverNothingFound(),
              SliverClickableTitle(title: 'Claim history', textStyle: Theme.of(context).textTheme.headline4),
              if (state.progressRequests.isNotEmpty) _buildHistoryList(context, state.progressRequests) else const SliverNothingFound(),
            ],
            floatingActionButton: FloatingActionButton(
              backgroundColor: Theme.of(context).colorScheme.secondary,
              child: const Icon(Icons.add),
              onPressed: () => ModalBottomSheetUtils.showAppModalBottomSheet(context, EndDrawerItemType.progressTracker),
            ),
          );
        },
      ),
    );
  }

  Widget _buildActivityList(BuildContext context, List<ActivityCardModel> activities) {
    final half = activities.length ~/ 2;
    return SliverWaterfallFlow(
      gridDelegate: SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
        crossAxisCount: SizeUtils.getCrossAxisCountForGrids(context, forPortrait: 1),
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
      ),
      delegate: SliverChildBuilderDelegate(
            (context, index) => ActivityCard.item(activity: activities[index]),
        childCount: half > 4 ? 4 : half,
      ),
    );
  }

  Widget _buildHistoryList(BuildContext context, List<RequestCardModel> requests) {
    return SliverWaterfallFlow(
      gridDelegate: SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
        crossAxisCount: SizeUtils.getCrossAxisCountForGrids(context, forPortrait: 1),
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
      ),
      delegate: SliverChildBuilderDelegate(
            (context, index) => RequestCard.item(request: requests[index]),
        childCount: requests.length,
      ),
    );
  }
}

class CustomCircularProgressIndicator extends StatelessWidget {
  final double value;

  const CustomCircularProgressIndicator({
    Key? key,
    required this.value,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SliverToBoxAdapter(
      child: CircularPercentIndicator(
        radius: 100,
        lineWidth: 12,
        animation: true,
        percent: value,
        animationDuration: 1500,
        circularStrokeCap: CircularStrokeCap.round,
        backgroundColor: Colors.grey.withOpacity(0.6),
        progressColor: Theme.of(context).colorScheme.secondary,
        center: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'Completed',
              style: theme.textTheme.headline4,
            ),
            Text(
              '${(value * 100).toInt()}',
              style: theme.textTheme.headline5!.copyWith(fontSize: 42),
            ),
            Text(
              '%',
              style: theme.textTheme.headline6,
            ),
          ],
        ),
      ),
    );
  }
}
