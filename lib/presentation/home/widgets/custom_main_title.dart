import 'package:cached_network_image/cached_network_image.dart';
import 'package:csean_mobile/application/bloc.dart';
import 'package:csean_mobile/presentation/profile/profile_page.dart';
import 'package:csean_mobile/domain/extensions/string_extensions.dart';
import 'package:csean_mobile/presentation/shared/extensions/gender_type_extensions.dart';
import 'package:csean_mobile/presentation/shared/loading.dart';
import 'package:csean_mobile/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomMainTitle extends StatelessWidget {
  const CustomMainTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SliverPadding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      sliver: SliverToBoxAdapter(
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (ctx, state) => state.map(
              loading: (_) => const Loading(useScaffold: false),
              loaded: (state) {
                final profilePictureUrl = state.userAccount.photoUrl;
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Dashboard',
                      style: theme.textTheme.headline6!.copyWith(fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 30,
                          child: Stack(
                            children: [
                              const Icon(Icons.message_outlined),
                              Positioned(
                                left: 13,
                                top: 0,
                                child: Container(
                                  height: 13,
                                  width: 13,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.redAccent,
                                  ),
                                  child: Text(
                                    '5',
                                    textAlign: TextAlign.center,
                                    style: theme.textTheme.headline3!.copyWith(color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (ctx) => const ProfilePage()));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              shape: BoxShape.circle,
                              border: Border.all(width: 2),
                            ),
                            child: Container(
                              height: 50,
                              width: 50,
                              margin: Styles.edgeInsetAll3,
                              decoration: const BoxDecoration(
                                color: Colors.transparent,
                                shape: BoxShape.circle,
                              ),
                              child: profilePictureUrl.isNotNullEmptyOrWhitespace
                                  ? ClipOval(child: Image(fit: BoxFit.cover, image: CachedNetworkImageProvider(profilePictureUrl), filterQuality: FilterQuality.high))
                                  : Image.asset(state.userAccount.gender.getDemoImage()),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              }
          ),
        ),
      ),
    );
  }
}

