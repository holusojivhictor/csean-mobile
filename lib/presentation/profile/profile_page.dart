import 'package:csean_mobile/application/bloc.dart';
import 'package:csean_mobile/domain/assets.dart';
import 'package:csean_mobile/presentation/profile/widgets/bottom_layout.dart';
import 'package:csean_mobile/presentation/profile/widgets/top_layout.dart';
import 'package:csean_mobile/presentation/shared/extensions/gender_type_extensions.dart';
import 'package:csean_mobile/presentation/shared/loading.dart';
import 'package:csean_mobile/domain/extensions/string_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/request_card.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (ctx, state) => state.map(
        loading: (_) => const Loading(),
        loaded: (state) {
          final profilePictureUrl = state.photoUrl;
          return Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TopLayout(
                      isPictureSet: state.isHeaderSet,
                      isEdit: false,
                      update: state.isUpdating,
                      savedImage: state.headerImage,
                      isSmallNotNull: profilePictureUrl.isNotNullEmptyOrWhitespace,
                      smallImage: profilePictureUrl,
                      demoImage: state.profile.gender.getDemoImage(),
                      appBar: AppBar(
                        backgroundColor: Colors.transparent,
                        elevation: 0.0,
                      ),
                    ),
                    BottomLayout(
                      fullName: state.fullName,
                      email: state.email,
                      occupation: state.profile.currentOccupation!,
                      chapterName: Assets.translateChapterName(state.profile.chapter!.name),
                      companyName: state.profile.companyName!,
                      city: state.profile.city!,
                      address: state.profile.address!,
                      membershipType: Assets.translateMembershipType(state.profile.membershipType!),
                    ),
                    const RequestCard(),
                    const Divider(color: Colors.grey),
                  ],
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}
