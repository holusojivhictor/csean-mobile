import 'dart:async';

import 'package:csean_mobile/application/bloc.dart';
import 'package:csean_mobile/domain/services/secrets/secrets.dart';
import 'package:csean_mobile/presentation/auth/auth_screen.dart';
import 'package:csean_mobile/presentation/events/events_page.dart';
import 'package:csean_mobile/presentation/profile_edit/widgets/picker_item.dart';
import 'package:csean_mobile/presentation/shared/custom_alert_dialog.dart';
import 'package:csean_mobile/presentation/shared/utils/toast_utils.dart';
import 'package:csean_mobile/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_paystack/flutter_paystack.dart';

import 'custom_icon_button.dart';

class ActionBox extends StatefulWidget {
  final double amount;
  final String accessCode;
  final String emailAddress;
  final String reference;
  final bool isSubscribed;

  const ActionBox({
    Key? key,
    required this.amount,
    required this.accessCode,
    required this.emailAddress,
    required this.reference,
    required this.isSubscribed,
  }) : super(key: key);

  @override
  State<ActionBox> createState() => _ActionBoxState();
}

class _ActionBoxState extends State<ActionBox> {
  final paystackPlugin = PaystackPlugin();

  @override
  void initState() {
    super.initState();
    paystackPlugin.initialize(publicKey: Secrets.paystackPublicKey);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: Styles.mainCardBorderRadius,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 3,
            offset: const Offset(1, 2),
          ),
        ],
      ),
      child: Padding(
        padding: Styles.edgeInsetAll10,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomIconButton(
              onPressed: () => _pickAction(context),
              icon: Icons.credit_card,
              subTitle: 'Make payment',
            ),
            CustomIconButton(
              onPressed: () => _verify(),
              icon: Icons.phone_iphone,
              subTitle: 'Verify',
            ),
            CustomIconButton(
              onPressed: () => _handleEventSubscription(context),
              icon: Icons.event_outlined,
              subTitle: 'Events',
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickAction(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (ctx) => PickerAlertDialog(
        itemCount: widget.isSubscribed ? 1 : 2,
        child: Column(
          children: [
            if (!widget.isSubscribed)
              PickerItem(
                textString: 'Pay Membership Fee',
                onTap: () {
                  Navigator.pop(context);
                  _handleCheckOut(context);
                },
              ),
            PickerItem(
              textString: 'Subscribe To Event',
              onTap: () {
                Navigator.pop(context);
                _handleEventSubscription(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _verify() {
    final fToast = ToastUtils.of(context);
    ToastUtils.showInfoToast(fToast, 'Pending review');
  }

  Future<void> _handleCheckOut(BuildContext context) async {
    final fToast = ToastUtils.of(context);
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
        context.read<DataBloc>().add(DataEvent.verifyPayment(reference: widget.reference));
        ToastUtils.showSucceedToast(fToast, 'Transaction successful.');
        return;
      }

      if (response.verify) {
        context.read<DataBloc>().add(DataEvent.verifyPayment(reference: widget.reference));
        ToastUtils.showSucceedToast(fToast, 'Transaction successful.');
      } else {
        ToastUtils.showInfoToast(fToast, 'Transaction discarded.');
      }
    } catch(e) {
      rethrow;
    }
  }

  Future<void> _handleEventSubscription(BuildContext context) async {
    final bloc = context.read<CommunityEventsBloc>();
    bloc.add(CommunityEventsEvent.init(excludeKeys: bloc.getItemKeysToExclude()));
    final route = MaterialPageRoute<int>(builder: (_) => const EventsPage(isInSelectionMode: true));
    final id = await Navigator.push(context, route);

    if (id == null) {
      return;
    }

    context.read<PaymentBloc>().add(PaymentEvent.loadEventDetails(id: id));
    bloc.add(const CommunityEventsEvent.init());

    showDialog(
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
          Navigator.of(context).pop();
          showDialog(
            context: context,
            barrierDismissible: true,
            builder: (ctx) => const CustomAlertDialog(text: 'Processing...'),
          );
          Timer(const Duration(seconds: 2), () {
            Navigator.of(context).pop();
            _handleEventCheckout(context, id);
          });
        },
      ),
    );
  }

  Future<void> _handleEventCheckout(BuildContext context, int id) async {
    final fToast = ToastUtils.of(context);
    ToastUtils.showInfoToast(fToast, 'Initiated payment for Event $id');
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
        context.read<DataBloc>().add(DataEvent.registerForEvent(id: id));
        ToastUtils.showSucceedToast(fToast, 'Transaction successful.');
        return;
      }

      if (response.verify) {
        context.read<DataBloc>().add(DataEvent.verifyEventPayment(reference: widget.reference));
        context.read<DataBloc>().add(DataEvent.registerForEvent(id: id));
        ToastUtils.showSucceedToast(fToast, 'Transaction successful.');
      } else {
        context.read<PaymentBloc>().add(const PaymentEvent.loadDetails());
        ToastUtils.showInfoToast(fToast, 'Transaction discarded.');
      }
    } catch(e) {
      context.read<PaymentBloc>().add(const PaymentEvent.loadDetails());
      rethrow;
    }
  }
}
