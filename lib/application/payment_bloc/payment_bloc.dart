import 'package:csean_mobile/domain/extensions/int_extensions.dart';
import 'package:csean_mobile/domain/models/model.dart';
import 'package:csean_mobile/domain/services/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'payment_bloc.freezed.dart';
part 'payment_event.dart';
part 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  final CseanService _cseanService;

  PaymentBloc(this._cseanService) : super(const PaymentState.loading());

  _LoadedState get currentState => state as _LoadedState;

  @override
  Stream<PaymentState> mapEventToState(PaymentEvent event) async* {
    final s = await event.when(
      loadDetails: () async {
        final isSubscribed = _cseanService.getProfileData().subscription.parseToBool();
        PaymentFileModel transactionDetails;

        if (isSubscribed) {
          transactionDetails = PaymentFileModel(amount: 0, url: "", accessCode: "", reference: "");
        } else {
          transactionDetails = await _cseanService.getTransactionDetails();
        }

        return _buildInitialState(transactionDetails);
      },
      loadEventDetails: (id) async {
        final transactionDetails = await _cseanService.getEventTransactionDetails(id);

        return currentState.copyWith.call(
          amount: transactionDetails.amount,
          accessCode: transactionDetails.accessCode,
          reference: transactionDetails.reference,
        );
      },
    );

    yield s;
  }

  PaymentState _buildInitialState(PaymentFileModel model) {
    final user = _cseanService.getProfileData();

    return PaymentState.loaded(
      amount: model.amount,
      emailAddress: user.email,
      accessCode: model.accessCode,
      reference: model.reference,
    );
  }
}