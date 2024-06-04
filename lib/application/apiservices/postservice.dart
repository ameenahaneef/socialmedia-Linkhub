import 'dart:convert';
import 'dart:developer';
import 'package:socialmedia/application/apiservices/accessregenerator.dart';
import 'package:socialmedia/application/models/fetchpostmodel.dart';
import 'package:socialmedia/application/securestorage/securestorage.dart';
import 'package:socialmedia/core/endpoints.dart';
import 'package:http/http.dart' as http;

class PostApiService {
  Future<void> postImage(String caption, List mediaUrls) async {
    final url = Uri.parse('${EndPoints.baseUrl}${EndPoints.postAddUrl}');
    try {
      final accessToken = await getAccessToken();
      final refreshToken = await getRefreshToken();
      if (accessToken == null || refreshToken == null) {
        return;
      }
      final response = http.MultipartRequest('POST', url);
      response.headers['x-api-key'] = apikey;
      response.headers['x-access-token'] = accessToken;
      //response.headers['x-refresh-token'] = refreshToken;
      response.fields['caption'] = caption;
      for (int i = 0; i < mediaUrls.length; i++) {
        var mediaUrl = mediaUrls[i];
        response.files
            .add(await http.MultipartFile.fromPath('media', mediaUrl));
      }
      final res = await response.send();
      if (res.statusCode == 200) {
        log('image uploaded succefully');
      }
      else if(res.statusCode==400||res.statusCode==401){
        final newAccessToken=await AccessRegenerator().accessRegenerator(accessToken: accessToken, refreshToken: refreshToken);
        if(newAccessToken.isNotEmpty){
          await storeTokens(newAccessToken, refreshToken);
           final response = http.MultipartRequest('POST', url);
      response.headers['x-api-key'] = apikey;
      response.headers['x-access-token'] = newAccessToken;
     // response.headers['x-refresh-token'] = refreshToken;
      response.fields['caption'] = caption;
      for (int i = 0; i < mediaUrls.length; i++) {
        var mediaUrl = mediaUrls[i];
        response.files
            .add(await http.MultipartFile.fromPath('media', mediaUrl));
      }
      final res = await response.send();
      if (res.statusCode == 200) {
        log('image uploaded succefully');
      }
        }
      }
      
       else {
        log('failed to upload image.statuscode:${res.statusCode}');
      }
    } catch (e) {
      log('error posting image:${e.toString()}');
    }
  }

