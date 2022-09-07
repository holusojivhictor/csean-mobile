import 'package:csean_mobile/domain/models/model.dart';
import 'package:csean_mobile/presentation/blogs/widgets/blog_card.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:responsive_grid/responsive_grid.dart';

class SliverDemoBlogs extends StatelessWidget {
  final List<BlogCardModel> demoBlogs;
  final bool useListView;

  const SliverDemoBlogs({
    Key? key,
    required this.demoBlogs,
    this.useListView = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (useListView) {
      return SliverToBoxAdapter(
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: 3,
          physics: const NeverScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          itemBuilder: (ctx, index) {
            final e = demoBlogs[index];
            return BlogCard.item(blog: e);
          },
        ),
      );
    }

    final mediaQuery = MediaQuery.of(context);
    final deviceType = getDeviceType(mediaQuery.size);
    final isPortrait = mediaQuery.orientation == Orientation.portrait;
    return SliverToBoxAdapter(
      child: ResponsiveGridRow(
        children: demoBlogs.map((e) {
          final child = BlogCard.item(blog: e);

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
