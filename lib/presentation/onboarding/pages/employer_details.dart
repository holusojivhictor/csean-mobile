import 'package:csean_mobile/application/bloc.dart';
import 'package:csean_mobile/domain/app_constants.dart';
import 'package:csean_mobile/presentation/onboarding/widgets/text_box.dart';
import 'package:csean_mobile/presentation/shared/custom_full_dropdown_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/custom_form_field.dart';
import '../widgets/header_text.dart';
import '../widgets/proceed_button.dart';


class EmployerDetails extends StatefulWidget {
  const EmployerDetails({Key? key}) : super(key: key);

  @override
  State<EmployerDetails> createState() => _EmployerDetailsState();
}

class _EmployerDetailsState extends State<EmployerDetails> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController companyNameController = TextEditingController();
  late TextEditingController addressController = TextEditingController();
  late TextEditingController townController = TextEditingController();
  late String selectedCountryValue = 'Nigeria';
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TextBox(
            headerText: "Employer's details",
            bodyText: 'Where are you currently employed.',
          ),
          const HeaderText(text: 'Name of company'),
          OnboardingFormField(
            textEditingController: companyNameController,
            textInputType: TextInputType.name,
          ),
          const HeaderText(text: 'Address'),
          OnboardingFormField(
            textEditingController: addressController,
            textInputType: TextInputType.streetAddress,
          ),
          const HeaderText(text: 'Town/City'),
          OnboardingFormField(
            textEditingController: townController,
            textInputType: TextInputType.name,
          ),
          const HeaderText(text: 'Country'),
          CustomFullDropdownButton<String>(
            margin: EdgeInsets.zero,
            title: 'Select country...',
            currentValue: selectedCountryValue,
            items: countries.map((e) => e["name"]!).toList(),
            onChanged: (value) {
              setState(() {
                selectedCountryValue = value;
              });
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ProceedButton(
                text: 'Back',
                isBack: true,
                onPressed: () {
                  context.read<OnboardingBloc>().add(const OnboardingEvent.init());
                },
              ),
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
                  context.read<OnboardingBloc>()
                      .add(OnboardingEvent.third(companyName: companyNameController.text, address: addressController.text, city: townController.text, country: selectedCountryValue));
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
