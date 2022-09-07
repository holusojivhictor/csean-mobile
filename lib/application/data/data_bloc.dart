import 'dart:io';

import 'package:csean_mobile/application/bloc.dart';
import 'package:csean_mobile/domain/services/csean_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'data_bloc.freezed.dart';
part 'data_event.dart';
part 'data_state.dart';

class DataBloc extends Bloc<DataEvent, DataState> {
  final CseanService _cseanService;
  final CommunityEventBloc _eventBloc;
  final CommunityEventsBloc _eventsBloc;
  final MessagesBloc _messagesBloc;
  final ProfileBloc _profileBloc;
  final HomeBloc _homeBloc;
  final TransactionsBloc _transactionsBloc;
  final PaymentBloc _paymentBloc;
  final ProgressTrackerBloc _progressTrackerBloc;
  final SupportBloc _supportBloc;

  DataBloc(this._cseanService, this._eventBloc, this._eventsBloc, this._messagesBloc, this._profileBloc, this._homeBloc, this._transactionsBloc, this._paymentBloc, this._progressTrackerBloc, this._supportBloc) : super(const DataState.loading());

  _LoadedState get currentState => state as _LoadedState;

  @override
  Stream<DataState> mapEventToState(DataEvent event) async* {
    if (event is _RegisterForEvent || event is! _UpdateProfile || event is! _UpdateProfilePicture) {
      yield const DataState.loading();
    }

    final s = await event.map(
      initData: (_) async {
        return const DataState.loaded();
      },
      registerForEvent: (e) async {
        await _cseanService.registerForEvent(e.id);
        _eventBloc.add(CommunityEventEvent.isSubscribedTo(id: e.id, wasAdded: true));
        await _cseanService.getRegisteredEvents();
        await _cseanService.getEventsData();
        _eventsBloc.add(const CommunityEventsEvent.init());
        await _cseanService.initProfile();
        _homeBloc.add(const HomeEvent.init());

        return const DataState.loaded();
      },
      updateProfilePicture: (e) async {
        await _cseanService.updateProfilePicture(e.image);

        return const DataState.loading();
      },
      updateProfile: (e) async {
        await _cseanService.saveEdit(e.firstName, e.lastName, e.phone, e.membershipType, e.currentOccupation, e.jobTitle, e.companyName, e.address, e.city, e.country, e.gender, e.dateOfBirth);
        await _cseanService.initProfile();
        _profileBloc.add(const ProfileEvent.loadProfile());
        _homeBloc.add(const HomeEvent.init());

        return const DataState.loaded(isDoneUpdating: true);
      },
      getTopicsAndMessages: (_) async {
        return const DataState.loaded();
      },
      sendMessage: (e) async {
        await _cseanService.sendMessage(e.topicId, e.message);
        await _cseanService.removeMessages(e.topicId);
        await _cseanService.getDiscussionsFromTopic(e.topicId);
        _messagesBloc.add(MessagesEvent.messageAdded(id: e.topicId, wasAdded: true));

        return const DataState.loaded();
      },
      sendProgressReport: (e) async {
        await _cseanService.sendProgressReport(e.activityId, e.description, e.dateCompleted, e.certificate);
        await _cseanService.getProgressTrackerData();
        _progressTrackerBloc.add(const ProgressTrackerEvent.init());

        return const DataState.loaded();
      },
      sendTicket: (e) async {
        await _cseanService.submitTicket(e.subject, e.message, e.attachment);
        await _cseanService.getSupportData();
        _supportBloc.add(const SupportEvent.init());

        return const DataState.loaded();
      },
      verifyPayment: (e) async {
        await _cseanService.verifyPayment(e.reference);
        await _cseanService.getTransactionHistory();
        await _cseanService.initProfile();
        _transactionsBloc.add(const TransactionsEvent.init());
        _paymentBloc.add(const PaymentEvent.loadDetails());
        _homeBloc.add(const HomeEvent.init());

        return const DataState.loaded();
      },
      verifyEventPayment: (e) async {
        await _cseanService.verifyEventPayment(e.reference);
        await _cseanService.getTransactionHistory();
        _transactionsBloc.add(const TransactionsEvent.init());
        _paymentBloc.add(const PaymentEvent.loadDetails());

        return const DataState.loaded();
      },
    );

    yield s;
  }
}
