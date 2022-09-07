import 'package:csean_mobile/domain/models/model.dart';
import 'package:csean_mobile/presentation/events/widgets/event_card.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:responsive_grid/responsive_grid.dart';

class SliverDemoEvents extends StatelessWidget {
  final List<EventCardModel> demoEvents;
  final bool useListView;

  const SliverDemoEvents({
    Key? key,
    required this.demoEvents,
    this.useListView = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isPortrait = mediaQuery.orientation == Orientation.portrait;
    if (useListView) {
      return SliverToBoxAdapter(
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: 2,
          physics: const NeverScrollableScrollPhysics(),
          scrollDirection: isPortrait ? Axis.vertical : Axis.horizontal,
          itemBuilder: (ctx, index) {
            final e = demoEvents[index];
            return EventCard.item(event: e);
          },
        ),
      );
    }

    final deviceType = getDeviceType(mediaQuery.size);
    return SliverToBoxAdapter(
      child: ResponsiveGridRow(
        children: demoEvents.map((e) {
          final child = EventCard.item(event: e);

          switch (deviceType) {
            case DeviceScreenType.mobile:
              return ResponsiveGridCol(
                sm: isPortrait ? 12 : 6,
                md: isPortrait ? 6 : 4,
                xs: isPortrait ? 6 : 3,
                xl: isPortrait ? 3 : 2,
                child: child,
              );
            case DeviceScreenType.desktop:
            case DeviceScreenType.tablet:
              return ResponsiveGridCol(
                sm: isPortrait ? 3 : 4,
                md: isPortrait ? 4 : 3,
                xs: 3,
                xl: 3,
                child: child,
              );
            default:
              return ResponsiveGridCol(sm: 4, md: 3, xs: 4, xl: 3,child: child);
          }
        }).toList(),
      ),
    );
  }
}
