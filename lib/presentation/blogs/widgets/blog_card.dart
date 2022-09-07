import 'package:cached_network_image/cached_network_image.dart';
import 'package:csean_mobile/application/bloc.dart';
import 'package:csean_mobile/domain/models/model.dart';
import 'package:csean_mobile/presentation/blog/blog_page.dart';
import 'package:csean_mobile/presentation/shared/animation/animated_page_route.dart';
import 'package:csean_mobile/presentation/shared/custom_card.dart';
import 'package:csean_mobile/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlogCard extends StatelessWidget {
  final int id;
  final String title;
  final String content;
  final String fileUrl;
  final int categoryId;
  final String categoryName;

  final double imgWidth;
  final double imgHeight;
  final bool withElevation;

  const BlogCard({
    Key? key,
    required this.id,
    required this.title,
    required this.content,
    required this.fileUrl,
    required this.categoryId,
    required this.categoryName,
    this.imgHeight = 100,
    this.imgWidth = 100,
    this.withElevation = true,
  }) : super(key: key);

  BlogCard.item({
    Key? key,
    required BlogCardModel blog,
    this.imgHeight = 100,
    this.imgWidth = 100,
    this.withElevation = true,
  })  : id = blog.id,
        title = blog.title,
        content = blog.content,
        fileUrl = blog.fileUrl,
        categoryId = blog.categoryId,
        categoryName = blog.categoryName,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: Styles.mainCardBorderRadius,
      onTap: () => _goToBlogPage(context),
      child: CustomCard(
        clipBehavior: Clip.hardEdge,
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 13),
        shape: Styles.mainCardShape,
        elevation: withElevation ? Styles.cardTenElevation : 0,
        color: Colors.grey.withOpacity(0.25),
        child: Padding(
          padding: Styles.edgeInsetAll10,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        BlogKeywords(text: categoryName),
                        const BlogKeywords(text: 'Test'),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Text(
                      title,
                      style: Theme.of(context).textTheme.headline6!.copyWith(fontWeight: FontWeight.w600),
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 4,
                          backgroundColor: Theme.of(context).primaryColor,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '4 min read',
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                child: Image(
                  height: imgHeight,
                  width: imgWidth,
                  image: CachedNetworkImageProvider(fileUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _goToBlogPage(BuildContext context) async {
    final bloc = context.read<BlogBloc>();
    bloc.add(BlogEvent.loadFromId(id: id));
    final route = AnimatedPageRoute(page: const BlogPage());
    await Navigator.push(context, route);
    await route.completed;
    bloc.pop();
  }
}

class BlogKeywords extends StatelessWidget {
  final String text;
  const BlogKeywords({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 7),
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        color: Colors.grey[100],
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodyText2,
        textAlign: TextAlign.center,
      ),
    );
  }
}
