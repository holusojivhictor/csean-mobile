import 'package:bloc/bloc.dart';
import 'package:csean_mobile/domain/enums/enum.dart';
import 'package:csean_mobile/domain/models/model.dart';
import 'package:csean_mobile/domain/services/services.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_bloc.freezed.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final CseanService _cseanService;
  final SettingsService _settingsService;

  HomeBloc(this._cseanService, this._settingsService) : super(const HomeState.loading());

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    final s = event.when(
      init: () {
        return _buildInitialState(ContentType.event);
      },
      contentChanged: (contentType) => _buildInitialState(contentType),
    );

    yield s;
  }

  HomeState _buildInitialState(ContentType contentType) {
    final userAccount = _cseanService.getUserDataForCard();
    final events = _cseanService.getEventsForCard();
    final blogs = _cseanService.getBlogsForCard();
    final subscriptionData = _cseanService.getSubscriptionData();

    return HomeState.loaded(
      subscriptionAmount: subscriptionData.amount,
      userAccount: userAccount,
      events: events,
      blogs: blogs,
      contentType: contentType,
      membershipType: userAccount.membershipType,
    );
  }
}