import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:csean_mobile/domain/app_constants.dart';
import 'package:csean_mobile/domain/assets.dart';
import 'package:csean_mobile/domain/enums/enum.dart';
import 'package:csean_mobile/domain/extensions/int_extensions.dart';
import 'package:csean_mobile/domain/extensions/string_extensions.dart';
import 'package:csean_mobile/domain/models/db/forums/forum_data_file.dart';
import 'package:csean_mobile/domain/models/db/topics/topic_file.dart';
import 'package:csean_mobile/domain/models/model.dart';
import 'package:csean_mobile/domain/services/services.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:shared_preferences/shared_preferences.dart';

class CseanServiceImpl implements CseanService {
  final AuthService _authService;
  final OnboardingService _onboardingService;
  final EventsService _eventsService;
  final ResourcesService _resourcesService;
  final ForumService _forumService;
  final ProfileService _profileService;
  final ProgressTrackerService _progressTrackerService;
  final PaymentService _paymentService;
  final SupportService _supportService;
  late String token;
  late UserAccountFile _userAccountFile;
  late UserAccountDataFile _userAccountDataFile;
  late EventFile _eventFile;
  late EventDataFile _eventDataFile;
  late BlogFile _blogFile;
  late BlogDataFile _blogDataFile;
  late TransactionFile _transactionFile;
  late TransactionDataFile _transactionDataFile;
  late TransactionFile _eventsTransactionFile;
  late TransactionDataFile _eventsTransactionDataFile;
  late SupportFile _supportFile;
  late SupportDataFile _supportDataFile;
  late CategoryFile _categoryFile;
  late ItemFile _itemFile;
  late ItemDataFile _itemDataFile;
  late RegisteredEventsFile _registeredEventsFile;
  late RegisteredEventsDataFile _registeredEventsDataFile;
  late ForumFile _forumFile;
  late ForumDataFile _forumDataFile;
  late ForumFile _chapterForumFile;
  late ForumDataFile _chapterForumDataFile;
  late TopicFile _topicFile;
  late ProgressFile _progressFile;
  late PaymentFile _paymentFile;
  final List<SubCategoryItemModel> _allResourceItems = <SubCategoryItemModel>[];
  final List<TopicFileModel> _allTopicsFile = <TopicFileModel>[];
  late MessageFile _messageFile;
  final List<MessageFileModel> _allMessagesFile = <MessageFileModel>[];
  late List<String> _downloadedResources = <String>[];

  CseanServiceImpl(
      this._authService,
      this._onboardingService,
      this._eventsService,
      this._resourcesService,
      this._forumService,
      this._profileService,
      this._progressTrackerService,
      this._paymentService,
      this._supportService);

  @override
  Future<void> init() async {
    await Future.wait([
      initProfile(),
      getEventsData(),
      getBlogsData(),
      getTransactionHistory(),
      getProgressTrackerData(),
      getResourcesCategoriesData(),
      getSupportData(),
      getForumsData(),
      getChapterForumsData(),
      getRegisteredEvents(),
    ]);
  }

  @override
  Future<void> initLocal() async {
    await Future.wait([
      initProfileLocal(),
      getEventsDataLocal(),
      getBlogsDataLocal(),
      getRegisteredEventsLocal(),
    ]);
  }

  @override
  Future<void> getToken() async {
    final savedToken = await getSavedString(key: tokenStorageKey);
    token = savedToken;
  }

  @override
  Future<void> initProfileWithToken(String token) async {
    final json = await _authService.getProfile(token) as Map<String, dynamic>;
    _userAccountFile = UserAccountFile.fromJson(json);
    _userAccountDataFile = UserAccountDataFile.fromJson(_userAccountFile.data);
  }

  @override
  Future<void> initProfile() async {
    final response = await _authService.getProfile(token);
    final json = response.data as Map<String, dynamic>;
    _userAccountFile = UserAccountFile.fromJson(json);
    _userAccountDataFile = UserAccountDataFile.fromJson(_userAccountFile.data);
  }

  @override
  Future<void> getEventsData() async {
    final response = await _eventsService.getEvents(token);
    final json = response.data as Map<String, dynamic>;
    _eventFile = EventFile.fromJson(json);
    _eventDataFile = EventDataFile.fromJson(_eventFile.events);
  }

