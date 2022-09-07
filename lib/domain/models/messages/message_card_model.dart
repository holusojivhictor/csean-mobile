class MessageCardModel {
  final int id;
  final int userId;
  final int topicId;
  final String message;
  final int? replyId;
  final String dateString;
  final String senderName;
  final String senderImage;
  final String timeSent;
  final bool hasReply;
  final bool isUser;
  final bool isNamed;

  MessageCardModel({
    required this.id,
    required this.userId,
    required this.topicId,
    required this.message,
    required this.replyId,
    required this.dateString,
    required this.senderName,
    required this.senderImage,
    required this.timeSent,
    required this.hasReply,
    required this.isUser,
    required this.isNamed,
  });
}