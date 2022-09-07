import 'package:csean_mobile/application/bloc.dart';
import 'package:csean_mobile/domain/app_constants.dart';
import 'package:csean_mobile/presentation/onboarding/widgets/custom_form_field.dart';
import 'package:csean_mobile/presentation/onboarding/widgets/proceed_button.dart';
import 'package:csean_mobile/presentation/onboarding/widgets/text_box.dart';
import 'package:csean_mobile/presentation/shared/choice_buttons.dart';
import 'package:csean_mobile/presentation/shared/custom_full_dropdown_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import '../widgets/header_text.dart';

class AboutYou extends StatefulWidget {
  const AboutYou({Key? key}) : super(key: key);

  @override
  State<AboutYou> createState() => _AboutYouState();
}

class _AboutYouState extends State<AboutYou> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late String selectedMembershipTypeValue = 'Student';
  late String selectedChapterValue = 'Lagos';
  late String selectedOccupationValue = 'Cyber Security Analyst';
  late TextEditingController jobTitleController = TextEditingController();
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TextBox(
          headerText: 'Tell us about you',
          bodyText: 'Please tell us a bit about you so we can personalize your experience.',
        ),
        const SizedBox(height: 15),
        const HeaderText(text: 'You are a(an),'),
        ChoiceButtons(
          selectedValue: selectedMembershipTypeValue,
          onClick: (value) {
            setState(() {
              selectedMembershipTypeValue = value;
            });
          },
        ),
        const HeaderText(text: 'You are from,'),
        CustomFullDropdownButton<dynamic>(
          margin: EdgeInsets.zero,
          title: 'Select state...',
          currentValue: selectedChapterValue,
          items: chaptersMap.map((e) => e["name"]!).toList(),
          onChanged: (value) {
            setState(() {
              selectedChapterValue = value;
            });
          },
        ),
        const HeaderText(text: 'You currently work as a,'),
        CustomFullDropdownButton<String>(
          margin: EdgeInsets.zero,
          title: 'Select profession...',
          currentValue: selectedOccupationValue,
          items: occupations,
          onChanged: (value) {
            setState(() {
              selectedOccupationValue = value;
            });
          },
        ),
        const HeaderText(text: 'Job Title'),
        Form(
          key: _formKey,
          child: OnboardingFormField(
            textEditingController: jobTitleController,
            textInputType: TextInputType.name,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ProceedButton(
              text: 'Proceed to next step',
              isPressed: isPressed,
              onPressed: () {
                setState(() {
                  isPressed = !isPressed;
                });
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                }
                final chapterId = chaptersMap.where((el) => el["name"] == selectedChapterValue).toList();
                final int id = chapterId[0]["id"];

                context.read<OnboardingBloc>().add(OnboardingEvent.second(membershipType: selectedMembershipTypeValue, memberChapter: id, occupation: selectedOccupationValue, jobTitle: jobTitleController.text));
              },
            ),
          ],
        ),
      ],
    );
  }
}
