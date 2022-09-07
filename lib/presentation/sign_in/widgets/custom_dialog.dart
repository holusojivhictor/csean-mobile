import 'package:csean_mobile/application/bloc.dart';
import 'package:csean_mobile/application/result_state/result_state.dart';
import 'package:csean_mobile/domain/models/network/network_exceptions.dart';
import 'package:csean_mobile/presentation/shared/custom_alert_dialog.dart';
import 'package:csean_mobile/presentation/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomDialog extends StatelessWidget {
  const CustomDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignInBloc, ResultState>(
      builder: (ctx, state) => state.when(
        idle: () => const Loading(),
        loading: () => const Loading(),
        data: (_) => const Loading(),
        error: (e) => Text(NetworkExceptions.getErrorMessage(e)),
      ),
    );
  }

  Future buildShowDialog(BuildContext context, String message) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => CustomAlertDialog(text: message),
    );
  }
}
