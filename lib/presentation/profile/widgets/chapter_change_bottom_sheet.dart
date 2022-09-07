import 'package:csean_mobile/application/bloc.dart';
import 'package:csean_mobile/domain/assets.dart';
import 'package:csean_mobile/domain/enums/enum.dart';
import 'package:csean_mobile/presentation/profile/widgets/chapter_change_dropdown.dart';
import 'package:csean_mobile/presentation/shared/bottom_sheets/common_bottom_sheet.dart';
import 'package:csean_mobile/presentation/shared/bottom_sheets/common_button_bar.dart';
import 'package:csean_mobile/presentation/shared/extensions/chapter_request_state_extensions.dart';
import 'package:csean_mobile/presentation/shared/loading.dart';
import 'package:csean_mobile/presentation/shared/utils/toast_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChapterChangeBottomSheet extends StatelessWidget {
  const ChapterChangeBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CommonBottomSheet(
      title: 'Change request',
      titleIcon: Icons.edit_outlined,
      showOkButton: false,
      showCancelButton: false,
      child: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (ctx, state) => state.map(
          loading: (_) => const Loading(useScaffold: false),
          loaded: (state) => Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text('Status'),
              Row(
                children: [
                  Text(
                    'Current status:  ',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  Text(
                    Assets.translateChapterRequestState(state.requestState),
                    style: Theme.of(context).textTheme.headline4!.copyWith(color: state.requestState.getTextColor()),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              ChapterChangeDropdown(
                selectedValue: state.tempChapterType,
                isActive: state.requestState == ChapterRequestState.inactive,
              ),
              _ButtonBar(
                chapterType: state.tempChapterType,
                currentChapter: state.profile.chapter!.name,
                isVisible: state.requestState == ChapterRequestState.inactive,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ButtonBar extends StatelessWidget {
  final ChapterType chapterType;
  final ChapterType currentChapter;
  final bool isVisible;

  const _ButtonBar({
    Key? key,
    required this.chapterType,
    required this.currentChapter,
    required this.isVisible,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return CommonButtonBar(
      children: <Widget>[
        OutlinedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Cancel', style: TextStyle(color: theme.primaryColor)),
        ),
        if (isVisible)
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(theme.primaryColor.withOpacity(0.7)),
            ),
            onPressed: () {
              final fToast = ToastUtils.of(context);
              if (chapterType == currentChapter) {
                ToastUtils.showInfoToast(fToast, 'Choose a new chapter location');
                return;
              }
              context.read<ProfileBloc>().add(ProfileEvent.makeChangeRequest(value: chapterType));
              Navigator.pop(context);
              ToastUtils.showInfoToast(fToast, 'Request sent successfully');
            },
            child: const Text('Submit'),
          ),
      ],
    );
  }
}