  @override
  Future<void> getBlogsData() async {
    final response = await _resourcesService.getBlogs(token);
    final json = response.data as Map<String, dynamic>;
    _blogFile = BlogFile.fromJson(json);
    _blogDataFile = BlogDataFile.fromJson(_blogFile.blogs);
  }

  @override
  Future<void> getTransactionHistory() async {
    final response = await _paymentService.getTransactionHistory(token);
    final eventsResponse = await _paymentService.getEventsTransactionHistory(token);
    final json = response.data as Map<String, dynamic>;
    final eventsJson = eventsResponse.data as Map<String, dynamic>;
    _transactionFile = TransactionFile.fromJson(json);
    _transactionDataFile = TransactionDataFile.fromJson(_transactionFile.data);
    _eventsTransactionFile = TransactionFile.fromJson(eventsJson);
    _eventsTransactionDataFile = TransactionDataFile.fromJson(_eventsTransactionFile.data);
  }

  @override
  Future<void> getProgressTrackerData() async {
    final response = await _progressTrackerService.getProgressData(token);
    final json = response.data as Map<String, dynamic>;
    _progressFile = ProgressFile.fromJson(json);
  }

  @override
  Future<void> getSupportData() async {
    final response = await _supportService.getSupportTickets(token);
    final json = response.data as Map<String, dynamic>;
    _supportFile = SupportFile.fromJson(json);
    _supportDataFile = SupportDataFile.fromJson(_supportFile.supports);
  }

  @override
  Future<void> getResourcesCategoriesData() async {
    final response = await _resourcesService.getResourcesCategories(token);
    final json = response.data as Map<String, dynamic>;
    _categoryFile = CategoryFile.fromJson(json);
  }

  @override
  Future<void> getForumsData() async {
    final response = await _forumService.getForums(token);
    final json = response.data as Map<String, dynamic>;
    _forumFile = ForumFile.fromJson(json);
    _forumDataFile = ForumDataFile.fromJson(_forumFile.forums);
  }

  @override
  Future<void> getChapterForumsData() async {
    final response = await _forumService.getChapterForums(token);
    final json = response.data as Map<String, dynamic>;
    _chapterForumFile = ForumFile.fromJson(json);
    _chapterForumDataFile = ForumDataFile.fromJson(_chapterForumFile.forums);
  }

  @override
  Future<void> getDownloaded() async {
    final downloadedIds = await getSavedStringList(key: 'Resources-Downloaded');
    _downloadedResources = downloadedIds;
  }

  List<ForumFileModel> get _fullForumsFile => _forumDataFile.data + _chapterForumDataFile.data;

  @override
  List<ForumFileModel> getAllForumsData() {
    return _fullForumsFile;
  }

  @override
  List<TopicFileModel> getAllTopicsData() {
    return _allTopicsFile;
  }

  @override
  List<MessageFileModel> getAllMessagesData() {
    return _allMessagesFile;
  }

  @override
  Future<void> getRegisteredEvents() async {
    final response = await _eventsService.getRegisteredEvents(token);
    final json = response.data as Map<String, dynamic>;
    _registeredEventsFile = RegisteredEventsFile.fromJson(json);
    _registeredEventsDataFile = RegisteredEventsDataFile.fromJson(_registeredEventsFile.events);
  }

  @override
  Future<void> getTopicsFromForum(int forumId) async {
    final response = await _forumService.getTopicsFromId(forumId, token);
    final json = response.data as Map<String, dynamic>;
    _topicFile = TopicFile.fromJson(json);
    _allTopicsFile.addAll(_topicFile.topics);
  }

  @override
  Future<void> getDiscussionsFromTopic(int topicId) async {
    final response = await _forumService.getDiscussionsFromId(topicId, token);
    final json = response.data as Map<String, dynamic>;
    _messageFile = MessageFile.fromJson(json);
    _allMessagesFile.addAll(_messageFile.discussion);
  }

