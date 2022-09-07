part of 'home_bloc.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState.loading() = _LoadingState;

  const factory HomeState.loaded({
    required double subscriptionAmount,
    required UserAccountCardModel userAccount,
    required List<EventCardModel> events,
    required List<BlogCardModel> blogs,
    required ContentType contentType,
    required MembershipType membershipType,
  }) = _LoadedState;
}