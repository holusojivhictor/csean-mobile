import 'dart:io';

import 'package:csean_mobile/application/bloc.dart';
import 'package:csean_mobile/presentation/onboarding/widgets/custom_form_field.dart';
import 'package:csean_mobile/presentation/onboarding/widgets/dotted_container.dart';
import 'package:csean_mobile/presentation/onboarding/widgets/header_text.dart';
import 'package:csean_mobile/presentation/onboarding/widgets/proceed_button.dart';
import 'package:csean_mobile/presentation/shared/utils/toast_utils.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart' as path;

class TicketForm extends StatefulWidget {
  const TicketForm({Key? key}) : super(key: key);

  @override
  State<TicketForm> createState() => _TicketFormState();
}

class _TicketFormState extends State<TicketForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController ticketNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  File? attachmentFile;
  bool attachmentPicked = false;
  late String attachmentName = '';
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const HeaderText(text: 'Ticket subject', isAlt: true),
          OnboardingFormField(
            textEditingController: ticketNameController,
            textInputType: TextInputType.name,
          ),
          const HeaderText(text: 'Description', isAlt: true),
          OnboardingFormField(
            hintText: 'Add a short description...',
            maxLines: 6,
            textEditingController: descriptionController,
            textInputType: TextInputType.text,
          ),
          const HeaderText(text: 'Attachment', isAlt: true),
          DottedContainer(
            height: 60,
            width: MediaQuery.of(context).size.width,
            onTap: () => _pickFile(context),
            uploaded: attachmentPicked,
            fileName: attachmentName,
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
                  if (descriptionController.text.isEmpty || ticketNameController.text.isEmpty) {
                    ToastUtils.showInfoToast(fToast, 'Press complete the form before submitting');
                    return;
                  }

                  context.read<DataBloc>().add(DataEvent.sendTicket(subject: ticketNameController.text, message: descriptionController.text, attachment: attachmentFile));
                  Navigator.pop(context);
                  ToastUtils.showSucceedToast(fToast, 'Ticket submitted successfully.');
                },
              ),
            ],
          ),
        ],
      ),
    );
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
        attachmentPicked = true;
        attachmentFile = File(pickedFile.files.single.path!);
        attachmentName = pickedFile.names.single!;
      });
    } else {
      ToastUtils.showErrorToast(fToast, 'No file uploaded!');
    }
  }
}
