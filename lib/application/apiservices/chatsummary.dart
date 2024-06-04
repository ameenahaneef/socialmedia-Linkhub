import 'dart:developer';
import 'package:socialmedia/application/apiservices/accessregenerator.dart';
import 'package:socialmedia/application/models/chatmodel.dart';
import 'package:socialmedia/application/models/newchat.dart';
import 'package:socialmedia/application/securestorage/securestorage.dart';
import 'package:socialmedia/core/endpoints.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class ChatServices {
  Future<List<Chatsummary>> getChatSummary() async {
    final url = Uri.parse('${EndPoints.baseUrl}${EndPoints.chatSummary}');
    try {
      final accessToken = await getAccessToken();
      final refreshToken = await getRefreshToken();
      final response = await http.get(
        url,
        headers: {
          'x-api-key': 'apikey@ciao',
          'x-access-token': '$accessToken',
         // 'x-refresh-token': '$refreshToken',
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        print('👽👽chat fetched');
      
      log('👽👽👽👽👽${response.statusCode}');
      final jsonResponse = json.decode(response.body);
      final List<dynamic> data = jsonResponse['after execution']['ActualData'];
      final List<Chatsummary> chats =
          data.map((data) => Chatsummary.fromJson(data)).toList();
      log('💕💕💕💕${response.body}');
      return chats;
    }else if(response.statusCode==401||response.statusCode==400){
      final newAccessToken=await AccessRegenerator().accessRegenerator(accessToken: accessToken!, refreshToken: refreshToken!);
      if(newAccessToken.isNotEmpty){
        await storeTokens(newAccessToken, refreshToken);
        final response=await http.get(url,
         headers: {
          'x-api-key': 'apikey@ciao',
          'x-access-token': newAccessToken,
          //'x-refresh-token': '$refreshToken',
          'Content-Type': 'application/json',
        },);
        if(response.statusCode==200){
        final jsonResponse = json.decode(response.body);
      final List<dynamic> data = jsonResponse['after execution']['ActualData'];
      final List<Chatsummary> chats =
          data.map((data) => Chatsummary.fromJson(data)).toList();
      log('💕💕💕💕${response.body}');
      return chats;
        }
      }
    }
    
     }catch (e) {
      log(e.toString());
    }
    return [];
  }

  Future<List<ChatMessage>> getOneChatSummary(String id,
      {int limit = 100, int offset = 0}) async {
    final url = Uri.parse(
        '${EndPoints.baseUrl}${EndPoints.oneToOneChat}$id/?limit=$limit&offset=$offset');
   
    try {
      final accessToken = await getAccessToken();
      final refreshToken = await getRefreshToken();
      final response = await http.get(
        url,
        headers: {
          'x-api-key': 'apikey@ciao',
          'x-access-token': '$accessToken',
          //'x-refresh-token': '$refreshToken',
          'Content-Type': 'application/json',
        },
      );
      log(response.body);
      if (response.statusCode == 200) {
        print('successs/......');
      
      final jsonResponse = json.decode(response.body);
      final List<dynamic> chat = jsonResponse['after execution']['Chat'];
      final List<ChatMessage> chats =
          chat.map((chat) => ChatMessage.fromJson(chat)).toList();
      return chats.reversed.toList();
    }else if(response.statusCode==401||response.statusCode==400){
      final newAccessToken=await AccessRegenerator().accessRegenerator(accessToken: accessToken!, refreshToken: refreshToken!);
      if(newAccessToken.isNotEmpty){
        await storeTokens(newAccessToken, refreshToken);
        final response=await http.get(url,headers: {
          'x-api-key': 'apikey@ciao',
          'x-access-token': newAccessToken,
          //'x-refresh-token': '$refreshToken',
          'Content-Type': 'application/json',
        });
        if(response.statusCode==200){
          final jsonResponse = json.decode(response.body);
      final List<dynamic> chat = jsonResponse['after execution']['Chat'];
      final List<ChatMessage> chats =
          chat.map((chat) => ChatMessage.fromJson(chat)).toList();
      return chats.reversed.toList();
        }
      }
    }else{print('not successss');
    }
    
     }catch (e) {
      log(e.toString());
    }
    return [];
  }
}
