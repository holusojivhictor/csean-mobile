import 'dart:async';

import 'package:csean_mobile/application/bloc.dart';
import 'package:csean_mobile/domain/enums/enum.dart';
import 'package:csean_mobile/domain/services/secrets/secrets.dart';
import 'package:csean_mobile/presentation/auth/auth_screen.dart';
import 'package:csean_mobile/presentation/event/widgets/event_detail_bottom.dart';
import 'package:csean_mobile/presentation/payments_manager/payments_manager_page.dart';
import 'package:csean_mobile/presentation/shared/custom_alert_dialog.dart';
import 'package:csean_mobile/presentation/shared/default_button.dart';
import 'package:csean_mobile/presentation/shared/loading.dart';
import 'package:csean_mobile/presentation/shared/sliver_scaffold_with_fab.dart';
import 'package:csean_mobile/presentation/shared/utils/toast_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_paystack/flutter_paystack.dart';

import 'widgets/event_detail_top.dart';

class EventPage extends StatelessWidget {
  const EventPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const _PortraitLayout();
  }
}

class _PortraitLayout extends StatelessWidget {
  const _PortraitLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommunityEventBloc, CommunityEventState>(
      builder: (ctx, state) => state.map(
        loading: (_) => const Loading(),
        loaded: (state) => SliverScaffoldWithFab(
          slivers: [
            SliverToBoxAdapter(
              child: Stack(
                fit: StackFit.passthrough,
                clipBehavior: Clip.none,
                alignment: Alignment.topCenter,
                children: [
                  const EventDetailTop(image: "assets/place-holder/casual-image.png"),
                  EventDetailBottom(
                    date: state.date,
                    time: state.time,
                    title: state.title,
                    venue: state.venue,
                    span: state.span,
                    videoUrl: state.video,
                    description: state.details,
                    totalSubscribers: state.totalSubscribers,
                    addSub: state.addSub,
                  ),
                ],
              ),
            ),
          ],
          bottomNavigationBar: BlocBuilder<PaymentBloc, PaymentState>(
            builder: (ctx, paymentState) => paymentState.map(
              loading: (_) => const ProgressButton(),
              loaded: (paymentState) => BottomButton(
                id: state.id,
                amount: paymentState.amount,
                emailAddress: paymentState.emailAddress,
                accessCode: paymentState.accessCode,
                reference: paymentState.reference,
                isPaid: state.paymentType == EventPaymentType.Pay,
                isSubscribedTo: state.isSubscribedTo,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class BottomButton extends StatefulWidget {
  final int id;
  final double amount;
  final String emailAddress;
  final String accessCode;
  final String reference;
  final bool isPaid;
  final bool isSubscribedTo;

  const BottomButton({
    Key? key,
    required this.id,
    required this.amount,
    required this.emailAddress,
    required this.accessCode,
    required this.reference,
    required this.isPaid,
    required this.isSubscribedTo,
  }) : super(key: key);

  @override
  State<BottomButton> createState() => _BottomButtonState();
}

class _BottomButtonState extends State<BottomButton> {
  final paystackPlugin = PaystackPlugin();

  @override
  void initState() {
    super.initState();
    paystackPlugin.initialize(publicKey: Secrets.paystackPublicKey);
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      child: BlocBuilder<DataBloc, DataState>(
        builder: (ctx, state) => state.map(
          loading: (_) => const ProgressButton(),
          loaded: (state) => DefaultButton(
            isPrimary: true,
            text: widget.isSubscribedTo ? 'Registered' : 'Register now',
            onPressed: widget.isSubscribedTo ? null
                : widget.isPaid ? () => _handleSubscription(context)
                : () => context.read<DataBloc>().add(DataEvent.registerForEvent(id: widget.id)),
            backgroundColor: widget.isSubscribedTo ? Colors.grey : Theme.of(context).primaryColor.withOpacity(0.7),
          ),
        ),
      ),
    );
  }

  Future<void> _handleSubscription(BuildContext context) async {
    context.read<PaymentBloc>().add(PaymentEvent.loadEventDetails(id: widget.id));
    final route = MaterialPageRoute(builder: (ctx) => const PaymentsManagerPage());
    Navigator.push(context, route);

    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => CommonAlertDialog(
        titleText: 'Subscribe to event',
        contentText: 'Proceed to pay subscription fee?',
        cancelText: 'Cancel',
        actionText: 'Okay',
        cancelOnPressed: () {
          Navigator.of(context).pop();
          context.read<PaymentBloc>().add(const PaymentEvent.loadDetails());
        },
        actionOnPressed: () {
          setState(() {});
          Navigator.of(context).pop();
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (ctx) => const CustomAlertDialog(text: 'Processing...'),
          );
          Timer(const Duration(seconds: 3), () {
            Navigator.of(context).pop();
            _handleEventCheckout(context);
          });
        },
      ),
    );
  }

  Future<void> _handleEventCheckout(BuildContext context) async {
    final fToast = ToastUtils.of(context);
    ToastUtils.showInfoToast(fToast, 'Initiated payment for Event ${widget.id}');
    Charge charge = Charge()
      ..amount = widget.amount.toInt()
      ..email = widget.emailAddress
      ..accessCode = widget.accessCode;

    try {
      CheckoutResponse response = await paystackPlugin.checkout(
        context,
        method: CheckoutMethod.card,
        charge: charge,
        logo: const CseanTitle(isSmall: true),
      );

      if (response.status) {
        context.read<DataBloc>().add(DataEvent.verifyEventPayment(reference: widget.reference));
        context.read<DataBloc>().add(DataEvent.registerForEvent(id: widget.id));
        ToastUtils.showSucceedToast(fToast, 'Transaction successful.');
        return;
      }

      if (response.verify) {
        context.read<DataBloc>().add(DataEvent.verifyEventPayment(reference: widget.reference));
        context.read<DataBloc>().add(DataEvent.registerForEvent(id: widget.id));
        ToastUtils.showSucceedToast(fToast, 'Transaction successful.');
      } else {
        context.read<PaymentBloc>().add(const PaymentEvent.loadDetails());
        ToastUtils.showInfoToast(fToast, 'Transaction discarded.');
      }
    } catch(e) {
      context.read<PaymentBloc>().add(const PaymentEvent.loadDetails());
      rethrow;
    }
    Navigator.pop(context);
  }
}


class _LandscapeLayout extends StatelessWidget {
  const _LandscapeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