  @override
  Future<void> getSubcategoryItemsFromIds(int categoryId, int subCategoryId) async {
    final response = await _resourcesService.getSubcategoryItems(categoryId, subCategoryId, token);
    final json = response.data as Map<String, dynamic>;
    _itemFile = ItemFile.fromJson(json);
    _itemDataFile = ItemDataFile.fromJson(_itemFile.resources);
    _allResourceItems.addAll(_itemDataFile.data);
  }

  @override
  Future<PaymentFileModel> getTransactionDetails() async {
    final response = await _paymentService.fetchAccessCode(token);
    final json = response.data as Map<String, dynamic>;
    _paymentFile = PaymentFile.fromJson(json);

    return _paymentFile.data;
  }

  @override
  Future<PaymentFileModel> getEventTransactionDetails(int id) async {
    final response = await _paymentService.fetchAccessCodeForEvent(id, token);
    final json = response.data as Map<String, dynamic>;
    _paymentFile = PaymentFile.fromJson(json);

    return _paymentFile.data;
  }

  @override
  Future<void> registerForEvent(int id) async {
    await _eventsService.registerForEvent(id, token);
  }

  @override
  Future<void> initProfileLocal() async {
    final jsonStr = await rootBundle.loadString(Assets.profileDbPath);
    final json = jsonDecode(jsonStr) as Map<String, dynamic>;
    _userAccountFile = UserAccountFile.fromJson(json);
    _userAccountDataFile = UserAccountDataFile.fromJson(_userAccountFile.data);
  }

  @override
  Future<void> getEventsDataLocal() async {
    final jsonStr = await rootBundle.loadString(Assets.eventsDbPath);
    final json = jsonDecode(jsonStr) as Map<String, dynamic>;
    _eventFile = EventFile.fromJson(json);
    _eventDataFile = EventDataFile.fromJson(_eventFile.events);
  }

  @override
  Future<void> getBlogsDataLocal() async {
    final jsonStr = await rootBundle.loadString(Assets.blogsDbPath);
    final json = jsonDecode(jsonStr) as Map<String, dynamic>;
    _blogFile = BlogFile.fromJson(json);
    _blogDataFile = BlogDataFile.fromJson(_blogFile.blogs);
  }

  @override
  Future<void> getRegisteredEventsLocal() async {
    final jsonStr = await rootBundle.loadString(Assets.registeredEventsDbPath);
    final json = jsonDecode(jsonStr) as Map<String, dynamic>;
    _registeredEventsFile = RegisteredEventsFile.fromJson(json);
    _registeredEventsDataFile = RegisteredEventsDataFile.fromJson(_registeredEventsFile.events);
  }

  @override
  bool isEventSubscribedTo(int id) {
    return _registeredEventsDataFile.data.any((el) => el.eventId == id);
  }

  @override
  EventFileModel getEvent(int id) {
    return _eventDataFile.data.firstWhere((element) => element.id == id);
  }

  @override
  EventCardModel getEventForCard(int id) {
    final event = _eventDataFile.data.firstWhere((element) => element.id == id);
    return _toEventForCard(event);
  }

  @override
  List<EventCardModel> getEventsForCard() {
    return _eventDataFile.data.map((e) => _toEventForCard(e)).toList();
  }

  @override
  BlogFileModel getBlog(int id) {
    return _blogDataFile.data.firstWhere((element) => element.id == id);
  }

  @override
  BlogCardModel getBlogForCard(int id) {
    final blog = _blogDataFile.data.firstWhere((element) => element.id == id);
    return _toBlogForCard(blog);
  }

  @override
  List<BlogCardModel> getBlogsForCard() {
    return _blogDataFile.data.map((e) => _toBlogForCard(e)).toList();
  }

  List<TransactionFileModel> get _fullTransactionsFile => _transactionDataFile.data + _eventsTransactionDataFile.data;

  @override
  List<TransactionCardModel> getTransactionsForCard() {
    return _fullTransactionsFile.map((e) => _toTransactionForCard(e)).toList();
  }

  @override
  TransactionFileModel getTransaction(int id) {
    return _fullTransactionsFile.firstWhere((el) => el.id == id);
  }

  @override
  TransactionCardModel getTransactionForCard(int id) {
    final transaction = _fullTransactionsFile.firstWhere((el) => el.id == id);
    return _toTransactionForCard(transaction);
  }

