import 'package:csean_mobile/application/bloc.dart';
import 'package:csean_mobile/domain/models/model.dart';
import 'package:csean_mobile/presentation/shared/custom_full_dropdown_button.dart';
import 'package:csean_mobile/presentation/shared/utils/enum_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ActivityDropDown extends StatelessWidget {
  final ActivityCardModel currentActivity;
  final List<ActivityCardModel> activities;

  const ActivityDropDown({
    Key? key,
    required this.currentActivity,
    required this.activities,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final translatedValues = EnumUtils.getTranslatedAndSortedEnum<ActivityCardModel>(
      activities, (activity, _) => activity.title,
    );

    return CustomFullDropdownButton<ActivityCardModel>(
      margin: EdgeInsets.zero,
      title: 'Select activity',
      isTranslated: true,
      currentValue: translatedValues.firstWhere((element) => element.enumValue == currentActivity).enumValue,
      translatedItems: translatedValues,
      onChanged: (value) => context.read<ProgressTrackerBloc>().add(ProgressTrackerEvent.activityChanged(newValue: value)),
    );
  }
}
