import 'package:csean_mobile/application/bloc.dart';
import 'package:csean_mobile/domain/models/model.dart';
import 'package:csean_mobile/presentation/app_widget.dart';
import 'package:csean_mobile/presentation/onboarding/widgets/text_box.dart';
import 'package:csean_mobile/presentation/shared/custom_alert_dialog.dart';
import 'package:csean_mobile/presentation/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/custom_form_field.dart';
import '../widgets/header_text.dart';
import '../widgets/proceed_button.dart';

class FirstRefereePage extends StatefulWidget {
  const FirstRefereePage({Key? key}) : super(key: key);

  @override
  State<FirstRefereePage> createState() => _FirstRefereePageState();
}

class _FirstRefereePageState extends State<FirstRefereePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController firstNameController = TextEditingController();
  late TextEditingController firstOccupationController = TextEditingController();
  late TextEditingController firstEmailController = TextEditingController();
  late TextEditingController firstPhoneController = TextEditingController();
  late TextEditingController firstRelationshipController = TextEditingController();
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TextBox(
            headerText: "Referees' details",
            bodyText: 'Provide details for referees of choice.',
          ),
          const SizedBox(height: 10),
          Text('Referee 1', style: Theme.of(context).textTheme.headline2),
          const HeaderText(text: 'Full name'),
          OnboardingFormField(
            textEditingController: firstNameController,
            textInputType: TextInputType.name,
          ),
          const HeaderText(text: 'Occupation'),
          OnboardingFormField(
            textEditingController: firstOccupationController,
            textInputType: TextInputType.name,
          ),
          const HeaderText(text: 'Email address'),
          OnboardingFormField(
            textEditingController: firstEmailController,
            textInputType: TextInputType.emailAddress,
          ),
          const HeaderText(text: 'Phone number'),
          OnboardingFormField(
            textEditingController: firstPhoneController,
            textInputType: TextInputType.phone,
            maxLength: 11,
          ),
          const HeaderText(text: 'Relationship'),
          OnboardingFormField(
            textEditingController: firstRelationshipController,
            textInputType: TextInputType.name,
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ProceedButton(
                text: 'Back',
                isBack: true,
                onPressed: () {
                  context.read<OnboardingBloc>().add(const OnboardingEvent.third(isEdit: true));
                },
              ),
              ProceedButton(
                text: 'Next Referee',
                isPressed: isPressed,
                onPressed: () {
                  setState(() {
                    isPressed = !isPressed;
                  });
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                  }
                  context.read<OnboardingBloc>()
                      .add(OnboardingEvent.fifth(refereeName: firstNameController.text, refereeOccupation: firstOccupationController.text, refereeEmail: firstEmailController.text, refereePhone: firstPhoneController.text, refereeRelation: firstRelationshipController.text));
                  context.read<ProfileBloc>().add(const ProfileEvent.loadProfile());
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}


class SecondRefereePage extends StatefulWidget {
  const SecondRefereePage({Key? key}) : super(key: key);

  @override
  _SecondRefereePageState createState() => _SecondRefereePageState();
}

class _SecondRefereePageState extends State<SecondRefereePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController secondNameController = TextEditingController();
  late TextEditingController secondOccupationController = TextEditingController();
  late TextEditingController secondEmailController = TextEditingController();
  late TextEditingController secondPhoneController = TextEditingController();
  late TextEditingController secondRelationshipController = TextEditingController();
  bool ethicsStatus = false;
  bool isPressed = false;
  bool submitted = false;

  String? emailErrorText;
  String? phoneErrorText;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (ctx, state) => state.map(
        loading: (_) => const Loading(useScaffold: false),
        loaded: (state) {
          RefereeCardModel previousReferee = RefereeCardModel(id: 0, userId: 0, fullName: "", occupation: "", email: "", phone: "", relationship: "", status: 0);
          if (state.referees.isNotEmpty) {
            previousReferee = state.referees.first;
          }
          return Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TextBox(
                  headerText: "Referees' details",
                  bodyText: 'Provide details for referees of choice.',
                ),
                const SizedBox(height: 10),
                Text('Referee 2', style: Theme.of(context).textTheme.headline2),
                const HeaderText(text: 'Full name'),
                OnboardingFormField(
                  textEditingController: secondNameController,
                  textInputType: TextInputType.name,
                ),
                const HeaderText(text: 'Occupation'),
                OnboardingFormField(
                  textEditingController: secondOccupationController,
                  textInputType: TextInputType.name,
                ),
                const HeaderText(text: 'Email address'),
                OnboardingFormField(
                  textEditingController: secondEmailController,
                  textInputType: TextInputType.emailAddress,
                  isSubmitted: submitted,
                  errorText: emailErrorText,
                  onChanged: (_) => setState(() {}),
                  validator: (value) {
                    if (value == previousReferee.email) {
                      isPressed = false;
                      return "Add a different email address for this referee.";
                    }
                    return null;
                  },
                ),
                const HeaderText(text: 'Phone number'),
                OnboardingFormField(
                  textEditingController: secondPhoneController,
                  textInputType: TextInputType.number,
                  isSubmitted: submitted,
                  errorText: phoneErrorText,
                  onChanged: (_) => setState(() {}),
                  maxLength: 11,
                  validator: (value) {
                    if (value!.substring(1) == previousReferee.phone) {
                      isPressed = false;
                      return "Add a different phone number for this referee.";
                    }
                    return null;
                  },
                ),
                const HeaderText(text: 'Relationship'),
                OnboardingFormField(
                  textEditingController: secondRelationshipController,
                  textInputType: TextInputType.name,
                ),
                const SizedBox(height: 10),
                CheckboxListTile(
                  title: Text(
                    "By signing in you agree to the association's code of conducts.",
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(fontWeight: FontWeight.w200),
                  ),
                  activeColor: Theme.of(context).primaryColor,
                  value: ethicsStatus,
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        ethicsStatus = value;
                      });
                    }
                  },
                  contentPadding: EdgeInsets.zero,
                  controlAffinity: ListTileControlAffinity.leading,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ProceedButton(
                      text: 'Back',
                      isBack: true,
                      onPressed: () {
                        context.read<OnboardingBloc>().add(const OnboardingEvent.fourth(isEdit: true));
                      },
                    ),
                    ProceedButton(
                      text: 'Finish',
                      isPressed: isPressed,
                      onPressed: () {
                        setState(() {
                          submitted = true;
                          isPressed = !isPressed;
                        });
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();

                          if (ethicsStatus == false) {
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (ctx) => CommonAlertDialog(
                                titleText: 'Ethics status',
                                contentText: 'You need to agree to the code of conducts before you can gain access to the app.',
                                actionText: 'Ok',
                                actionOnPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            );
                            isPressed = !isPressed;
                            return;
                          }

                          context.read<OnboardingBloc>()
                              .add(OnboardingEvent.finish(status: translateBoolStatus(ethicsStatus), refereeName: secondNameController.text, refereeOccupation: secondOccupationController.text, refereeEmail: secondEmailController.text, refereePhone: secondPhoneController.text, refereeRelation: secondRelationshipController.text));
                          Navigator.push(context, MaterialPageRoute(builder: (ctx) {
                            return BlocBuilder<MainBloc, MainState>(
                              builder: (ctx, state) => const AppWidget(),
                            );
                          }));
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  int translateBoolStatus(bool status) {
    switch (status) {
      case true:
        return 1;
      case false:
        return 0;
      default:
        throw Exception('Invalid status type = $status');
    }
  }
}