  @override
  List<TicketCardModel> getTicketsForCard() {
    return _supportDataFile.data.map((e) => _toTicketForCard(e)).toList();
  }

  @override
  SupportFileModel getTicket(int id) {
    return _supportDataFile.data.firstWhere((el) => el.id == id);
  }

  @override
  TicketCardModel getTicketForCard(int id) {
    final ticket = _supportDataFile.data.firstWhere((el) => el.id == id);
    return _toTicketForCard(ticket);
  }

  @override
  List<ForumCardModel> getForumsForCard() {
    return _forumDataFile.data.map((e) => _toForumForCard(e)).toList();
  }

  @override
  List<ForumCardModel> getAllForumsForCard() {
    return _fullForumsFile.map((e) => _toForumForCard(e)).toList();
  }

  @override
  ForumFileModel getForum(int id) {
    return _fullForumsFile.firstWhere((el) => el.id == id);
  }

  @override
  ForumCardModel getForumForCard(int id) {
    final forum = _fullForumsFile.firstWhere((el) => el.id == id);
    return _toForumForCard(forum);
  }

  @override
  ForumCardModel getForumFromPrivacy(String chapterName) {
    final forum = _chapterForumDataFile.data.firstWhere((el) => el.name == chapterName);
    return _toForumForCard(forum);
  }

  @override
  TopicFileModel getTopic(int id) {
    return _allTopicsFile.firstWhere((el) => el.id == id);
  }

  @override
  TopicCardModel getTopicForCard(int id) {
    final topic = _allTopicsFile.firstWhere((el) => el.id == id);
    return _toTopicForCard(topic);
  }

  @override
  List<TopicCardModel> getTopicsForCardWithForumId(int forumId) {
    final topics = _allTopicsFile.where((el ) => el.forumId == forumId).toList();
    return topics.map((e) => _toTopicForCard(e)).toList();
  }

  @override
  MessageFileModel getMessage(int id) {
    return _allMessagesFile.firstWhere((el) => el.id == id);
  }

  @override
  MessageCardModel getMessageForCard(int id) {
    final message = _allMessagesFile.firstWhere((el) => el.id == id);
    return _toMessageForCard(message);
  }

  @override
  List<MessageCardModel> getMessagesForCardWithTopicId(int topicId) {
    final messages = _allMessagesFile.where((el) => el.topicId == topicId).toList();
    return messages.map((e) => _toMessageForCard(e)).toList();
  }

  @override
  SubCategoryItemModel getResourceItem(int id) {
    return _allResourceItems.firstWhere((el) => el.id == id);
  }

  @override
  ResourceItemCardModel getResourceItemForCard(int id) {
    final resourceItem = _allResourceItems.firstWhere((el) => el.id == id);
    return _toResourceItemForCard(resourceItem);
  }

  @override
  List<ResourceItemCardModel> getResourceItemsForCardWithIds(int categoryId, int subCategoryId) {
    final resourceItems = _allResourceItems.where((el) => el.categoryId == categoryId && el.subCategoryId == subCategoryId).toList();
    return resourceItems.map((e) => _toResourceItemForCard(e)).toList();
  }

  @override
  Future<void> removeMessages(int topicId) async {
    _allMessagesFile.removeWhere((el) => el.topicId == topicId);
  }

  @override
  List<SubCategoryCardModel> getSubCategoriesForCard() {
    return _categoryFile.categories.expand((el) => el.subCategories).map((e) => _toSubCategoryForCard(e)).toList();
  }

  @override
  SubCategoryModel getSubCategory(int id) {
    return _categoryFile.categories.expand((el) => el.subCategories).firstWhere((e) => e.id == id);
  }

  @override
  SubCategoryCardModel getSubCategoryForCard(int id) {
    final subCategory = _categoryFile.categories.expand((el) => el.subCategories).firstWhere((e) => e.id == id);
    return _toSubCategoryForCard(subCategory);
  }

  @override
  List<SubCategoryModel> getSubCategories() {
    return _categoryFile.categories.expand((el) => el.subCategories).toList();
  }

