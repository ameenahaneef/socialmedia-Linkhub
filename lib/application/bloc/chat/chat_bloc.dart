import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:socialmedia/application/apiservices/chatsummary.dart';
import 'package:socialmedia/application/models/chatmodel.dart';
import 'package:socialmedia/application/models/newchat.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(ChatInitial()) {
    List<ChatMessage>? allMessages = [];
    on<ReceivingChat>((event, emit) {
      allMessages!.add(event.chatModel);

      emit(ChatSuccess(allMessages!));
    });

    on<SendChat>((event, emit) async {
      allMessages!.add(event.chatModel);
      emit(ChatSuccess(allMessages!));
    });

    on<FetchSummary>((event, emit) async {
      try {
        final chats = await ChatServices().getChatSummary();
        emit(SummarySuccess(chats));
      } catch (e) {
        emit(SummaryEmpty());
      }
    });

    on<OneChatFetch>((event, emit) async {
      try {
        final singleChats = await ChatServices().getOneChatSummary(event.id);
        allMessages = singleChats
            .map(
              (e) => ChatMessage(
                  messageId: e.messageId,
                  senderId: e.senderId,
                  recipientId: e.recipientId,
                  content: e.content,
                  status: e.status,
                  timeStamp: e.timeStamp),
            )
            .toList();
        emit(ChatSuccess(singleChats));
      } catch (e) {

      }
    });
  }
}
