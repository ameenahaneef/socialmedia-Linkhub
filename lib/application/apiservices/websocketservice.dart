import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:socialmedia/application/apiservices/accessregenerator.dart';
import 'package:socialmedia/application/bloc/chat/chat_bloc.dart';
import 'package:socialmedia/application/models/chatmodel.dart';
import 'package:socialmedia/application/securestorage/securestorage.dart';
import 'package:web_socket_channel/io.dart';
IOWebSocketChannel? channel;
class WebSocketService {
  static const FlutterSecureStorage _storage = FlutterSecureStorage();
  static const String accessTokenKey = 'AccessToken';
  static const String refreshTokenKey = 'RefreshToken';
  Future<String?> getAccessToken() async {
    return await _storage.read(key: accessTokenKey);
  }
   Future<String?> getRefreshToken() async {
    return await _storage.read(key: refreshTokenKey);
  }
  Future<void> connect(BuildContext context) async {
    String? accessToken = await getAccessToken();
     String? refreshToken = await getRefreshToken();
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
        } catch (e) {
if(e.toString().contains('401')||e.toString().contains('400')){
  final newAccessToken=await AccessRegenerator().accessRegenerator(accessToken: accessToken, refreshToken: refreshToken!);
  if(newAccessToken.isNotEmpty){
    await storeTokens(newAccessToken, refreshToken);
     channel = IOWebSocketChannel.connect(
          url,
          headers: {
            'x-api-key': 'apikey@ciao',
            'x-access-token': newAccessToken,
          },
        );
  }
}
        throw Exception('Failed to connect to WebSocket: $e');
      }
        ChatMessage? chats;
        channel!.stream.listen((message) {
          log('👽👽👽👽$message');
            final decodedMessage = jsonDecode(message) as Map<String, dynamic>;
            chats = ChatMessage.fromJson(decodedMessage);
            if (chats != null) {
              context.read<ChatBloc>().add(ReceivingChat(chats!));
            }
        });
      
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
