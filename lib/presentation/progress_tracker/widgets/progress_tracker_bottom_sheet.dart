import 'package:csean_mobile/application/bloc.dart';
import 'package:csean_mobile/domain/assets.dart';
import 'package:csean_mobile/presentation/progress_request/progress_request_page.dart';
import 'package:csean_mobile/presentation/progress_tracker/widgets/activities_page.dart';
import 'package:csean_mobile/presentation/shared/animation/animated_page_route.dart';
import 'package:csean_mobile/presentation/shared/bottom_sheets/common_bottom_sheet.dart';
import 'package:csean_mobile/presentation/shared/default_button.dart';
import 'package:csean_mobile/presentation/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProgressTrackerBottomSheet extends StatelessWidget {
  const ProgressTrackerBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return CommonBottomSheet(
      title: 'User Information',
      endText: 'See all PDUs',
      titleIcon: Icons.edit,
      hasIcon: false,
      hasEndText: true,
      showCancelButton: false,
      showOkButton: false,
      textStyle: Theme.of(context).textTheme.headline4,
      onTap: () => Navigator.push(context, AnimatedPageRoute(page: const ActivitiesPage())),
      child: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (ctx, state) => state.map(
          loading: (_) => const Loading(useScaffold: false),
          loaded: (state) => Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 5),
              Text(
                state.fullName,
                style: theme.textTheme.headline6,
              ),
              const SizedBox(height: 5),
              Text(
                '${Assets.translateMembershipType(state.profile.membershipType!)} | ${state.profile.currentOccupation}',
                style: theme.textTheme.headline4,
              ),
              const SizedBox(height: 5),
              BlocBuilder<ProgressTrackerBloc, ProgressTrackerState>(
                builder: (ct, trackerState) => trackerState.map(
                  loading: (_) => const Loading(useScaffold: false),
                  loaded: (trackerState) {
                    final value = trackerState.report.totalPoints / trackerState.tracker.targetPoint;
                    return Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              'Status: ',
                              style: Theme.of(context).textTheme.headline4,
                            ),
                            Text(
                              Assets.translateProgressStatus(value),
                              style: Theme.of(context).textTheme.headline4!.copyWith(color: Assets.translateProgressStatusColor(value)),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            Text(
                              'Cycle: ',
                              style: Theme.of(context).textTheme.headline4,
                            ),
                            Text(
                              'August 28, 2021 - July 27, 2023',
                              style: Theme.of(context).textTheme.headline4,
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ),
              const SizedBox(height: 5),
              DefaultButton(
                text: 'Report new unit',
                hasBorder: true,
                onPressed: () => _goToReportPage(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _goToReportPage(BuildContext context) async {
    final route = MaterialPageRoute(builder: (ct) => const ProgressRequestPage(isInSelectionMode: true));
    await Navigator.push(context, route);
  }
}
