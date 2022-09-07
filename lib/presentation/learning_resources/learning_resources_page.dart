import 'package:csean_mobile/application/bloc.dart';
import 'package:csean_mobile/domain/assets.dart';
import 'package:csean_mobile/domain/enums/enum.dart';
import 'package:csean_mobile/domain/models/model.dart';
import 'package:csean_mobile/presentation/shared/choice/choice_bar_with_icon.dart';
import 'package:csean_mobile/presentation/shared/loading.dart';
import 'package:csean_mobile/presentation/shared/sliver_nothing_found.dart';
import 'package:csean_mobile/presentation/shared/sliver_page_filter.dart';
import 'package:csean_mobile/presentation/shared/sliver_scaffold_with_fab.dart';
import 'package:csean_mobile/presentation/shared/utils/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waterfall_flow/waterfall_flow.dart';

import 'widgets/learning_resource_card.dart';

class LearningResourcesPage extends StatefulWidget {
  const LearningResourcesPage({Key? key}) : super(key: key);

  @override
  State<LearningResourcesPage> createState() => _LearningResourcesPageState();
}

class _LearningResourcesPageState extends State<LearningResourcesPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ResourcesBloc, ResourcesState>(
      builder: (ctx, state) => state.map(
        loading: (_) => const Loading(),
        loaded: (state) => SliverScaffoldWithFab(
          slivers: [
            SliverPageFilter(
              search: state.search,
              hasFilter: false,
              title: 'Resources',
              onPressed: () {},
              searchChanged: (v) => context.read<ResourcesBloc>().add(ResourcesEvent.searchChanged(search: v)),
            ),
            _buildClickableTitle('Categories', context),
            SliverToBoxAdapter(
              child: ChoiceBarWithIconWithAllValue(
                values: ResourceCategoryType.values.map((e) => e.index).toList(),
                selectedValue: state.tempCategoryType?.index,
                onAllOrValueSelected: (v) {
                  context.read<ResourcesBloc>().add(ResourcesEvent.categoryTypeChanged(v != null ? ResourceCategoryType.values[v] : null));
                  context.read<ResourcesBloc>().add(const ResourcesEvent.applyFilterChanges());
                },
                choiceText: (val, _) => Assets.translateCategoryType(ResourceCategoryType.values[val]),
                iconData: (val, _) => Assets.translateCategoryTypeIcon(ResourceCategoryType.values[val]),
              ),
            ),
            if (state.subCategories.isNotEmpty) _buildGrid(context, state.subCategories) else const SliverNothingFound(),
          ],
        ),
      ),
    );
  }

  Widget _buildGrid(BuildContext context, List<SubCategoryCardModel> resources) {
    return SliverWaterfallFlow(
      gridDelegate: SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
        crossAxisCount: SizeUtils.getCrossAxisCountForGrids(context, forPortrait: 2, forLandscape: 3),
        mainAxisSpacing: 5,
      ),
      delegate: SliverChildBuilderDelegate((context, index) => LearningResourceCard.item(resource: resources[index]),
        childCount: resources.length,
      ),
    );
  }

  Widget _buildClickableTitle(String title, BuildContext context, {Function? onClick, String? buttonText}) {
    final theme = Theme.of(context);
    final endText = buttonText != null
        ? Text(buttonText, style: theme.textTheme.bodyText1)
        : null;
    return SliverToBoxAdapter(
      child: ListTile(
        dense: true,
        onTap: () => onClick?.call(),
        visualDensity: const VisualDensity(vertical: -4, horizontal: -2),
        trailing: endText,
        title: Text(
          title,
          textAlign: TextAlign.start,
          style: theme.textTheme.headline2!.copyWith(fontWeight: FontWeight.bold, letterSpacing: 0.15),
        ),
      ),
    );
  }
}