  @override
  LearningCategoryModel getMainCategory(int id) {
    return _categoryFile.categories.firstWhere((element) => element.id == id);
  }

  @override
  List<ActivityCardModel> getActivitiesForCard() {
    return _progressFile.activities.map((e) => _toActivityForCard(e)).toList();
  }

  @override
  ProgressActivityModel getActivity(int id) {
    return _progressFile.activities.firstWhere((el) => el.id == id);
  }

  @override
  ActivityCardModel getActivityForCard(int id) {
    final activity = _progressFile.activities.firstWhere((el) => el.id == id);
    return _toActivityForCard(activity);
  }

  @override
  ReportCardModel getReportForCard() {
    final report = _progressFile.report;
    return _toReportForCard(report);
  }

  @override
  ProgressRequestModel getRequest(int id) {
    return _progressFile.progressRequests.firstWhere((el) => el.id == id);
  }

  @override
  RequestCardModel getRequestForCard(int id) {
    final request = _progressFile.progressRequests.firstWhere((el) => el.id == id);
    return _toRequestForCard(request);
  }

  @override
  List<RequestCardModel> getRequestsForCard() {
    return _progressFile.progressRequests.map((e) => _toRequestForCard(e)).toList();
  }

  @override
  TrackerCardModel getTrackerForCard() {
    final tracker = _progressFile.tracker;
    return _toTrackerForCard(tracker);
  }

  @override
  List<int> reportedActivities() {
    return _progressFile.progressRequests.map((e) => e.activityId).toList();
  }
  
  TrackerCardModel _toTrackerForCard(ProgressTrackerModel model) {
    return TrackerCardModel(
      id: model.id,
      adminId: model.adminId,
      targetPoint: model.targetPoint,
      targetPeriod: model.targetPeriod,
      targetTimeline: model.targetTimeline,
    );
  }

  ReportCardModel _toReportForCard(ProgressReportModel model) {
    return ReportCardModel(
      totalPoints: model.totalPoints,
      remainingPoints: model.remainingPoints,
      pending: model.pending,
      approved: model.approved,
      declined: model.declined,
    );
  }

  RequestCardModel _toRequestForCard(ProgressRequestModel model) {
    final activity = getActivity(model.activityId);
    final report = _progressFile.report;
    return RequestCardModel(
      id: model.id,
      userId: model.userId,
      activityId: model.activityId,
      title: activity.title,
      point: activity.point,
      totalPoints: report.totalPoints + report.remainingPoints,
      completedAt: model.completedAt,
      requestState: model.requestState,
    );
  }

  ActivityCardModel _toActivityForCard(ProgressActivityModel model) {
    final isSubmitted = reportedActivities().contains(model.id);
    return ActivityCardModel(
      id: model.id,
      title: model.title,
      activityType: model.activityType,
      point: model.point,
      createdAt: model.createdAt,
      accepted: model.accepted,
      isSubmitted: isSubmitted,
    );
  }

  SubCategoryCardModel _toSubCategoryForCard(SubCategoryModel model) {
    final mainCategory = getMainCategory(model.categoryId);
    return SubCategoryCardModel(
      id: model.id,
      categoryId: model.categoryId,
      categoryType: mainCategory.type,
      name: model.name,
      description: model.description,
    );
  }

  ResourceItemCardModel _toResourceItemForCard(SubCategoryItemModel model) {
    int fileSize = 0;
    if (model.fileUrl.isNotNullEmptyOrWhitespace) {
      getFileSizeInBytes(model.fileUrl).then((value) => fileSize = value);
    }

    final isDownloaded = _downloadedResources.contains('${model.id}');

    return ResourceItemCardModel(
      id: model.id,
      categoryId: model.categoryId,
      subCategoryId: model.subCategoryId,
      title: model.title,
      type: model.type,
      description: model.description,
      fileSize: fileSize,
      createdAt: model.createdAt,
      fileUrl: model.fileUrl,
      isDownloaded: isDownloaded,
    );
  }

  Future<int> getFileSizeInBytes(String url) async {
    final Dio dio = Dio();

    if (url.isNullEmptyOrWhitespace) {
      return 0;
    }

    Response response = await dio.head(url);
    var size = response.headers["content-length"];
    final sizeInt = int.parse(size![0]);
    final key = url.split('/').last;
    await saveInt(key: key, value: sizeInt);

    return sizeInt;
  }

