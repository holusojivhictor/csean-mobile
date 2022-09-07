import 'dart:io';
import 'dart:async';

import 'package:csean_mobile/presentation/onboarding/widgets/text_box.dart';
import 'package:csean_mobile/presentation/shared/utils/toast_utils.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as path;

import '../../../application/onboarding/onboarding_bloc.dart';
import '../widgets/custom_form_field.dart';
import '../widgets/dotted_container.dart';
import '../widgets/header_text.dart';
import '../widgets/proceed_button.dart';

class Certifications extends StatefulWidget {
  const Certifications({Key? key}) : super(key: key);

  @override
  State<Certifications> createState() => _CertificationsState();
}

class _CertificationsState extends State<Certifications> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController licenseNameController = TextEditingController();
  late TextEditingController dateController = TextEditingController();
  late File licenseFile = File('');
  bool licensePicked = false;
  late String licenseName = '';
  late File resumeFile = File('');
  bool resumePicked = false;
  late String resumeName = '';
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TextBox(
          headerText: 'Certifications',
          bodyText: 'Add relevant licenses and certifications.',
        ),
        const HeaderText(text: 'License name'),
        Form(
          key: _formKey,
          child: OnboardingFormField(
            textEditingController: licenseNameController,
            textInputType: TextInputType.name,
          ),
        ),
        const HeaderText(text: 'Date Issued'),
        Row(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.72,
              child: OnboardingFormField(
                hintText: 'DD/MM/YYYY',
                textEditingController: dateController,
                textInputType: TextInputType.text,
              ),
            ),
            const SizedBox(width: 10),
            InkWell(
              onTap: () => _showDatePicker(context),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 16),
                  child: Icon(Icons.calendar_today_outlined, size: 20, color: Theme.of(context).primaryColor),
                ),
              ),
            ),
          ],
        ),
        const HeaderText(text: 'Attach license'),
        DottedContainer(
          onTap: () => _pickFile(context),
          uploaded: licensePicked,
          fileName: licenseName,
        ),
        const HeaderText(text: 'Upload resume'),
        DottedContainer(
          onTap: () => _pickResumeFile(context),
          uploaded: resumePicked,
          fileName: resumeName,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ProceedButton(
              text: 'Back',
              isBack: true,
              onPressed: () {
                context.read<OnboardingBloc>().add(const OnboardingEvent.second(isEdit: true));
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
                    .add(OnboardingEvent.fourth(licenseName: licenseNameController.text, dateIssued: dateController.text, licenseDocument: licenseFile, resumeDocument: resumeFile));
              },
            ),
          ],
        ),
      ],
    );
  }

  Future<void> _showDatePicker(BuildContext context) async {
    final now = DateTime.now();
    final date = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now.subtract(const Duration(days: 7300)),
      lastDate: now,
    );

    dateController.text = DateFormat('yyyy-MM-dd').format(date ?? now);
  }

  Future<void> _pickFile(BuildContext context) async {
    final pickedFile = await FilePicker.platform.pickFiles();
    final fToast = ToastUtils.of(context);

    if (pickedFile != null) {
      final nameSingle = pickedFile.names.single;
      final extension = path.extension(nameSingle!);
      final acceptedExtensions = [".doc", ".docx", ".pdf", ".jpg"];

      if (!acceptedExtensions.contains(extension)) {
        ToastUtils.showInfoToast(fToast, 'Unsupported file type!');

        return;
      }
      setState(() {
        licensePicked = true;
        licenseFile = File(pickedFile.files.single.path!);
        licenseName = pickedFile.names.single!;
      });
    } else {
      ToastUtils.showErrorToast(fToast, 'No file uploaded!');
    }
  }

  Future<void> _pickResumeFile(BuildContext context) async {
    final pickedFile = await FilePicker.platform.pickFiles();
    final fToast = ToastUtils.of(context);

    if (pickedFile != null) {
      final nameSingle = pickedFile.names.single;
      final extension = path.extension(nameSingle!);
      final acceptedExtensions = [".doc", ".docx", ".pdf"];

      if (!acceptedExtensions.contains(extension)) {
        ToastUtils.showInfoToast(fToast, 'Unsupported file type!');

        return;
      }
      setState(() {
        resumePicked = true;
        resumeFile = File(pickedFile.files.single.path!);
        resumeName = pickedFile.names.single!;
      });
    } else {
      ToastUtils.showErrorToast(fToast, 'No file uploaded!');
    }
  }
}
