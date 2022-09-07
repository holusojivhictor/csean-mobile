part of 'community_event_bloc.dart';

@freezed
class CommunityEventState with _$CommunityEventState {
  const factory CommunityEventState.loading() = _LoadingState;

  const factory CommunityEventState.loaded({
    required int id,
    required int chapterId,
    required int categoryId,
    required String title,
    required String date,
    required String time,
    required String venue,
    required int span,
    required EventPaymentType paymentType,
    required EventType eventType,
    required String fileUrl,
    required String video,
    required String details,
    required bool isSubscribedTo,
    required bool subscribed,
    required bool addSub,
    required int totalSubscribers,
  }) = _LoadedState;
}