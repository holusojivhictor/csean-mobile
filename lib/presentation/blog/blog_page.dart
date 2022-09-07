import 'package:csean_mobile/application/bloc.dart';
import 'package:csean_mobile/presentation/blog/widgets/blog_detail_bottom.dart';
import 'package:csean_mobile/presentation/blog/widgets/blog_detail_top.dart';
import 'package:csean_mobile/presentation/shared/loading.dart';
import 'package:csean_mobile/presentation/shared/sliver_scaffold_with_fab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlogPage extends StatelessWidget {
  const BlogPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const _PortraitLayout();
  }
}

class _PortraitLayout extends StatelessWidget {
  const _PortraitLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BlogBloc, BlogState>(
      builder: (ctx, state) => state.map(
        loading: (_) => const Loading(),
        loaded: (state) => SliverScaffoldWithFab(
          slivers: [
            SliverToBoxAdapter(
              child: Stack(
                fit: StackFit.passthrough,
                clipBehavior: Clip.none,
                alignment: Alignment.topCenter,
                children: [
                  BlogDetailTop(image: state.fileUrl),
                  BlogDetailBottom(
                    date: state.createdAt,
                    authorName: state.author.fullName,
                    title: state.title,
                    content: state.content,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class _LandscapeLayout extends StatelessWidget {
  const _LandscapeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}