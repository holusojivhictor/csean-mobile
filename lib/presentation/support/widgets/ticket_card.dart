import 'package:csean_mobile/domain/assets.dart';
import 'package:csean_mobile/domain/enums/enum.dart';
import 'package:csean_mobile/domain/extensions/string_extensions.dart';
import 'package:csean_mobile/domain/models/model.dart';
import 'package:csean_mobile/presentation/shared/custom_card.dart';
import 'package:csean_mobile/presentation/shared/extensions/support_stage_type_extensions.dart';
import 'package:csean_mobile/presentation/support/widgets/container_tag.dart';
import 'package:csean_mobile/theme.dart';
import 'package:flutter/material.dart';

class TicketCard extends StatelessWidget {
  final int id;
  final String ticketKey;
  final String subject;
  final String message;
  final String createdAt;
  final SupportStageType supportStage;
  final String userAssigned;

  final bool withElevation;

  const TicketCard({
    Key? key,
    required this.id,
    required this.ticketKey,
    required this.subject,
    required this.message,
    required this.createdAt,
    required this.supportStage,
    required this.userAssigned,
    this.withElevation = true,
  }) : super(key: key);

  TicketCard.item({
    Key? key,
    required TicketCardModel ticket,
    this.withElevation = true,
  })  : id = ticket.id,
        ticketKey = ticket.ticketKey,
        subject = ticket.subject,
        message = ticket.message,
        createdAt = ticket.createdAt,
        supportStage = ticket.supportStage,
        userAssigned = ticket.assigned,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      borderRadius: Styles.mainCardBorderRadius,
      onTap: () {},
      child: CustomCard(
        clipBehavior: Clip.hardEdge,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        elevation: withElevation ? Styles.cardTenElevation : 0,
        shadowColor: Colors.white10,
        color: Colors.white,
        child: Padding(
          padding: Styles.edgeInsetAll10,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ContainerTag(tagText: ticketKey),
                  Text(
                    createdAt.formatDateString(),
                    style: theme.textTheme.bodyText2!.copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Text(
                  subject,
                  style: theme.textTheme.headline2!.copyWith(fontSize: 17),
                ),
              ),
              Padding(
                padding: Styles.edgeInsetVertical5,
                child: Text(
                  message,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.headline4!.copyWith(fontSize: 14, fontWeight: FontWeight.w100),
                ),
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  ContainerTag(
                    tagText: Assets.translateSupportStageType(supportStage),
                    hasBorder: false,
                    color: supportStage.getBoxColor(),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: CircleAvatar(
                      radius: 2,
                      backgroundColor: Colors.grey,
                    ),
                  ),
                  Text(userAssigned),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