  Future<List<After>> postFetch({int limit = 10, int offset = 0}) async {
    try {
      final accessToken = await getAccessToken();
      final refreshToken = await getRefreshToken();
      log(accessToken!);
      log(refreshToken!);
     final url = Uri.parse('${EndPoints.baseUrl}${EndPoints.postAddUrl}').replace(queryParameters: {
        'limit':limit.toString(),
        'offset':offset.toString()
      });
      final response = await http.get(
        url,
        headers: {
          'x-api-key': 'apikey@ciao',
          'x-access-token': accessToken,
         // 'x-refresh-token': refreshToken
        },
      );
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final List<dynamic> postData = jsonResponse['after execution']['PostsData'];
        if (postData.isEmpty) {
          log('nothing is available');
          return [];
        }
        final List<After> post = postData
            .map((postJson) => After.fromJson(postJson))
            .toList();

        log('❤️❤️❤️❤️${response.body}');
        return post;
      }
      else if(response.statusCode==400||response.statusCode==401){
        final newAccessToken=await AccessRegenerator().accessRegenerator(accessToken: accessToken, refreshToken: refreshToken);
        if(newAccessToken.isNotEmpty){
          await storeTokens(newAccessToken, refreshToken);
           final response = await http.get(
        url,
        headers: {
          'x-api-key': 'apikey@ciao',
          'x-access-token': newAccessToken,
         // 'x-refresh-token': refreshToken
        },
      );
        if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final List<dynamic> postData = jsonResponse['after execution']['PostsData'];
        if (postData.isEmpty) {
          log('nothing is available');
          return [];
        }
        final List<After> post = postData
            .map((postJson) => After.fromJson(postJson))
            .toList();

        log('❤️❤️❤️❤️${response.body}');
        return post;
      }

        }
      }
      
      
       else {
        log('failed to fetch ${response.statusCode}');
      }
    } catch (e) {
      log('🤣🤣👀error ${e.toString()}');
    }
    return [];
  }

  Future<void> deletePost(String postid) async {
    try {
      final accessToken = await getAccessToken();
      final refreshToken = await getRefreshToken();
      final url = Uri.parse('${EndPoints.baseUrl}${EndPoints.postAddUrl}$postid');
      final response = await http.delete(url,
          headers: {
            'Content-Type': 'application/json',
            'x-api-key': 'apikey@ciao',
            'x-access-token': '$accessToken',
            //'x-refresh-token': '$refreshToken'
          },
         );
      log('🤦‍♀️🤦‍♀️🤦‍♀️${response.body}');
      if(response.statusCode==200){
        log('deleted successfully');
      }else if(response.statusCode==400||response.statusCode==401){
        final newAccessToken=await AccessRegenerator().accessRegenerator(accessToken: accessToken!, refreshToken: refreshToken!);
        if(newAccessToken.isNotEmpty){
          await storeTokens(newAccessToken, refreshToken);
          final response = await http.delete(url,
          headers: {
            'Content-Type': 'application/json',
            'x-api-key': 'apikey@ciao',
            'x-access-token': newAccessToken,
            //'x-refresh-token': '$refreshToken'
          },
         );
         if(response.statusCode==200){
          log('deleted');
         }
        }
      }
   
    } catch (e) {
      log('🤦‍♂️🤦‍♂️🤦‍♂️🤦‍♂️${e.toString()}');
    }
  }




   Future<void> editCaption(String caption,String postid) async {
    try {
      final accessToken = await getAccessToken();
      final refreshToken = await getRefreshToken();
      final url = Uri.parse('${EndPoints.baseUrl}${EndPoints.postAddUrl}');
      final body = {
        "caption":caption,
        "postid": postid};
      final response = await http.patch(url,
          headers: {
            'Content-Type': 'application/json',
            'x-api-key': 'apikey@ciao',
            'x-access-token': '$accessToken',
           // 'x-refresh-token': '$refreshToken'
          },
          body: jsonEncode(body));
      log('🤦‍♀️🤦‍♀️🤦‍♀️${response.body}');
      if(response.statusCode==200){
        log('edited');
      }else if(response.statusCode==400||response.statusCode==401){
        final newAccessToken=await AccessRegenerator().accessRegenerator(accessToken: accessToken!, refreshToken: refreshToken!);
        if(newAccessToken.isNotEmpty){
          await storeTokens(newAccessToken, refreshToken);
           final response = await http.patch(url,
          headers: {
            'Content-Type': 'application/json',
            'x-api-key': 'apikey@ciao',
            'x-access-token': newAccessToken,
           // 'x-refresh-token': '$refreshToken'
          },
          body: jsonEncode(body));
          if(response.statusCode==200){
            log('successs');
          }
        }
      }
    } catch (e) {
      log('🍿🍿${e.toString()}');
    }
  }



 Future<List<After>> getUserPost( {required int userId,int limit = 12, int offset = 0}) async {
    try {
      final accessToken = await getAccessToken();
      final refreshToken = await getRefreshToken();
      log(accessToken!);
      log(refreshToken!);
       final url = Uri.parse('${EndPoints.baseUrl}/post?')
        .replace(queryParameters: {
          'limit': limit.toString(),
          'offset': offset.toString(),
          'userbid': userId.toString(),
        });  
      final response = await http.get(
        url,
        headers: {
          'x-api-key': 'apikey@ciao',
          'x-access-token': accessToken,
          //'x-refresh-token': RefreshToken
        },
      );
      log('💕💕💕💕💕💕💕${response.body}');
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final List<dynamic> postData = jsonResponse['after execution']['PostsData'];
        if (postData.isEmpty) {
          log('nothing is available');
          return [];
        }
        final List<After> post = postData
            .map((postJson) => After.fromJson(postJson))
            .toList();

        log('❤️❤️❤️❤️${response.body}');
        print('👀👀👀👀👀👀$post');
        return post;
      }else if(response.statusCode==400||response.statusCode==401){
        final newAccessToken=await AccessRegenerator().accessRegenerator(accessToken: accessToken, refreshToken:refreshToken);
        if(newAccessToken.isNotEmpty){
          await storeTokens(newAccessToken, refreshToken);
           final response = await http.get(
        url,
        headers: {
          'x-api-key': 'apikey@ciao',
          'x-access-token': newAccessToken,
          //'x-refresh-token': RefreshToken
        },
      );
      if(response.statusCode==200){
         final jsonResponse = json.decode(response.body);
        final List<dynamic> postData = jsonResponse['after execution']['PostsData'];
        if (postData.isEmpty) {
          log('nothing is available');
          return [];
        }
        final List<After> post = postData
            .map((postJson) => After.fromJson(postJson))
            .toList();

        log('❤️❤️❤️❤️${response.body}');
        print('👀👀👀👀👀👀$post');
        return post;
      }
        }
      }
      
      
       else {
        log('failed to fetch ${response.statusCode}');
      }
    } catch (e) {
      log('🤣🤣👀error ${e.toString()}');
    }
    return [];
  }

}
