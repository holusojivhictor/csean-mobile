import 'package:csean_mobile/application/bloc.dart';
import 'package:csean_mobile/domain/assets.dart';
import 'package:csean_mobile/domain/enums/enum.dart';
import 'package:csean_mobile/domain/models/model.dart';
import 'package:csean_mobile/presentation/event/event_page.dart';
import 'package:csean_mobile/presentation/shared/animation/animated_page_route.dart';
import 'package:csean_mobile/presentation/shared/custom_card.dart';
import 'package:csean_mobile/presentation/shared/images/free_paid_avatar.dart';
import 'package:csean_mobile/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:csean_mobile/domain/extensions/string_extensions.dart';

class EventCard extends StatelessWidget {
  final int id;
  final String title;
  final String image;
  final String date;
  final String time;
  final String venue;
  final EventPaymentType type;
  final bool subscribed;

  final double imgWidth;
  final double imgHeight;
  final bool isInSelectionMode;
  final bool withElevation;

  const EventCard({
    Key? key,
    required this.id,
    required this.title,
    required this.image,
    required this.date,
    required this.time,
    required this.venue,
    required this.type,
    required this.subscribed,
    this.imgHeight = 140,
    this.imgWidth = 300,
    this.isInSelectionMode = false,
    this.withElevation = true,
  }) : super(key: key);

  EventCard.item({
    Key? key,
    required EventCardModel event,
    this.imgHeight = 155,
    this.imgWidth = 300,
    this.image = 'assets/place-holder/casual-image.png',
    this.isInSelectionMode = false,
    this.withElevation = false,
  })  : id = event.id,
        title = event.title,
        date = event.date,
        time = event.time,
        venue = event.venue,
        type = event.type,
        subscribed = event.subscribed,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      borderRadius: Styles.mainCardBorderRadius,
      onTap: () => _goToEventPage(context),
      child: CustomCard(
        clipBehavior: Clip.hardEdge,
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 13),
        shape: Styles.mainCardShape,
        elevation: withElevation ? Styles.cardThreeElevation : 0,
        color: Colors.grey.withOpacity(0.25),
        child: Padding(
          padding: Styles.edgeInsetAll10,
          child: Column(
            children: [
              Stack(
                alignment: AlignmentDirectional.topCenter,
                fit: StackFit.passthrough,
                children: [
                  Image(
                    width: imgWidth,
                    height: imgHeight,
                    image: AssetImage(image),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FreePaidAvatar(text: Assets.translateEventPaymentType(type)),
                      Icon(subscribed ? Icons.favorite : Icons.favorite_border_outlined, color: theme.primaryColor),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.headline4!.copyWith(fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Icon(Icons.location_pin, size: 22),
                          const SizedBox(width: 5),
                          Text(
                            venue,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.bodyText2!.copyWith(fontSize: 15),
                          ),
                          const SizedBox(width: 10),
                          const Icon(Icons.access_time, size: 22),
                          const SizedBox(width: 5),
                          Text(time.formatTimeString(),
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.bodyText2!.copyWith(fontSize: 15),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    width: 40,
                    padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 2),
                    decoration: ShapeDecoration(
                      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4))),
                      color: theme.primaryColor.withOpacity(0.5),
                    ),
                    child: Text(
                      '${date.formatDateString()}.',
                      style: theme.textTheme.headline6!.copyWith(fontSize: 18, color: Colors.white),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _goToEventPage(BuildContext context) async {
    if (isInSelectionMode) {
      Navigator.pop(context, id);
      return;
    }

    final bloc = context.read<CommunityEventBloc>();
    bloc.add(CommunityEventEvent.loadFromId(id: id));
    final route = AnimatedPageRoute(page: const EventPage());
    await Navigator.push(context, route);
    await route.completed;
    bloc.pop();
  }
}
