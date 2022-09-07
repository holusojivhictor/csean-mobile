import 'package:csean_mobile/application/bloc.dart';
import 'package:csean_mobile/domain/models/model.dart';
import 'package:csean_mobile/presentation/discussions/widgets/message_card.dart';
import 'package:csean_mobile/presentation/shared/loading.dart';
import 'package:csean_mobile/presentation/shared/nothing_found_column.dart';
import 'package:csean_mobile/domain/extensions/string_extensions.dart';
import 'package:csean_mobile/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MessagesPage extends StatefulWidget {
  const MessagesPage({Key? key}) : super(key: key);

  @override
  State<MessagesPage> createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<MessagesBloc, MessagesState>(
      builder: (ctx, state) => state.map(
        loading: (_) => const Loading(),
        loaded: (state) => Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            toolbarHeight: 70.0,
            automaticallyImplyLeading: false,
            leading: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Icon(Icons.keyboard_backspace_rounded, color: theme.indicatorColor),
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  state.topic.name,
                  style: theme.textTheme.headline2,
                ),
                Text(
                  'Created by ${state.topic.creatorName}',
                  style: theme.textTheme.bodyText1,
                ),
                Text(
                  'On ${state.topic.dateCreated.formatDateString(hasYear: true)}',
                  style: theme.textTheme.bodyText2,
                ),
              ],
            ),
            actions: const [
              Padding(
                padding: Styles.edgeInsetHorizontal10,
                child: Icon(Icons.info_outline_rounded, color: Colors.black),
              )
            ],
            bottom: PreferredSize(
              child: Container(
                color: Colors.grey.withOpacity(0.4),
                height: 1,
              ),
              preferredSize: const Size.fromHeight(3),
            ),
          ),
          body: Column(
            children: [
              _buildCard(context),
              if (state.messages.isNotEmpty) Flexible(child: _buildList(context, state.messages)) else const Flexible(child: NothingFoundColumn()),
              _buildMessageField(context, state.topic.id),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildList(BuildContext context, List<MessageCardModel> messages) {
    return ListView.builder(
      reverse: true,
      itemBuilder: (context, index) => MessageCard.chat(message: messages[index]),
      itemCount: messages.length,
    );
  }

  Widget _buildCard(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.grey.withOpacity(0.5),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Text(
              'This is the beginning of this chat',
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageField(BuildContext context, int topicId) {
    final mediaQuery = MediaQuery.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            width: mediaQuery.size.width * 0.85,
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(
                hintText: "Write your message...",
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                border: Styles.outlineInputBorder(context),
                enabledBorder: Styles.outlineInputBorder(context),
                focusedBorder: Styles.outlineInputBorder(context),
              ),
            ),
          ),
          GestureDetector(
            onTap: () => sendMessage(topicId),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Theme.of(context).primaryColor),
              ),
              child: Icon(Icons.send, size: 23, color: Theme.of(context).primaryColor),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> sendMessage(int topicId) async {
    if (_messageController.text.isNotEmpty) {
      final bloc = context.read<DataBloc>();
      bloc.add(DataEvent.sendMessage(topicId: topicId, message: _messageController.text));
      _messageController.clear();
    }
  }
}
