import 'package:csean_mobile/application/bloc.dart';
import 'package:csean_mobile/domain/models/model.dart';
import 'package:csean_mobile/presentation/progress_request/progress_request_page.dart';
import 'package:csean_mobile/presentation/shared/custom_card.dart';
import 'package:csean_mobile/presentation/shared/utils/toast_utils.dart';
import 'package:csean_mobile/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ActivityCard extends StatelessWidget {
  final int id;
  final String title;
  final int point;
  final bool accepted;
  final bool isSubmitted;

  final bool withElevation;

  const ActivityCard({
    Key? key,
    required this.id,
    required this.title,
    required this.point,
    required this.accepted,
    required this.isSubmitted,
    this.withElevation = true,
  }) : super(key: key);

  ActivityCard.item({
    Key? key,
    required ActivityCardModel activity,
    this.withElevation = true,
  })  : id = activity.id,
        title = activity.title,
        point = activity.point,
        accepted = activity.accepted,
        isSubmitted = activity.isSubmitted,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: Styles.circularBorderRadius5,
      onTap: () => _goToReportPage(context),
      child: CustomCard(
        clipBehavior: Clip.hardEdge,
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        shape: Styles.activityCardShape,
        elevation: withElevation ? Styles.cardTenElevation : 0,
        color: Colors.grey.withOpacity(0.25),
        child: Padding(
          padding: Styles.edgeInsetAll10,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  const SizedBox(height: 5),
                  Text('$point points'),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: accepted ? Theme.of(context).colorScheme.secondary : Colors.transparent,
                  border: Border.all(color: Theme.of(context).colorScheme.secondary, width: 1.5),
                ),
                child: Opacity(opacity: accepted ? 1 : 0, child: const Icon(Icons.check, size: 12, color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _goToReportPage(BuildContext context) async {
    if (accepted) {
      final fToast = ToastUtils.of(context);
      ToastUtils.showSucceedToast(fToast, 'Unit cleared!');
      return;
    }

    if (isSubmitted) {
      final fToast = ToastUtils.of(context);
      ToastUtils.showInfoToast(fToast, 'Unit reported. Pending check.');
      return;
    }

    final bloc= context.read<ProgressRequestBloc>();
    bloc.add(ProgressRequestEvent.loadFromId(id: id));
    final route = MaterialPageRoute(builder: (ct) => const ProgressRequestPage());
    await Navigator.push(context, route);
    await route.completed;
    bloc.pop();
  }
}
