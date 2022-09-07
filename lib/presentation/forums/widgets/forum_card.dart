import 'package:csean_mobile/application/bloc.dart';
import 'package:csean_mobile/domain/models/model.dart';
import 'package:csean_mobile/presentation/shared/custom_card.dart';
import 'package:csean_mobile/presentation/topics/topics_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:csean_mobile/theme.dart';
import 'package:flutter/material.dart';

class ForumCard extends StatelessWidget {
  final int id;
  final String name;
  final String description;
  final int privacy;
  final String image;

  final double imgWidth;
  final double imgHeight;
  final bool withElevation;

  const ForumCard({
    Key? key,
    required this.id,
    required this.name,
    required this.description,
    required this.privacy,
    required this.image,
    this.imgHeight = 100,
    this.imgWidth = 100,
    this.withElevation = true,
  }) : super(key: key);

  ForumCard.item({
    Key? key,
    required ForumCardModel forum,
    this.imgHeight = 100,
    this.imgWidth = 100,
    this.image = 'assets/place-holder/gummy-macbook.png',
    this.withElevation = false,
  })  : id = forum.id,
        name = forum.name,
        description = forum.desc,
        privacy = forum.privacy,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: Styles.mainCardBorderRadius,
      onTap: () => _goToTopicsPage(context),
      child: CustomCard(
        clipBehavior: Clip.hardEdge,
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 13),
        shape: Styles.mainCardShape,
        elevation: withElevation ? Styles.cardTenElevation : 0,
        color: Colors.grey.withOpacity(0.25),
        child: Padding(
          padding: Styles.edgeInsetHorizontal5,
          child: Row(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                child: Image(
                  height: imgHeight,
                  width: imgWidth,
                  image: AssetImage(image),
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      name,
                      style: Theme.of(context).textTheme.headline2!.copyWith(fontWeight: FontWeight.w600),
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      description,
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(fontWeight: FontWeight.w200),
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Icon(Icons.people_alt_rounded, size: 15),
                        const SizedBox(width: 8),
                        Text(
                          '20 members',
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _goToTopicsPage(BuildContext context) async {
    final bloc = context.read<TopicsBloc>();
    bloc.add(TopicsEvent.init(id: id));
    final route = MaterialPageRoute(builder: (c) => const TopicsPage());
    await Navigator.push(context, route);
    await route.completed;
  }
}
