import 'package:csean_mobile/domain/extensions/string_extensions.dart';
import 'package:csean_mobile/presentation/shared/details/detail_bottom_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class BlogDetailBottom extends StatelessWidget {
  final String date;
  final String authorName;
  final String title;
  final String content;

  const BlogDetailBottom({
    Key? key,
    required this.date,
    required this.authorName,
    required this.title,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DetailBottomLayout(
      isBlog: true,
      children: [
        Padding(
          padding: const EdgeInsets.all(7),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.headline4!.copyWith(fontWeight: FontWeight.bold, fontSize: 19),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: TextSpan(
                      text: 'Written by ',
                      style: theme.textTheme.bodyText2!.copyWith(color: Colors.black87),
                      children: <TextSpan> [
                        TextSpan(
                          text: authorName,
                          style: theme.textTheme.bodyText2!.copyWith(color: Colors.black87, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    date.formatDateString(hasYear: true),
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodyText2!.copyWith(fontSize: 15, color: Colors.black87),
                  ),
                ],
              ),
            ],
          ),
        ),
        Html(data: content),
      ],
    );
  }
}
