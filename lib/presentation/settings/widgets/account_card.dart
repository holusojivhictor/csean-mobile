import 'package:cached_network_image/cached_network_image.dart';
import 'package:csean_mobile/application/bloc.dart';
import 'package:csean_mobile/domain/extensions/string_extensions.dart';
import 'package:csean_mobile/presentation/profile/profile_page.dart';
import 'package:csean_mobile/presentation/settings/widgets/card_header_text.dart';
import 'package:csean_mobile/presentation/settings/widgets/settings_card.dart';
import 'package:csean_mobile/presentation/shared/extensions/gender_type_extensions.dart';
import 'package:csean_mobile/presentation/shared/loading.dart';
import 'package:csean_mobile/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountCard extends StatelessWidget {
  const AccountCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const CardHeaderText(title: 'ACCOUNT', isTop: true),
        InkWell(
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (ctx) => const ProfilePage())),
          child: SettingsCard(
            child: BlocBuilder<HomeBloc, HomeState>(
              builder: (ctx, state) => state.map(
                loading: (_) => const Loading(useScaffold: false),
                loaded: (state) {
                  final profilePictureUrl = state.userAccount.photoUrl;
                  return Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          shape: BoxShape.circle,
                          border: Border.all(width: 1.5),
                        ),
                        child: BlocBuilder<SettingsBloc, SettingsState>(
                          builder: (ctx, settingsState) => settingsState.map(
                            loading: (_) => const Loading(useScaffold: false),
                            loaded: (settingsState) => Container(
                              height: 50,
                              width: 50,
                              margin: Styles.edgeInsetAll3,
                              decoration: const BoxDecoration(
                                color: Colors.transparent,
                                shape: BoxShape.circle,
                              ),
                              child: profilePictureUrl.isNotNullEmptyOrWhitespace && !settingsState.useDemoProfilePicture
                                  ? ClipOval(
                                      child: Image(
                                        fit: BoxFit.cover,
                                        image: CachedNetworkImageProvider(profilePictureUrl),
                                        filterQuality: FilterQuality.high,
                                      ),
                                    )
                                  : Image.asset(state.userAccount.gender.getDemoImage()),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Flexible(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  state.userAccount.fullName,
                                  style: theme.textTheme.headline4!.copyWith(fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  state.userAccount.email,
                                  style: theme.textTheme.headline4!.copyWith(color: Colors.black87),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
