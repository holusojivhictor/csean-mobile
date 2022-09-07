import 'package:csean_mobile/application/bloc.dart';
import 'package:csean_mobile/domain/app_constants.dart';
import 'package:csean_mobile/domain/assets.dart';
import 'package:csean_mobile/domain/enums/enum.dart';
import 'package:csean_mobile/domain/extensions/string_extensions.dart';
import 'package:csean_mobile/presentation/shared/choice/common_choice_bar.dart';
import 'package:csean_mobile/presentation/shared/choice_buttons.dart';
import 'package:csean_mobile/presentation/shared/item_popup_menu_filter.dart';
import 'package:csean_mobile/presentation/shared/row_text.dart';
import 'package:csean_mobile/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../shared/custom_form_field.dart';

class EditForm extends StatefulWidget {
  final String firstName;
  final String lastName;
  final String companyName;
  final String occupation;
  final String jobTitle;
  final String dateOfBirth;
  final String phoneNumber;
  final String workAddress;
  final String workCity;
  final String workCountry;
  final GenderType gender;
  final MembershipType membershipType;
  final bool update;

  const EditForm({
    Key? key,
    required this.firstName,
    required this.lastName,
    required this.companyName,
    required this.occupation,
    required this.jobTitle,
    required this.dateOfBirth,
    required this.phoneNumber,
    required this.workAddress,
    required this.workCity,
    required this.workCountry,
    required this.gender,
    required this.membershipType,
    required this.update,
  }) : super(key: key);

  @override
  _EditFormState createState() => _EditFormState();
}

class _EditFormState extends State<EditForm> {
  late TextEditingController firstNameController = TextEditingController();
  late TextEditingController lastNameController = TextEditingController();
  late TextEditingController jobTitleController = TextEditingController();
  late TextEditingController occupationController = TextEditingController();
  late TextEditingController companyNameController = TextEditingController();
  late TextEditingController phoneNumberController = TextEditingController();
  late TextEditingController workAddressController = TextEditingController();
  late TextEditingController workCityController = TextEditingController();
  late TextEditingController workCountryController = TextEditingController();
  late String dateOfBirth;
  late String membershipType;
  late GenderType genderType;

  @override
  void initState() {
    super.initState();
    firstNameController.text = widget.firstName;
    lastNameController.text = widget.lastName;
    occupationController.text = widget.occupation;
    jobTitleController.text = widget.jobTitle;
    dateOfBirth = widget.dateOfBirth;
    companyNameController.text = widget.companyName;
    phoneNumberController.text = widget.phoneNumber;
    workAddressController.text = widget.workAddress;
    workCityController.text = widget.workCity;
    workCountryController.text = widget.workCountry;
    membershipType = Assets.translateMembershipType(widget.membershipType);
    genderType = widget.gender;
  }

  /// Use didUpdateWidget to update the [widget.update] state.
  /// Control the state of the event button with the bloc call.
  /// Call buildInitialState to roll back bloc state to isNotUpdating.

  @override
  void didUpdateWidget(EditForm oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.update != oldWidget.update) {
      _submitUpdate(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CustomEditFormField(
          hintText: 'First name',
          textEditingController: firstNameController,
          textInputType: TextInputType.name,
        ),
        CustomEditFormField(
          hintText: 'Last name',
          textEditingController: lastNameController,
          textInputType: TextInputType.name,
        ),
        const RowText(
          text: 'Membership type',
          hasContainer: true,
          color: Colors.black54,
        ),
        Padding(
          padding: Styles.edgeInsetHorizontal16,
          child: ChoiceButtons(
            selectedValue: membershipType,
            onClick: (value) {
              setState(() {
                membershipType = value;
              });
            },
          ),
        ),
        CustomEditFormField(
          hintText: 'Job title',
          textEditingController: jobTitleController,
          textInputType: TextInputType.name,
        ),
        Visibility(
          visible: dateOfBirth.isNullEmptyOrWhitespace || dateOfBirth == '1860-01-01',
          child: CustomEditFormField(
            hintText: 'Date of birth',
            key: Key(dateOfBirth),
            initialValue: dateOfBirth.formatDateString(isProfile: true),
            textInputType: TextInputType.text,
            readOnly: true,
            suffix: InkWell(
              onTap: () => _showDatePicker(context),
              child: const Icon(Icons.calendar_today_outlined,
                  color: Colors.black54, size: 20),
            ),
          ),
        ),
        CustomEditFormField(
          hintText: 'Phone number',
          textEditingController: phoneNumberController,
          textInputType: TextInputType.phone,
        ),
        Visibility(
          visible: genderType == GenderType.notSet,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const RowText(
                text: 'Gender',
                hasContainer: true,
                color: Colors.black54,
              ),
              CommonChoiceBar<GenderType>(
                selectedValue: genderType,
                values: GenderType.values,
                onSelected: (value) {
                  setState(() {
                    genderType = value;
                  });
                },
                choiceText: (val, _) => Assets.translateGenderType(val),
              ),
            ],
          ),
        ),
        CustomEditFormField(
          hintText: 'Company name',
          textEditingController: companyNameController,
          textInputType: TextInputType.name,
        ),
        CustomEditFormField(
          hintText: 'Work address',
          textEditingController: workAddressController,
          textInputType: TextInputType.text,
        ),
        CustomEditFormField(
          hintText: 'City',
          textEditingController: workCityController,
          textInputType: TextInputType.name,
        ),
        CustomEditFormField(
          hintText: 'Country',
          hasSpace: false,
          textEditingController: workCountryController,
          textInputType: TextInputType.name,
          readOnly: true,
          suffix: ItemPopupMenuFilter<String>(
            toolTipText: 'Select country',
            selectedValue: workCountryController.text,
            values: countries.map((e) => e["name"]!).toList(),
            onSelected: (value) {
              setState(() {
                workCountryController.text = value;
              });
            },
            icon: const Icon(Icons.arrow_drop_down, color: Colors.black54),
            itemText: (val, _) => val,
          ),
        ),
        CustomEditFormField(
          hintText: 'Profession',
          hasSpace: false,
          textEditingController: occupationController,
          textInputType: TextInputType.name,
          readOnly: true,
          suffix: ItemPopupMenuFilter<String>(
            toolTipText: 'Select profession',
            selectedValue: occupationController.text,
            values: occupations,
            onSelected: (value) {
              setState(() {
                occupationController.text = value;
              });
            },
            icon: const Icon(Icons.arrow_drop_down, color: Colors.black54),
            itemText: (val, _) => val,
          ),
        ),
      ],
    );
  }

  Future<void> _showDatePicker(BuildContext context) async {
    final now = DateTime.now();
    final date = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now.subtract(const Duration(days: 15000)),
      lastDate: now,
    );

    setState(() {
      dateOfBirth = DateFormat('yyyy-MM-dd').format(date ?? now);
    });
  }

  Future<void> _submitUpdate(BuildContext context) async {
    context.read<DataBloc>().add(DataEvent.updateProfile(
      firstName: firstNameController.text,
      lastName: lastNameController.text,
      phone: phoneNumberController.text,
      membershipType: membershipType,
      currentOccupation: occupationController.text,
      jobTitle: jobTitleController.text,
      companyName: companyNameController.text,
      address: workAddressController.text,
      city: workCityController.text,
      country: workCountryController.text,
      gender: Assets.translateGenderType(genderType),
      dateOfBirth: dateOfBirth,
    ));
  }
}
