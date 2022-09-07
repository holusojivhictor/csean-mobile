import 'package:csean_mobile/application/bloc.dart';
import 'package:csean_mobile/domain/enums/content_type.dart';
import 'package:csean_mobile/domain/enums/enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/loading.dart';

class HomeClickableTitle extends StatelessWidget {
  const HomeClickableTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.only(top: 5),
      sliver: SliverToBoxAdapter(
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (ctx, state) => state.map(
            loading: (_) => const Loading(useScaffold: false),
            loaded: (state) {
              final contentState = state.contentType;
              switch(contentState) {
                case ContentType.event:
                  return _buildClickableTitle('Upcoming Events', 'View more', context, onClick: () => _goToTab(context, 1));
                case ContentType.blog:
                  return _buildClickableTitle('Recent Blogs', 'View more', context, onClick: () => _goToTab(context, 2));
                default:
                  throw Exception('Invalid content type');
              }
            },
          ),
        ),
      ),
    );
  }

  void _goToTab(BuildContext context, int newIndex) => context.read<MainTabBloc>().add(MainTabEvent.goToTab(index: newIndex));

  Widget _buildClickableTitle(String title, String? buttonText, BuildContext context, {Function? onClick}) {
    final theme = Theme.of(context);
    final endText = buttonText != null
        ? Text(buttonText, style: theme.textTheme.bodyText1)
        : null;
    return ListTile(
      dense: true,
      onTap: () => onClick?.call(),
      visualDensity: const VisualDensity(vertical: -4, horizontal: -2),
      trailing: endText,
      title: Text(
        title,
        textAlign: TextAlign.start,
        style: theme.textTheme.headline2!.copyWith(fontWeight: FontWeight.bold, letterSpacing: 0.15),
      ),
    );
  }
}
