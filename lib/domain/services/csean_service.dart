import 'dart:io';

import 'package:csean_mobile/domain/enums/enum.dart';
import 'package:csean_mobile/domain/models/model.dart';
import 'package:dio/dio.dart';

abstract class CseanService {
  Future<bool> isTokenActive();

  Future<void> getToken();
  Future<void> init();
  Future<void> initLocal();

  Future<void> initProfileWithToken(String token);

  /// Init Data
  Future<void> initProfile();
  Future<void> getEventsData();
  Future<void> getBlogsData();
  Future<void> getResourcesCategoriesData();
  Future<void> getRegisteredEvents();
  Future<void> getTransactionHistory();
  Future<void> getProgressTrackerData();
  Future<void> getSupportData();
  Future<void> getForumsData();
  Future<void> getChapterForumsData();
  Future<void> getTopicsFromForum(int forumId);
  Future<void> getDiscussionsFromTopic(int topicId);
  Future<void> getSubcategoryItemsFromIds(int categoryId, int subCategoryId);

  Future<void> registerForEvent(int id);

  /// Local Init Data
  Future<void> initProfileLocal();
  Future<void> getEventsDataLocal();
  Future<void> getBlogsDataLocal();
  Future<void> getRegisteredEventsLocal();

  /// Events methods
  List<EventCardModel> getEventsForCard();
  EventFileModel getEvent(int id);
  EventCardModel getEventForCard(int id);
  List<int> getSubscribedKeys();
  List<int> getFreeEventsKeys();
  List<int> getEventsExcludeKeys();

  /// Blogs methods
  List<BlogCardModel> getBlogsForCard();
  BlogFileModel getBlog(int id);
  BlogCardModel getBlogForCard(int id);

  /// Transactions methods
  List<TransactionCardModel> getTransactionsForCard();
  TransactionFileModel getTransaction(int id);
  TransactionCardModel getTransactionForCard(int id);

  /// Forums methods
  List<ForumCardModel> getAllForumsForCard();
  List<ForumCardModel> getForumsForCard();
  ForumFileModel getForum(int id);
  ForumCardModel getForumForCard(int id);
  ForumCardModel getForumFromPrivacy(String chapterName);

  /// Support ticket methods
  List<TicketCardModel> getTicketsForCard();
  SupportFileModel getTicket(int id);
  TicketCardModel getTicketForCard(int id);

  Future<Response> submitTicket(String subject, String message, File? attachment);

  /// Topics methods
  List<TopicCardModel> getTopicsForCardWithForumId(int forumId);
  TopicFileModel getTopic(int id);
  TopicCardModel getTopicForCard(int id);

  /// Resource Item methods
  List<ResourceItemCardModel> getResourceItemsForCardWithIds(int categoryId, int subCategoryId);
  SubCategoryItemModel getResourceItem(int id);
  ResourceItemCardModel getResourceItemForCard(int id);
  Future<void> getDownloaded();

  /// Messages methods
  List<MessageCardModel> getMessagesForCardWithTopicId(int topicId);
  MessageFileModel getMessage(int id);
  MessageCardModel getMessageForCard(int id);

  /// Learning resources methods
  List<SubCategoryCardModel> getSubCategoriesForCard();
  SubCategoryCardModel getSubCategoryForCard(int id);
  List<SubCategoryModel> getSubCategories();
  SubCategoryModel getSubCategory(int id);
  LearningCategoryModel getMainCategory(int id);

  /// User profile helper methods
  UserAccountModel getProfileData();
  SubscriptionModel getSubscriptionData();


  List<ForumFileModel> getAllForumsData();

  List<TopicFileModel> getAllTopicsData();

  List<MessageFileModel> getAllMessagesData();
  Future<void> removeMessages(int topicId);

  UserAccountCardModel getUserDataForCard();

  bool isEventSubscribedTo(int id);

  Future<Response> sendMessage(int topicId, String message);

  /// Progress tracker methods
  TrackerCardModel getTrackerForCard();
  ReportCardModel getReportForCard();
  ProgressActivityModel getActivity(int id);
  List<ActivityCardModel> getActivitiesForCard();
  ActivityCardModel getActivityForCard(int id);
  ProgressRequestModel getRequest(int id);
  List<RequestCardModel> getRequestsForCard();
  RequestCardModel getRequestForCard(int id);

  Future<Response> sendProgressReport(int activityId, String description, String dateCompleted, File certificate);

  List<int> reportedActivities();

  Future<void> signUpNewUser(
    String firstName,
    String lastName,
    String emailAddress,
    String password,
    String confirmPassword,
  );

  Future<Response> submitAboutYou(
    String membershipType,
    int memberChapter,
    String occupation,
    String jobTitle,
  );

  Future<Response> submitEmployerDetails(
    String companyName,
    String address,
    String city,
    String country,
  );

  Future<Response> submitCertification(
    String licenseName,
    String dateIssued,
    File licenseDocument,
  );

  Future<Response> submitResume(File resumeDocument);

  Future<Response> submitNewRefereeDetail(
    String refereeName,
    String refereeOccupation,
    String refereeEmail,
    String refereePhone,
    String refereeRelation,
  );

  Future<Response> saveEdit(
    String firstName,
    String lastName,
    String phone,
    String membershipType,
    String currentOccupation,
    String jobTitle,
    String companyName,
    String address,
    String city,
    String country,
    String gender,
    String dateOfBirth,
  );

  /// Profile helper methods
  Future<void> updateProfilePicture(File image);
  Future<Response> chapterChangeRequest(ChapterType chapter);

  Future<ChapterRequestState> getRequestState(ChapterType type);

  /// Payment Integration
  Future<PaymentFileModel> getTransactionDetails();
  Future<PaymentFileModel> getEventTransactionDetails(int id);
  Future<Response> verifyPayment(String reference);
  Future<Response> verifyEventPayment(String reference);

  Future<Response> submitEthicsStatus(int status);
}
