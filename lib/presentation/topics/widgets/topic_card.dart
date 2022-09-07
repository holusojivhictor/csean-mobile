import 'package:cached_network_image/cached_network_image.dart';
import 'package:csean_mobile/application/bloc.dart';
import 'package:csean_mobile/domain/extensions/string_extensions.dart';
import 'package:csean_mobile/domain/models/model.dart';
import 'package:csean_mobile/presentation/discussions/messages_page.dart';
import 'package:csean_mobile/presentation/shared/custom_card.dart';
import 'package:csean_mobile/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopicCard extends StatelessWidget {
  final int id;
  final String title;
  final String creatorName;
  final String profileImage;
  final String description;
  final String dateCreated;

  final double imgWidth;
  final double imgHeight;
  final bool withElevation;

  const TopicCard({
    Key? key,
    required this.id,
    required this.title,
    required this.creatorName,
    required this.profileImage,
    required this.description,
    required this.dateCreated,
    this.imgHeight = 100,
    this.imgWidth = 100,
    this.withElevation = true,
  }) : super(key: key);

  TopicCard.item({
    Key? key,
    required TopicCardModel topic,
    this.imgHeight = 100,
    this.imgWidth = 100,
    this.withElevation = true,
  })  : id = topic.id,
        title = topic.name,
        creatorName = topic.creatorName,
        profileImage = topic.profilePic,
        description = topic.desc,
        dateCreated = topic.dateCreated,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: Styles.mainCardBorderRadius,
      onTap: () => _goToMessagesPage(context),
      child: CustomCard(
        clipBehavior: Clip.hardEdge,
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 13),
        shape: Styles.mainCardShape,
        elevation: withElevation ? Styles.cardTenElevation : 0,
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 5),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    decoration: const BoxDecoration(
                      color: Colors.transparent,
                      shape: BoxShape.circle,
                    ),
                    child: profileImage.isNotNullEmptyOrWhitespace
                        ? ClipRRect(borderRadius: BorderRadius.circular(40), child: Image(fit: BoxFit.cover, image: CachedNetworkImageProvider(profileImage), filterQuality: FilterQuality.high))
                        : Image.asset('assets/place-holder/128_4.png'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          title,
                          style: Theme.of(context).textTheme.headline2!.copyWith(fontWeight: FontWeight.w300, fontSize: 19),
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.start,
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            Text(
                              creatorName,
                              style: Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 13, fontWeight: FontWeight.w600),
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.start,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              dateCreated.formatDateString(hasYear: true),
                              style: Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 13),
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.start,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Divider(color: Colors.grey, indent: 5, height: 10),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _goToMessagesPage(BuildContext context) async {
    final bloc = context.read<MessagesBloc>();
    bloc.add(MessagesEvent.init(id: id));
    final route = MaterialPageRoute(builder: (c) => const MessagesPage());
    await Navigator.push(context, route);
    await route.completed;
  }
}
