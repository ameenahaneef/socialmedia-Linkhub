import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:socialmedia/application/bloc/chat/chat_bloc.dart';
import 'package:socialmedia/application/models/chatmodel.dart';
import 'package:web_socket_channel/io.dart';
IOWebSocketChannel? channel;
class WebSocketService {
  static const FlutterSecureStorage _storage = FlutterSecureStorage();
  static const String accessTokenKey = 'AccessToken';
  Future<String?> getAccessToken() async {
    return await _storage.read(key: accessTokenKey);
  }
  Future<void> connect(BuildContext context) async {
    String? accessToken = await getAccessToken();
    final url = Uri.parse('wss://ciao.ashkar.tech/chat/ws');
    if (accessToken != null) {
      try {
        channel = IOWebSocketChannel.connect(
          url,
          headers: {
            'x-api-key': 'apikey@ciao',
            'x-access-token': accessToken,
          },
        );
        ChatMessage? chats;
        channel!.stream.listen((message) {
          log('👽👽👽👽$message');
            final decodedMessage = jsonDecode(message) as Map<String, dynamic>;
            chats = ChatMessage.fromJson(decodedMessage);
            if (chats != null) {
              context.read<ChatBloc>().add(ReceivingChat(chats!));
            }
        });
      } catch (e) {
        throw Exception('Failed to connect to WebSocket: $e');
      }
    } else {
      throw Exception('No access token found');
    }
  }

  void sendMessage(String userId, String message) {
    if (channel != null && message.isNotEmpty) {
      final formattedMessage = {
        "RecipientId": userId,
        "Content": message,
        "Type": "OneToOne"
      };
      channel?.sink.add(jsonEncode(formattedMessage));
    }
  }
}
