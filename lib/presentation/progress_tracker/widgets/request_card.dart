import 'package:csean_mobile/domain/assets.dart';
import 'package:csean_mobile/domain/enums/enum.dart';
import 'package:csean_mobile/domain/extensions/string_extensions.dart';
import 'package:csean_mobile/domain/models/model.dart';
import 'package:csean_mobile/presentation/shared/custom_card.dart';
import 'package:csean_mobile/theme.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class RequestCard extends StatelessWidget {
  final int id;
  final int activityId;
  final String title;
  final int point;
  final int totalPoints;
  final String completedAt;
  final ProgressRequestState requestState;

  final bool withElevation;

  const RequestCard({
    Key? key,
    required this.id,
    required this.activityId,
    required this.title,
    required this.point,
    required this.totalPoints,
    required this.completedAt,
    required this.requestState,
    this.withElevation = true,
  }) : super(key: key);

  RequestCard.item({
    Key? key,
    required RequestCardModel request,
    this.withElevation = true,
  })  : id = request.id,
        activityId = request.activityId,
        title = request.title,
        point = request.point,
        totalPoints = request.totalPoints,
        completedAt = request.completedAt,
        requestState = request.requestState,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final value = point / totalPoints;
    return CustomCard(
      clipBehavior: Clip.hardEdge,
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      shape: Styles.activityCardShape,
      elevation: withElevation ? Styles.cardTenElevation : 0,
      color: Colors.grey.withOpacity(0.25),
      child: Padding(
        padding: Styles.edgeInsetAll10,
        child: Row(
          children: [
            Expanded(
              flex: 10,
              child: CircularPercentIndicator(
                radius: 20,
                percent: value,
                circularStrokeCap: CircularStrokeCap.round,
                progressColor: Theme.of(context).colorScheme.secondary,
                center: Text(
                  '${(value * 100).toInt()}',
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              flex: 60,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 16),
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      Text(
                        completedAt.formatDateString(hasYear: true),
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.black54),
                      ),
                      const SizedBox(width: 5),
                      const CircleAvatar(
                        radius: 2,
                        backgroundColor: Colors.black54,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        Assets.translateProgressRequestStateType(requestState),
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.black54),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 20,
              child: OutlinedButton(
                onPressed: () {},
                child: const Text(
                  'Revoke',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
