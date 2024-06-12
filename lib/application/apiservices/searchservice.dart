import 'dart:convert';
import 'dart:developer';
import 'package:socialmedia/application/apiservices/accessregenerator.dart';
import 'package:socialmedia/application/models/fetchpostmodel.dart';
import 'package:socialmedia/application/models/peopleprofile.dart';
import 'package:socialmedia/application/models/searchmodel.dart';
import 'package:socialmedia/application/securestorage/securestorage.dart';
import 'package:socialmedia/core/endpoints.dart';
import 'package:http/http.dart' as http;

class SearchApiService {
  Future<List<After>> getGlobalPost() async {
    final url = Uri.parse('${EndPoints.baseUrl}${EndPoints.globalPost}');
    try {
      final accessToken = await getAccessToken();
      final refreshToken = await getRefreshToken();
      final response = await http.get(url, headers: {
        'x-api-key': 'apikey@ciao',
        'x-access-token': '$accessToken',
        // 'x-refresh-token': '$refreshToken'
      });
      log("Global post ${response.body}");
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final List<dynamic> postData =
            jsonResponse['after execution']['PostsData'];
        if (postData.isEmpty) {
          log('nothing is available');
          return [];
        }
        final List<After> post =
            postData.map((postJson) => After.fromJson(postJson)).toList();
        return post;
      } else if (response.statusCode == 400 || response.statusCode == 401) {
        final newAccessToken = await AccessRegenerator().accessRegenerator(
            accessToken: accessToken!, refreshToken: refreshToken!);
        if (newAccessToken.isNotEmpty) {
          await storeTokens(newAccessToken, refreshToken);
          final response = await http.get(url, headers: {
            'x-api-key': 'apikey@ciao',
            'x-access-token': newAccessToken,
            //'x-refresh-token': '$refreshToken'
          });
          log('Response after expire: ${response.body}');
          if (response.statusCode == 200) {
            final jsonResponse = json.decode(response.body);
            final List<dynamic> postData =
                jsonResponse['after execution']['PostsData'];
            if (postData.isEmpty) {
              log('nothing is available');
              return [];
            }
            final List<After> post =
                postData.map((postJson) => After.fromJson(postJson)).toList();
                log('Post length: ${post.length}');
            return post;
          }
        }
      } else {
        log('failed to fetch ${response.statusCode}');
      }
    } catch (e) {
      log(e.toString());
    }
    return [];
  }

  Future<List<User>> searchUser(String text) async {
    final url = Uri.parse('${EndPoints.baseUrl}/explore/search/user/$text');
    try {
      final accessToken = await getAccessToken();
      final refreshToken = await getRefreshToken();
      final response = await http.get(url, headers: {
        'x-api-key': 'apikey@ciao',
        'x-access-token': '$accessToken',
        //'x-refresh-token': '$refreshToken'
      });
      log(response.body);
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final List<User> userList =
            (jsonResponse['after execution']['SearchResult'] as List)
                .map((userData) => User.fromJson(userData))
                .toList();
        return userList;
      }else if(response.statusCode==400||response.statusCode==401){
        final newAccessToken=await AccessRegenerator().accessRegenerator(accessToken: accessToken!, refreshToken: refreshToken!);
        if(newAccessToken.isNotEmpty){
          await storeTokens(newAccessToken, refreshToken);
          final response = await http.get(url, headers: {
        'x-api-key': 'apikey@ciao',
        'x-access-token': newAccessToken,
        //'x-refresh-token': '$refreshToken'
      });
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final List<User> userList =
            (jsonResponse['after execution']['SearchResult'] as List)
                .map((userData) => User.fromJson(userData))
                .toList();
        return userList;}

        }

      }
      
      
       else {
        log('failed.statuscode${response.statusCode}');
      }
    } catch (e) {
      log(e.toString());
    }
    return [];
  }

  Future<PeopleAfter?> getPeopleProfile(int id) async {
    final url = Uri.parse('${EndPoints.baseUrl}/explore/profile/$id');
    try {
      final accessToken = await getAccessToken();
      final refreshToken = await getRefreshToken();
      final response = await http.get(url, headers: {
        'x-api-key': 'apikey@ciao',
        'x-access-token': '$accessToken',
       // 'x-refresh-token': '$refreshToken'
      });
      log(response.body);
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final user = jsonResponse['after execution'];
        if (user != null) {
          final PeopleAfter userss = PeopleAfter.fromJson(user);
          print('💕💕💕💕$userss');
          return userss;
        } 
        else {
          log('failed.statuscode${response.statusCode}');
        }
      }else if(response.statusCode==400||response.statusCode==401){
        final newAccessToken=await AccessRegenerator().accessRegenerator(accessToken: accessToken!, refreshToken: refreshToken!);
        if(newAccessToken.isNotEmpty){
          await storeTokens(newAccessToken, refreshToken);
          final response = await http.get(url, headers: {
        'x-api-key': 'apikey@ciao',
        'x-access-token': newAccessToken,
       // 'x-refresh-token': '$refreshToken'
      });
      if(response.statusCode==200){
         final jsonResponse = json.decode(response.body);
        final user = jsonResponse['after execution'];
        if (user != null) {
          final PeopleAfter userss = PeopleAfter.fromJson(user);
          print('💕💕💕💕$userss');
          return userss;
        } 
        else {
          log('failed.statuscode${response.statusCode}');
        }
      }
        }
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }
}
