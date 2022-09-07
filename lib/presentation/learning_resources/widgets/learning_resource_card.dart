import 'package:csean_mobile/application/bloc.dart';
import 'package:csean_mobile/domain/enums/enum.dart';
import 'package:csean_mobile/domain/models/model.dart';
import 'package:csean_mobile/presentation/learning_resource/resource_page.dart';
import 'package:csean_mobile/presentation/shared/animation/animated_page_route.dart';
import 'package:csean_mobile/presentation/shared/custom_card.dart';
import 'package:csean_mobile/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LearningResourceCard extends StatelessWidget {
  final int id;
  final int categoryId;
  final ResourceCategoryType categoryType;
  final String name;
  final String image;
  final String description;

  final double imgWidth;
  final double imgHeight;
  final bool withElevation;

  const LearningResourceCard({
    Key? key,
    required this.id,
    required this.categoryId,
    required this.categoryType,
    required this.name,
    required this.image,
    required this.description,
    this.imgHeight = 150,
    this.imgWidth = 200,
    this.withElevation = true,
  }) : super(key: key);

  LearningResourceCard.item({
    Key? key,
    required SubCategoryCardModel resource,
    this.imgHeight = 150,
    this.imgWidth = 200,
    this.image = 'assets/place-holder/gummy-macbook.png',
    this.withElevation = true,
  })  : id = resource.id,
        categoryId = resource.categoryId,
        categoryType = resource.categoryType,
        name = resource.name,
        description = resource.desc,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> images = [
      'assets/place-holder/cyborg-machine-learning.png',
      'assets/place-holder/cyborg-machine-learning-1.png',
      'assets/place-holder/glossy-gaming.png',
      'assets/place-holder/gummy-macbook.png',
      'assets/place-holder/gummy-macbook.png',
      'assets/place-holder/handy-machine-learning.png',
    ];

    List<int> colors = [
      0xFFFFE3F1,
      0xFFE3FFEE,
      0xFFE7E3FF,
      0xFFE3F8FF,
      0xFFDFE4E0,
      0xFFFFEAE3,
    ];

    final theme = Theme.of(context);
    return InkWell(
      borderRadius: Styles.resourceCardBorderRadius,
      onTap: () => _goToResourcePage(context),
      child: CustomCard(
        clipBehavior: Clip.hardEdge,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        shape: Styles.resourceCardShape,
        shadowColor: Colors.white30,
        isBuggy: true,
        elevation: withElevation ? Styles.cardTenElevation : 0,
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(topRight: Radius.circular(10), topLeft: Radius.circular(10)),
                color: Color(colors[categoryId]),
              ),
              child: Image(
                width: imgWidth,
                height: imgHeight,
                image: AssetImage(images[categoryId]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.headline4!.copyWith(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    description,
                    style: Theme.of(context).textTheme.bodyText2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 5),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _goToResourcePage(BuildContext context) async {
    final bloc = context.read<ResourceBloc>();
    bloc.add(ResourceEvent.loadFromIds(categoryId: categoryId, subCategoryId: id));
    final route = AnimatedPageRoute(page: const ResourcePage());
    await Navigator.push(context, route);
    await route.completed;
  }
}
