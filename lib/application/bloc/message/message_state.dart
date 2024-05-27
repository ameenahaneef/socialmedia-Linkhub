part of 'message_bloc.dart';

@immutable
sealed class MessageState {}

final class MessageInitial extends MessageState {}


class WebSocketConnected extends MessageState{}

class WebSocketDisconnected extends MessageState{}

class MessageReceived extends MessageState{
  final String message;
  MessageReceived(this.message);
}