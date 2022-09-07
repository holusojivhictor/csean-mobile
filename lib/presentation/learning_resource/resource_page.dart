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

import 'widgets/resource_card.dart';

class ResourcePage extends StatelessWidget {
  const ResourcePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ResourceBloc, ResourceState>(
      builder: (ctx, state) => state.map(
        loading: (_) => const Loading(),
        loaded: (state) => SliverScaffoldWithFab(
          slivers: [
            SliverPageFilter(
              search: '',
              title: 'Resources',
              onPressed: () {},
              hasFilter: false,
              searchChanged: (v) {},
            ),
            if (state.resources.isNotEmpty) _buildList(context, state.resources) else const SliverNothingFound(),
          ],
        ),
      ),
    );
  }

  Widget _buildList(BuildContext context, List<ResourceItemCardModel> resources) {
    return SliverWaterfallFlow(
      gridDelegate: SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
        crossAxisCount: SizeUtils.getCrossAxisCountForGrids(context, forPortrait: 1),
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
      ),
      delegate: SliverChildBuilderDelegate(
            (context, index) => ResourceCard.item(resource: resources[index]),
        childCount: resources.length,
      ),
    );
  }
}