  ForumCardModel _toForumForCard(ForumFileModel model) {
    return ForumCardModel(
      id: model.id,
      name: model.name,
      description: model.description,
      chapterId: model.chapterId,
      privacy: model.privacy,
    );
  }

  TopicCardModel _toTopicForCard(TopicFileModel model) {
    return TopicCardModel(
      id: model.id,
      name: model.name,
      creatorId: model.creatorId,
      forumId: model.forumId,
      description: model.description,
      profilePic: model.user.photoUrl,
      creatorName: model.user.fullName,
      dateCreated: model.createdAt,
    );
  }

  MessageCardModel _toMessageForCard(MessageFileModel model) {
    final hasReply = model.reply != null;
    final isUser = _userAccountDataFile.user.id == model.userId;
    final messages = _allMessagesFile.where((el) => el.topicId == model.topicId).toList();
    _sortData(messages);
    final indexOfModel = messages.indexOf(model);
    bool isNamed = false;
    if (indexOfModel != (messages.length - 1) && indexOfModel != 0) {
      final previousModel = messages[indexOfModel - 1];
      isNamed = model.userId == previousModel.userId;
    }

    return MessageCardModel(
      id: model.id,
      userId: model.userId,
      topicId: model.topicId,
      message: model.message,
      replyId: model.replyId,
      dateString: model.createdAt,
      senderName: model.user.fullName,
      senderImage: model.user.photoUrl,
      timeSent: model.time,
      hasReply: hasReply,
      isUser: isUser,
      isNamed: isNamed,
    );
  }

  void _sortData(List<MessageFileModel> data) {
    data.sort((x, y) => x.createdAt.getSecondsFromEpoch().compareTo(y.createdAt.getSecondsFromEpoch()));
  }

  EventCardModel _toEventForCard(EventFileModel model) {
    return EventCardModel(
      id: model.id,
      privacy: model.privacy,
      chapterId: model.chapterId,
      title: model.title,
      categoryId: model.categoryId,
      date: model.date,
      time: model.time,
      venue: model.venue,
      type: model.type,
      eventType: model.eventType,
      payment: model.payment,
      video: model.video,
      subscribed: model.subscribe,
    );
  }

  TransactionCardModel _toTransactionForCard(TransactionFileModel model) {
    return TransactionCardModel(
      id: model.id,
      cardId: model.cardId,
      transactionId: model.transactionId,
      amount: model.amount,
      package: model.package,
      createdAt: model.createdAt,
    );
  }

  TicketCardModel _toTicketForCard(SupportFileModel model) {
    return TicketCardModel(
      id: model.id,
      ticketKey: model.ticket,
      subject: model.subject,
      message: model.message,
      createdAt: model.createdAt,
      supportStage: model.supportStage,
      userAssigned: model.userAssigned?.fullName,
    );
  }

  BlogCardModel _toBlogForCard(BlogFileModel model) {
    return BlogCardModel(
      id: model.id,
      title: model.title,
      content: model.content,
      authorId: model.authorId,
      categoryId: model.categoryId,
      categoryName: model.category.name,
      createdAt: model.createdAt,
      fileUrl: model.fileUrl,
    );
  }

  @override
  UserAccountModel getProfileData() {
    return _userAccountDataFile.user;
  }

  @override
  SubscriptionModel getSubscriptionData() {
    return _userAccountDataFile.subscription!;
  }

  @override
  UserAccountCardModel getUserDataForCard() {
    final userAccount = _userAccountDataFile.user;
    return _toUserDataForCard(userAccount);
  }

  UserAccountCardModel _toUserDataForCard(UserAccountModel model) {
    return UserAccountCardModel(
      id: model.id,
      type: model.type,
      firstName: model.firstName,
      lastName: model.lastName,
      fullName: model.fullName,
      email: model.email,
      phone: model.phone,
      status: model.status,
      subscription: model.subscription.parseToBool(),
      photoUrl: model.photoUrl,
      membershipType: model.profile.nonNullType,
      gender: model.profile.genderType,
    );
  }

