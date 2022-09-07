import 'package:csean_mobile/application/bloc.dart';
import 'package:csean_mobile/domain/extensions/string_extensions.dart';
import 'package:csean_mobile/presentation/profile/widgets/top_layout.dart';
import 'package:csean_mobile/presentation/profile_edit/widgets/bottom_edit_layout.dart';
import 'package:csean_mobile/presentation/shared/custom_alert_dialog.dart';
import 'package:csean_mobile/presentation/shared/default_button.dart';
import 'package:csean_mobile/presentation/shared/extensions/gender_type_extensions.dart';
import 'package:csean_mobile/presentation/shared/loading.dart';
import 'package:csean_mobile/presentation/shared/sliver_scaffold_with_fab.dart';
import 'package:csean_mobile/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileEditPage extends StatelessWidget {
  const ProfileEditPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (ctx, state) => state.map(
        loading: (_) => const Loading(),
        loaded: (state) {
          final profile = state.profile;
          return WillPopScope(
            onWillPop: () => handleWillPop(context),
            child: SliverScaffoldWithFab(
              slivers: [
                SliverAppBar(
                  toolbarHeight: 36,
                  elevation: 0.0,
                  title: Text(
                    'Edit profile',
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  backgroundColor: Colors.transparent,
                  automaticallyImplyLeading: false,
                  leading: InkWell(
                    onTap: () => _pressBackButton(context),
                    child: const Icon(Icons.keyboard_backspace_rounded, color: Colors.black),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      TopLayout(
                        smallImage: state.photoUrl,
                        demoImage: profile.gender.getDemoImage(),
                        isSmallNotNull: state.photoUrl.isNotNullEmptyOrWhitespace,
                        isPictureSet: state.isHeaderSet,
                        savedImage: state.headerImage,
                        update: state.isUpdating,
                        isEdit: true,
                      ),
                      BottomEditLayout(
                        firstName: state.firstName,
                        lastName: state.lastName,
                        emailAddress: state.email,
                        companyName: profile.companyName!,
                        occupation: profile.currentOccupation!,
                        jobTitle: profile.jobTitle!,
                        dateOfBirth: state.profile.dateOfBirth ?? '1860-01-01',
                        phoneNumber: state.phone.isNotNullEmptyOrWhitespaceNorHasNull ? state.phone : 'N/A',
                        workAddress: profile.address!,
                        workCity: profile.city!,
                        workCountry: profile.country!,
                        gender: profile.gender,
                        membershipType: profile.membershipType!,
                        update: state.isUpdating,
                      ),
                    ],
                  ),
                ),
              ],
              bottomNavigationBar: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(color: Colors.grey),
                  ),
                ),
                child: BlocBuilder<DataBloc, DataState>(
                  builder: (ct, dataState) => dataState.map(
                    loading: (_) => const ProgressButton(
                      padding: Styles.edgeInsetVertical5,
                      minHeight: 45,
                    ),
                    loaded: (dataState) => DefaultButton(
                      backgroundColor: dataState.isDoneUpdating ? Colors.grey : null,
                      padding: Styles.edgeInsetVertical5,
                      borderRadius: 12,
                      minHeight: 45,
                      isPrimary: true,
                      text: dataState.isDoneUpdating ? 'Update done' : 'Save',
                      onPressed: dataState.isDoneUpdating ? () {
                        Navigator.pop(context);
                        context.read<DataBloc>().add(const DataEvent.initData());
                      } : () => context.read<ProfileBloc>().add(ProfileEvent.updatingProfile(isUpdating: !state.isUpdating)),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _pressBackButton(BuildContext context) {
    bool isUpdating = false;
    final blocState = BlocProvider.of<DataBloc>(context).state;
    blocState.maybeMap(loaded : (state) {
      isUpdating = state.isDoneUpdating;
    }, orElse: () => false);

    if (isUpdating) {
      Navigator.of(context).pop();
      context.read<DataBloc>().add(const DataEvent.initData());
      return;
    }

    showDialog(
      context: context,
      builder: (ctx) => CommonAlertDialog(
        titleText: 'Discard changes',
        contentText: 'Are you sure you want to discard the changes you made?',
        cancelText: 'No thanks',
        actionText: 'Discard',
        actionOnPressed: () {
          Navigator.of(context).pop();
          Navigator.of(context).pop();
          context.read<DataBloc>().add(const DataEvent.initData());
        },
      ),
    );
  }

  Future<bool> handleWillPop(BuildContext context) async {
    bool isUpdating = false;
    final blocState = BlocProvider.of<DataBloc>(context).state;
    blocState.maybeMap(loaded : (state) {
      isUpdating = state.isDoneUpdating;
    }, orElse: () => false);

    if (isUpdating) {
      context.read<DataBloc>().add(const DataEvent.initData());
      return true;
    }

    showDialog(
      context: context,
      builder: (ctx) => CommonAlertDialog(
        titleText: 'Discard changes',
        contentText: 'Are you sure you want to discard the changes you made?',
        cancelText: 'No thanks',
        actionText: 'Discard',
        actionOnPressed: () {
          Navigator.of(context).pop();
          Navigator.of(context).pop();
          context.read<DataBloc>().add(const DataEvent.initData());
        },
      ),
    );
    return false;
  }
}
