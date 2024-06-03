import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialmedia/application/apiservices/websocketservice.dart';
import 'package:socialmedia/application/bloc/chat/chat_bloc.dart';
import 'package:socialmedia/application/models/chatmodel.dart';
import 'package:socialmedia/core/colors/colors.dart';
import 'package:socialmedia/core/constants.dart';
import 'package:socialmedia/core/functions/functions.dart';
import 'package:socialmedia/presentation/screens/messages/widgets/columnmessage.dart';
import 'package:socialmedia/presentation/screens/messages/widgets/messegetextfield.dart';
class SingleChat extends StatefulWidget {
  final String? id;
  final String? userName;
  final String? userProfileUrl;
  SingleChat(
      {super.key,
      required this.id,
      required this.userName,
      required this.userProfileUrl});
  @override
  State<SingleChat> createState() => _SingleChatState();
}
class _SingleChatState extends State<SingleChat> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }
  
  @override
  Widget build(BuildContext context) {
    context.read<ChatBloc>().add(OneChatFetch(widget.id!));
    return Scaffold(
        backgroundColor: black,
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                context.read<ChatBloc>().add(FetchSummary());
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back)),
          backgroundColor: black,
          foregroundColor: kwhite,
          title: Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(widget.userProfileUrl ??
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQttE9sxpEu1EoZgU2lUF_HtygNLCaz2rZYHg&s'),
              ),
              kwidth,
              Text(widget.userName ?? '', style: nostyle),
            ],
          ),
        ),
        body: Column(
          children: [
            height20,
            Expanded(
              child:
                  BlocBuilder<ChatBloc, ChatState>(builder: (context, state) {
                if (state is ChatSuccess) {
                  WidgetsBinding.instance
                      .addPostFrameCallback((_) => _scrollToBottom());

                  return ListView.separated(
                    controller: _scrollController,
                    separatorBuilder: (context, index) => height20,
                    itemCount: state.chatModel.length,
                    itemBuilder: (context, index) {
                      ChatMessage chat = state.chatModel[index];
                      String time = chat.timeStamp ?? '';
                      final formattedDate = formatDate(time);
                      final formattedTime = formatTimestamp(time);
                      bool showDate = index == 0 ||
                          formatDate(
                                  state.chatModel[index - 1].timeStamp ?? '') !=
                              formattedDate;
                      return Columnmessage(
                          showDate: showDate,
                          formattedDate: formattedDate,
                          widget: widget,
                          chat: chat,
                          formattedTime: formattedTime);
                    },
                  );
                }
                return const SizedBox();
              }),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Messegetextfield(controller: _controller),
                  ),
                  iconbuttonmessege(context),
                ],
              ),
            ),
          ],
        ));
  }

  IconButton iconbuttonmessege(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.send, color: kwhite),
      onPressed: () {
        if (_controller.text.isNotEmpty) {
          WebSocketService().sendMessage(widget.id!, _controller.text);
          final chat = ChatMessage(
              content: _controller.text, timeStamp: DateTime.now().toString());
          context.read<ChatBloc>().add(SendChat(chat));
          _controller.clear();
          WidgetsBinding.instance
              .addPostFrameCallback((_) => _scrollToBottom());
        }
      },
    );
  }
}
