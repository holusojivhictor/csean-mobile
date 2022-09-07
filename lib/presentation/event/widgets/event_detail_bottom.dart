import 'package:csean_mobile/presentation/event/widgets/icon_text_row.dart';
import 'package:csean_mobile/presentation/shared/details/detail_bottom_layout.dart';
import 'package:csean_mobile/domain/extensions/string_extensions.dart';
import 'package:flutter/material.dart';

import 'video_player.dart';

class EventDetailBottom extends StatelessWidget {
  final String date;
  final String time;
  final String title;
  final String venue;
  final int span;
  final String videoUrl;
  final String description;
  final int totalSubscribers;

  final bool addSub;

  const EventDetailBottom({
    Key? key,
    required this.date,
    required this.time,
    required this.title,
    required this.venue,
    required this.span,
    required this.videoUrl,
    required this.description,
    required this.totalSubscribers,
    required this.addSub,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final subscribers = addSub ? totalSubscribers + 1 : totalSubscribers;
    return DetailBottomLayout(
      children: [
        Row(
          children: [
            IconTextRow(icon: Icons.calendar_today, text: '${date.signParseDate()} - ${date.parseDateSpan(span)}'),
            const SizedBox(width: 20),
            IconTextRow(icon: Icons.access_time, text: time.formatTimeString()),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          title,
          overflow: TextOverflow.ellipsis,
          style: theme.textTheme.headline4!.copyWith(fontWeight: FontWeight.bold, fontSize: 19),
        ),
        const SizedBox(height: 5),
        IconTextRow(icon: Icons.location_on_outlined, text: venue, iconColor: Colors.black87),
        const SizedBox(height: 15),
        Text(
          "Description",
          overflow: TextOverflow.ellipsis,
          style: theme.textTheme.headline4!.copyWith(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 10),
        Text(
          description,
          style: theme.textTheme.headline4!.copyWith(fontSize: 16),
          textAlign: TextAlign.justify,
        ),
        const SizedBox(height: 20),
        Text(
          "Video Showcase",
          overflow: TextOverflow.ellipsis,
          style: theme.textTheme.headline4!.copyWith(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 10),
        VideoPlayer(videoUrl: videoUrl),
        const SizedBox(height: 10),
        Text(
          subscribers < 2 ? '$subscribers user joined' : '$subscribers users joined',
          style: theme.textTheme.headline4!.copyWith(fontSize: 16, color: Colors.black87),
          textAlign: TextAlign.justify,
        ),
      ],
    );
  }
}
