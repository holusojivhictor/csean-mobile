import 'dart:io';

import 'package:csean_mobile/application/bloc.dart';
import 'package:csean_mobile/domain/models/model.dart';
import 'package:csean_mobile/presentation/onboarding/widgets/custom_form_field.dart';
import 'package:csean_mobile/presentation/onboarding/widgets/dotted_container.dart';
import 'package:csean_mobile/presentation/onboarding/widgets/header_text.dart';
import 'package:csean_mobile/presentation/onboarding/widgets/proceed_button.dart';
import 'package:csean_mobile/presentation/progress_request/widgets/activity_drop_down.dart';
import 'package:csean_mobile/presentation/shared/utils/toast_utils.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as path;

class RequestForm extends StatefulWidget {
  final ActivityCardModel? currentActivity;
  final List<ActivityCardModel> activities;
  final bool isInSelectionMode;
  final int? id;
  final int? point;
  final String? title;

  const RequestForm({
    Key? key,
    required this.isInSelectionMode,
    this.currentActivity,
    this.activities = const [],
    this.id,
    this.point,
    this.title,
  }) : super(key: key);

  @override
  State<RequestForm> createState() => _RequestFormState();
}

class _RequestFormState extends State<RequestForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  late File certificateFile = File('');
  bool certificatePicked = false;
  late String certificateName = '';
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const HeaderText(text: 'Activity', isAlt: true),
          if (widget.isInSelectionMode)
            ActivityDropDown(
              currentActivity: widget.currentActivity!,
              activities: widget.activities,
            ),
          if (!widget.isInSelectionMode)
            OnboardingFormField(
              hintText: 'PDU point',
              key: Key(widget.title!),
              initialValue: widget.title,
              textInputType: TextInputType.number,
              enabled: false,
              readOnly: true,
            ),
          const HeaderText(text: 'Description', isAlt: true),
          OnboardingFormField(
            maxLines: 6,
            textEditingController: descriptionController,
            textInputType: TextInputType.text,
          ),
          const HeaderText(text: 'PDU point', isAlt: true),
          OnboardingFormField(
            hintText: 'PDU point',
            key: Key(widget.currentActivity != null ? widget.currentActivity!.point.toString() : widget.point.toString()),
            initialValue: widget.currentActivity != null ? widget.currentActivity!.point.toString() : widget.point.toString(),
            textInputType: TextInputType.number,
            enabled: false,
            readOnly: true,
          ),
          const HeaderText(text: 'Upload proof', isAlt: true),
          DottedContainer(
            height: 60,
            width: MediaQuery.of(context).size.width,
            onTap: () => _pickFile(context),
            uploaded: certificatePicked,
            fileName: certificateName,
          ),
          const HeaderText(text: 'Date completed', isAlt: true),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.78,
                child: OnboardingFormField(
                  hintText: 'DD/MM/YYYY',
                  enabled: false,
                  readOnly: true,
                  textEditingController: dateController,
                  textInputType: TextInputType.text,
                ),
              ),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ProceedButton(
                text: 'Cancel',
                isBack: true,
                onPressed: () => Navigator.pop(context),
              ),
              const SizedBox(width: 15),
              ProceedButton(
                text: 'Send report',
                isBack: true,
                isPressed: isPressed,
                onPressed: () {
                  setState(() {
                    isPressed = !isPressed;
                  });
                  final fToast = ToastUtils.of(context);
                  if (descriptionController.text.isEmpty || dateController.text.isEmpty || certificateFile.path.isEmpty) {
                    ToastUtils.showInfoToast(fToast, 'Press complete the form before submitting');
                    return;
                  }

                  if (widget.isInSelectionMode) {
                    context.read<DataBloc>().add(DataEvent.sendProgressReport(activityId: widget.currentActivity!.id, description: descriptionController.text, dateCompleted: dateController.text, certificate: certificateFile));
                  } else {
                    context.read<DataBloc>().add(DataEvent.sendProgressReport(activityId: widget.id!, description: descriptionController.text, dateCompleted: dateController.text, certificate: certificateFile));
                  }
                  Navigator.pop(context);
                  ToastUtils.showSucceedToast(fToast, 'Report submitted successfully.');
                },
              ),
            ],
          ),
        ],
      ),
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

    dateController.text = DateFormat('yyyy-MM-dd').format(date ?? now.subtract(const Duration(days: 1)));
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
        certificatePicked = true;
        certificateFile = File(pickedFile.files.single.path!);
        certificateName = pickedFile.names.single!;
      });
    } else {
      ToastUtils.showErrorToast(fToast, 'No file uploaded!');
    }
  }
}
