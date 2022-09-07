import 'package:csean_mobile/application/bloc.dart';
import 'package:csean_mobile/domain/models/model.dart';
import 'package:csean_mobile/presentation/shared/loading.dart';
import 'package:csean_mobile/presentation/shared/sliver_nothing_found.dart';
import 'package:csean_mobile/presentation/shared/sliver_page_filter.dart';
import 'package:csean_mobile/presentation/shared/sliver_scaffold_with_fab.dart';
import 'package:csean_mobile/presentation/shared/utils/size_utils.dart';
import 'package:csean_mobile/presentation/ticket/ticket_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waterfall_flow/waterfall_flow.dart';

import 'widgets/ticket_card.dart';

class SupportPage extends StatelessWidget {
  const SupportPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SupportBloc, SupportState>(
      builder: (ctx, state) => state.map(
        loading: (_) => const Loading(),
        loaded: (state) => SliverScaffoldWithFab(
          slivers: [
            SliverPageFilter(
              search: state.search,
              title: 'Support',
              onPressed: () {},
              searchChanged: (v) => context.read<SupportBloc>().add(SupportEvent.searchChanged(search: v)),
            ),
            if (state.tickets.isNotEmpty) _buildList(context, state.tickets) else const SliverNothingFound(),
          ],
          floatingActionButton: FloatingActionButton(
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (ctx) => const TicketPage())),
            backgroundColor: Theme.of(context).primaryColor,
            child: const Icon(Icons.add),
          ),
        ),
      ),
    );
  }

  Widget _buildList(BuildContext context, List<TicketCardModel> tickets) {
    return SliverWaterfallFlow(
      gridDelegate: SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
        crossAxisCount: SizeUtils.getCrossAxisCountForGrids(context, forPortrait: 1, forLandscape: 1),
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
      ),
      delegate: SliverChildBuilderDelegate(
            (context, index) => TicketCard.item(ticket: tickets[index]),
        childCount: tickets.length,
      ),
    );
  }
}
