part of 'chat_bloc.dart';

@immutable
sealed class ChatEvent {}

class ReceivingChat extends ChatEvent {
  final ChatMessage chatModel;

  ReceivingChat(this.chatModel);
}

class SendChat extends ChatEvent {
  final ChatMessage chatModel;

  SendChat(this.chatModel);
}

class FetchSummary extends ChatEvent {}

class OneChatFetch extends ChatEvent{
  final String id;

  OneChatFetch(this.id);
}
