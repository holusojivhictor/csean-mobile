import 'package:csean_mobile/application/bloc.dart';
import 'package:csean_mobile/domain/models/model.dart';
import 'package:csean_mobile/presentation/shared/loading.dart';
import 'package:csean_mobile/presentation/shared/sliver_nothing_found.dart';
import 'package:csean_mobile/presentation/shared/sliver_page_filter.dart';
import 'package:csean_mobile/presentation/shared/sliver_scaffold_with_fab.dart';
import 'package:csean_mobile/presentation/shared/utils/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waterfall_flow/waterfall_flow.dart';

import 'widgets/forum_card.dart';

class ForumsPage extends StatefulWidget {
  const ForumsPage({Key? key}) : super(key: key);

  @override
  State<ForumsPage> createState() => _ForumsPageState();
}

class _ForumsPageState extends State<ForumsPage> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<ForumsBloc, ForumsState>(
      builder: (ctx, state) => state.map(
        loading: (_) => const Loading(),
        loaded: (state) => SliverScaffoldWithFab(
          slivers: [
            SliverPageFilter(
              search: state.search,
              hasFilter: false,
              title: 'Forums',
              onPressed: () {},
              searchChanged: (v) => context.read<ForumsBloc>().add(ForumsEvent.searchChanged(search: v)),
            ),
            _buildTitle('Chapter Specific'),
            _buildChapterForum(state.chapterForum),
            _buildTitle('General Forums'),
            if (state.forums.isNotEmpty) _buildList(context, state.forums) else const SliverNothingFound(),
          ],
        ),
      ),
    );
  }

  Widget _buildChapterForum(ForumCardModel forum) {
    return SliverToBoxAdapter(
      child: ForumCard.item(forum: forum),
    );
  }

  Widget _buildList(BuildContext context, List<ForumCardModel> forums) {
    return SliverWaterfallFlow(
      gridDelegate: SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
        crossAxisCount: SizeUtils.getCrossAxisCountForGrids(context, forPortrait: 1),
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
      ),
      delegate: SliverChildBuilderDelegate(
            (context, index) => ForumCard.item(forum: forums[index]),
        childCount: forums.length,
      ),
    );
  }

  Widget _buildTitle(String title) {
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
