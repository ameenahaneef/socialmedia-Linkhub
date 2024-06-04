import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:socialmedia/application/bloc/chat/chat_bloc.dart';
import 'package:socialmedia/core/colors/colors.dart';
import 'package:socialmedia/core/constants.dart';
import 'package:socialmedia/core/navigator.dart';
import 'package:socialmedia/presentation/screens/messages/pages/singlechat.dart';
import 'package:socialmedia/presentation/screens/shimmer/shimmer.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key});

  String truncateWithEllipsis(int cutoff, String text) {
    return (text.length <= cutoff) ? text : '${text.substring(0, cutoff)}...';
  }

  String formatTime(String? timestamp) {
    if (timestamp == null) return 'Invalid Time';
    try {
      String cleanedTimestamp = timestamp.split(' ').sublist(0, 2).join(' ');
      DateTime dateTime =
          DateFormat('yyyy-MM-dd HH:mm:ss.SSS').parse(cleanedTimestamp);
      return DateFormat('hh:mm a').format(dateTime);
    } catch (e) {
      return 'Invalid Time';
    }
  }

  @override
  Widget build(BuildContext context) {
    context.read<ChatBloc>().add(FetchSummary());
    return Scaffold(
      backgroundColor: black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Messages',
          style: nostyle,
        ),
        backgroundColor: black,
      ),
      body: Center(
        child: BlocBuilder<ChatBloc, ChatState>(builder: (context, state) {
          if (state is SummaryLoading) {
            return ShimmerList();
            // const Center(
            //   child: CircularProgressIndicator(),
            // );
          } else if (state is SummaryEmpty) {
            return Center(
              child: Text(
                'No recent chats',
                style: nostyle,
              ),
            );
          } else if (state is SummarySuccess) {
            final sortedChats = List.from(state.chats)
              ..sort((a, b) {
                try {
                  DateTime dateA = DateFormat('yyyy-MM-dd HH:mm:ss.SSS')
                      .parse(a.lastMessageTimeStamp, true)
                      .toLocal();
                  DateTime dateB = DateFormat('yyyy-MM-dd HH:mm:ss.SSS')
                      .parse(b.lastMessageTimeStamp, true)
                      .toLocal();
                  return dateB.compareTo(dateA);
                } catch (e) {
                  return 0;
                }
              });

            return ListView.separated(
              separatorBuilder: (context, index) {
                return const SizedBox(
                  height: 1,
                );
              },
              itemCount: sortedChats.length,
              itemBuilder: (context, index) {
                final chat = sortedChats[index];
                final time = chat.lastMessageTimeStamp;
                final formattedtime = formatTime(time);
                final truncatedMessage =
                    truncateWithEllipsis(25, chat.lastMessageContent);
                return GestureDetector(
                  onTap: () async {
                    navigate(
                        context,
                        SingleChat(
                          id: chat.userId,
                          userName: chat.userName,
                          userProfileUrl: chat.userProfileUrl,
                        ));
                  },
                  child: Padding(
                    padding:
                         EdgeInsets.only(top: 10.0, left: 10, right: 8),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: korange,
                          backgroundImage: NetworkImage(chat.userProfileUrl ??
                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQttE9sxpEu1EoZgU2lUF_HtygNLCaz2rZYHg&s'),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              chat.userName,
                              style: headStyle,
                            ),
                            Text(
                              truncatedMessage,
                              style:messegeStyle,
                            ),
                          ],
                        )),
                        Text(
                          formattedtime,
                          style: nostyle,
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          }
          return const SizedBox();
        }),
      ),
    );
  }
}
