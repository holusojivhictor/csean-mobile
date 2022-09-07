import 'package:csean_mobile/application/bloc.dart';
import 'package:csean_mobile/domain/enums/enum.dart';
import 'package:csean_mobile/domain/models/model.dart';
import 'package:csean_mobile/presentation/events/widgets/event_card.dart';
import 'package:csean_mobile/presentation/forums/widgets/forum_card.dart';
import 'package:csean_mobile/presentation/shared/loading.dart';
import 'package:csean_mobile/presentation/shared/sliver_nothing_found.dart';
import 'package:csean_mobile/presentation/shared/sliver_page_filter.dart';
import 'package:csean_mobile/presentation/shared/sliver_scaffold_with_fab.dart';
import 'package:csean_mobile/presentation/shared/sliver_title.dart';
import 'package:csean_mobile/presentation/shared/utils/modal_bottom_sheet_utils.dart';
import 'package:csean_mobile/presentation/shared/utils/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waterfall_flow/waterfall_flow.dart';

class ChapterInfoPage extends StatelessWidget {
  const ChapterInfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommunityEventsBloc, CommunityEventsState>(
      builder: (ctx, state) => state.map(
        loading: (_) => const Loading(),
        loaded: (state) => BlocBuilder<ForumsBloc, ForumsState>(
          builder: (ctx, forumState) => forumState.map(
            loading: (_) => const Loading(),
            loaded: (forumState) => SliverScaffoldWithFab(
              slivers: [
                SliverPageFilter(
                  hasFilter: false,
                  search: state.search,
                  title: 'Events',
                  onPressed: () => ModalBottomSheetUtils.showAppModalBottomSheet(context, EndDrawerItemType.events),
                  searchChanged: (v) => context.read<CommunityEventsBloc>().add(CommunityEventsEvent.searchChanged(search: v)),
                ),
                const SliverTitle(title: 'Chapter Forum'),
                _buildChapterForum(forumState.chapterForum),
                const SliverTitle(title: 'Chapter Events'),
                if (state.chapterEvents.isNotEmpty) _buildList(context, state.chapterEvents) else const SliverNothingFound(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildChapterForum(ForumCardModel forum) {
    return SliverToBoxAdapter(
      child: ForumCard.item(forum: forum),
    );
  }

  Widget _buildList(BuildContext context, List<EventCardModel> events) {
    return SliverWaterfallFlow(
      gridDelegate: SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
        crossAxisCount: SizeUtils.getCrossAxisCountForGrids(context, forPortrait: 1),
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
      ),
      delegate: SliverChildBuilderDelegate(
            (context, index) => EventCard.item(event: events[index]),
        childCount: events.length,
      ),
    );
  }
}
