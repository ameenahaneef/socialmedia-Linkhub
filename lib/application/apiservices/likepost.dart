import 'dart:developer';

import 'package:socialmedia/application/apiservices/accessregenerator.dart';
import 'package:socialmedia/application/securestorage/securestorage.dart';
import 'package:socialmedia/core/endpoints.dart';
import 'package:http/http.dart'as http;

class LikeServices{
  Future<void>likePost(int postId)async{
    final url=Uri.parse('${EndPoints.baseUrl}${EndPoints.likePost}$postId');
    try {
      final accessToken = await getAccessToken();
      final refreshToken = await getRefreshToken();
      final response = await http.post(url, headers: {
        'x-api-key': 'apikey@ciao',
        'x-access-token': '$accessToken',
       // 'x-refresh-token': '$refreshToken',
      }); 
      if(response.statusCode==200){
        log('successfully followed');
      }else if(response.statusCode==400||response.statusCode==401){
        final newAccessToken=await AccessRegenerator().accessRegenerator(accessToken: accessToken!, refreshToken: refreshToken!);
        if(newAccessToken.isNotEmpty){
          await storeTokens(newAccessToken, refreshToken);
          final response = await http.post(url, headers: {
        'x-api-key': 'apikey@ciao',
        'x-access-token': newAccessToken,
       // 'x-refresh-token': '$refreshToken',
      });
      if(response.statusCode==200){
        log('failed to like');
      }
        }
      }
      print(response.statusCode);
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void>unLikePost(int postId)async{
    final url=Uri.parse('${EndPoints.baseUrl}${EndPoints.likePost}$postId');
    try {
       final accessToken = await getAccessToken();
      final refreshToken = await getRefreshToken();
      final response = await http.delete(url, headers: {
        'x-api-key': 'apikey@ciao',
        'x-access-token': '$accessToken',
        //'x-refresh-token': '$refreshToken',
      }); 
      if(response.statusCode==200){
        log('successfully unfollowed');
      }else if(response.statusCode==400||response.statusCode==401){
        final newAccessToken=await AccessRegenerator().accessRegenerator(accessToken: accessToken!, refreshToken: refreshToken!);
        if(newAccessToken.isNotEmpty){
          await storeTokens(newAccessToken, refreshToken);
            final response = await http.delete(url, headers: {
        'x-api-key': 'apikey@ciao',
        'x-access-token': newAccessToken,
        //'x-refresh-token': '$refreshToken',
      });
      if(response.statusCode==200){
        log('successfully unliked');
      } 
        }
      }
      print('😶‍🌫️${response.statusCode}');
    } catch (e) {
      log(e.toString());
    }
  }
}