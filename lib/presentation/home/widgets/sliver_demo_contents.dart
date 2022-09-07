import 'package:csean_mobile/application/bloc.dart';
import 'package:csean_mobile/domain/enums/enum.dart';
import 'package:csean_mobile/presentation/home/widgets/sliver_demo_blogs.dart';
import 'package:csean_mobile/presentation/home/widgets/sliver_demo_events.dart';
import 'package:csean_mobile/presentation/shared/sliver_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SliverDemoContents extends StatelessWidget {
  const SliverDemoContents({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (ctx, state) => state.map(
        loading: (_) => const SliverLoading(),
        loaded: (state) {
          final contentState = state.contentType;
          switch (contentState) {
            case ContentType.event:
              return SliverDemoEvents(demoEvents: state.events);
            case ContentType.blog:
              return SliverDemoBlogs(demoBlogs: state.blogs);
            default:
              throw Exception('Invalid content type');
          }
        },
      ),
    );
  }
}
