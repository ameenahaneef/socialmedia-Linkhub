part of 'chat_bloc.dart';

@immutable
sealed class ChatState {}

final class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {}

class ChatSuccess extends ChatState {
  final List<ChatMessage> chatModel;

  ChatSuccess(this.chatModel);
}

class ChatEmpty extends ChatState {}

class SummaryLoading extends ChatState {}

class SummarySuccess extends ChatState {
  final List<Chatsummary> chats;

  SummarySuccess(this.chats);
}

class SummaryEmpty extends ChatState {}




