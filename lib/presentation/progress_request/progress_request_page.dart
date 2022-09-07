import 'package:csean_mobile/application/bloc.dart';
import 'package:csean_mobile/presentation/progress_request/widgets/request_form.dart';
import 'package:csean_mobile/presentation/shared/loading.dart';
import 'package:csean_mobile/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProgressRequestPage extends StatelessWidget {
  final bool isInSelectionMode;

  const ProgressRequestPage({
    Key? key,
    this.isInSelectionMode = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isInSelectionMode) {
      return BlocBuilder<ProgressTrackerBloc, ProgressTrackerState>(
        builder: (ctx, state) => state.map(
          loading: (_) => const Loading(),
          loaded: (state) => Scaffold(
            appBar: AppBar(
              elevation: 0.0,
              iconTheme: const IconThemeData(color: Colors.black),
              title: const Text('Report a PDU', style: TextStyle(color: Colors.black)),
              backgroundColor: Colors.transparent,
            ),
            body: SafeArea(
              child: Container(
                margin: Styles.edgeInsetAll10,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      RequestForm(
                        currentActivity: state.currentActivity,
                        activities: state.activities,
                        isInSelectionMode: isInSelectionMode,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    }

    return BlocBuilder<ProgressRequestBloc, ProgressRequestState>(
      builder: (ctx, state) => state.map(
        loading: (_) => const Loading(),
        loaded: (state) => Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            iconTheme: const IconThemeData(color: Colors.black),
            title: const Text('Report a PDU', style: TextStyle(color: Colors.black)),
            backgroundColor: Colors.transparent,
          ),
          body: SafeArea(
            child: Container(
              margin: Styles.edgeInsetAll10,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    RequestForm(
                      isInSelectionMode: isInSelectionMode,
                      point: state.point,
                      title: state.title,
                      id: state.id,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
