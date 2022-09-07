import 'package:csean_mobile/application/bloc.dart';
import 'package:csean_mobile/domain/enums/enum.dart';
import 'package:csean_mobile/domain/models/model.dart';
import 'package:csean_mobile/presentation/events/widgets/event_card.dart';
import 'package:csean_mobile/presentation/shared/loading.dart';
import 'package:csean_mobile/presentation/shared/sliver_nothing_found.dart';
import 'package:csean_mobile/presentation/shared/sliver_page_filter.dart';
import 'package:csean_mobile/presentation/shared/sliver_scaffold_with_fab.dart';
import 'package:csean_mobile/presentation/shared/utils/modal_bottom_sheet_utils.dart';
import 'package:csean_mobile/presentation/shared/utils/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waterfall_flow/waterfall_flow.dart';

class EventsPage extends StatefulWidget {
  final bool isInSelectionMode;

  static Future<int?> forSelection(BuildContext context, {List<String> excludeKeys = const []}) async {
    final bloc = context.read<CommunityEventsBloc>();
    bloc.add(const CommunityEventsEvent.init());

    final route = MaterialPageRoute<int>(builder: (ctx) => const EventsPage(isInSelectionMode: true));
    final id = await Navigator.push(context, route);
    await route.completed;

    bloc.add(const CommunityEventsEvent.init());

    return id;
  }

  const EventsPage({Key? key, this.isInSelectionMode = false}) : super(key: key);

  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> with AutomaticKeepAliveClientMixin<EventsPage> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<CommunityEventsBloc, CommunityEventsState>(
      builder: (ctx, state) => state.map(
        loading: (_) => const Loading(),
        loaded: (state) => SliverScaffoldWithFab(
          appbar: widget.isInSelectionMode
              ? AppBar(
                  title: const Text('Select an event'),
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  iconTheme: const IconThemeData(color: Colors.black),
                  titleTextStyle: Theme.of(context).textTheme.headline6,
                )
              : null,
          slivers: [
            SliverPageFilter(
              search: state.search,
              title: 'Events',
              onPressed: () => ModalBottomSheetUtils.showAppModalBottomSheet(context, EndDrawerItemType.events),
              searchChanged: (v) => context.read<CommunityEventsBloc>().add(CommunityEventsEvent.searchChanged(search: v)),
            ),
            if (state.events.isNotEmpty) _buildList(context, state.events) else const SliverNothingFound(),
          ],
        ),
      ),
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
        (context, index) => EventCard.item(event: events[index], isInSelectionMode: widget.isInSelectionMode),
        childCount: events.length,
      ),
    );
  }
}
