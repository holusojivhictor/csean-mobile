import 'package:csean_mobile/domain/models/model.dart';
import 'package:flutter/material.dart';

class MessageCard extends StatelessWidget {
  final int id;
  final String message;
  final String senderName;
  final String senderImage;
  final String timeSent;
  final bool hasReply;
  final bool isUser;
  final bool isNamed;

  final bool withElevation;

  const MessageCard({
    Key? key,
    required this.id,
    required this.message,
    required this.senderName,
    required this.senderImage,
    required this.timeSent,
    required this.hasReply,
    required this.isUser,
    required this.isNamed,
    this.withElevation = true,
  }) : super(key: key);

  MessageCard.chat({
    Key? key,
    required MessageCardModel message,
    this.withElevation = true,
  })  : id = message.id,
        message = message.message,
        senderName = message.senderName,
        senderImage = message.senderImage,
        timeSent = message.timeSent,
        hasReply = message.hasReply,
        isUser = message.isUser,
        isNamed = message.isNamed,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: EdgeInsets.only(left: 15, right: 15, top: isNamed ? 2 : 8, bottom: 3),
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Row(
        mainAxisAlignment: isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!isUser)
            Row(
              children: [
                CircleAvatar(
                  radius: 13,
                  backgroundColor: isNamed ? Colors.transparent : Colors.greenAccent,
                  child: isNamed ? null : const Icon(Icons.person, size: 15, color: Colors.white),
                ),
                const SizedBox(width: 5),
              ],
            ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!isNamed)
                Row(
                  children: [
                    Text(
                      isUser ? 'You' : '$senderName, $timeSent',
                      style: theme.textTheme.bodyText2!.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              const SizedBox(height: 3),
              Container(
                constraints: const BoxConstraints(maxWidth: 300, minHeight: 30),
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: isUser ? const Color(0xFFD0D3E3) : Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: Text(
                  message,
                  style: theme.textTheme.headline4,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