  @override
  List<int> getFreeEventsKeys() => _eventDataFile.data.where((el) => el.type == EventPaymentType.Free).map((e) => e.id).toList();

  @override
  List<int> getSubscribedKeys() => _eventDataFile.data.where((el) => el.subscribe).map((e) => e.id).toList();

  @override
  List<int> getEventsExcludeKeys() => getFreeEventsKeys() + getSubscribedKeys();

  @override
  Future<Response> verifyPayment(String reference) async {
    final response = _paymentService.verifyTransaction(reference, token);

    return response;
  }

  @override
  Future<Response> verifyEventPayment(String reference) async {
    final response = _paymentService.verifyEventTransaction(reference, token);

    return response;
  }

  @override
  Future<Response> saveEdit(String firstName, String lastName, String phone, String membershipType, String currentOccupation, String jobTitle, String companyName, String address, String city, String country, String gender, String dateOfBirth) async {
    final response = _profileService.saveEdit(firstName, lastName, phone, membershipType, currentOccupation, jobTitle, companyName, address, city, country, gender, dateOfBirth, token);

    return response;
  }

  @override
  Future<void> updateProfilePicture(File image) async {
    await _profileService.updatePicture(image, token);
  }

  @override
  Future<Response> chapterChangeRequest(ChapterType chapter) async {
    final selectedChapter = chaptersMap.where((el) => el["name"] == chapter.name).toList();
    final int chapterId = selectedChapter[0]["id"];

    final response = _profileService.makeChapterChangeRequest(chapterId, token);
    return response;
  }

  @override
  Future<ChapterRequestState> getRequestState(ChapterType type) async {
    final tempChapter = await getSavedString(key: tempChapterTypeKey);

    if (tempChapter.isEmpty) {
      return ChapterRequestState.inactive;
    } else if (tempChapter != type.name) {
      return ChapterRequestState.active;
    }

    return ChapterRequestState.active;
  }

  @override
  Future<Response> sendProgressReport(int activityId, String description, String dateCompleted, File certificate) async {
    final response = await _progressTrackerService.sendRequest(activityId, description, dateCompleted, certificate, token);

    return response;
  }

  @override
  Future<Response> submitTicket(String subject, String message, File? attachment) async {
   final response = await _supportService.submitTicket(subject, message, attachment, token);

   return response;
  }

  @override
  Future<Response> sendMessage(int topicId, String message) async {
    final response = await _forumService.sendMessage(topicId, message, token);

    return response;
  }

  @override
  Future<void> signUpNewUser(String firstName, String lastName, String emailAddress, String password, String confirmPassword) async {
    await _authService.registerAccount(firstName, lastName, emailAddress, password, confirmPassword);
  }

  @override
  Future<Response> submitAboutYou(String membershipType, int memberChapter, String occupation, String jobTitle) async {
    final response = await _onboardingService.submitAboutYou(membershipType, memberChapter, occupation, jobTitle, token);

    return response;
  }

  @override
  Future<Response> submitEmployerDetails(String companyName, String address, String city, String country) async {
    final response = await _onboardingService.submitEmployerDetails(companyName, address, city, country, token);

    return response;
  }

  @override
  Future<Response> submitCertification(String licenseName, String dateIssued, File licenseDocument) async {
    final response = await _onboardingService.submitCertification(licenseName, dateIssued, licenseDocument, token);

    return response;
  }

  @override
  Future<Response> submitResume(File resumeDocument) async {
    final response = await _onboardingService.submitResume(resumeDocument, token);

    return response;
  }

  @override
  Future<Response> submitNewRefereeDetail(String refereeName, String refereeOccupation, String refereeEmail, String refereePhone, String refereeRelation) async {
    final response = await _onboardingService.submitNewRefereeDetail(refereeName, refereeOccupation, refereeEmail, refereePhone, refereeRelation, token);

    return response;
  }

  @override
  Future<Response> submitEthicsStatus(int status) async {
    final response = await _onboardingService.submitEthicsStatus(status, token);

    return response;
  }

  @override
  Future<bool> isTokenActive() async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString(tokenStorageKey);

    if (value != null) {
      return true;
    }
    return false;
  }
}