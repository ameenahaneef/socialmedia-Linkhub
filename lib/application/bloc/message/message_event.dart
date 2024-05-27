part of 'message_bloc.dart';

@immutable
sealed class MessageEvent {}

class ConnectWebSocket extends MessageEvent{}

class DisconnectWebSocket extends MessageEvent{}

class ReceiveMessage extends MessageEvent{
  final String message;
  ReceiveMessage(this.message);
}