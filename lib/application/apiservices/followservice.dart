import 'dart:convert';
import 'dart:math';

import 'package:socialmedia/application/apiservices/accessregenerator.dart';
import 'package:socialmedia/application/models/follow.dart';
import 'package:socialmedia/application/models/following.dart';
import 'package:socialmedia/application/securestorage/securestorage.dart';
import 'package:socialmedia/core/endpoints.dart';
import 'package:http/http.dart' as http;

class FollowService {
  Future<Follow?> followUsers(int id) async {
    final url = Uri.parse('${EndPoints.baseUrl}/relation/follow/$id');
    try {
      final accessToken = await getAccessToken();
      final refreshToken = await getRefreshToken();
      final response = await http.post(url, headers: {
        'x-api-key': 'apikey@ciao',
        'x-access-token': '$accessToken',
        // 'x-refresh-token': '$refreshToken',
      });
      log(response.statusCode);
      print('🤦‍♀️🤦‍♀️Response Status Code: ${response.statusCode}');
      if (response.statusCode == 200) {
        print('successfully followed');
        final jsonResponse = json.decode(response.body);
        final follow = Follow.fromJson(jsonResponse);
        return follow;
      } else if (response.statusCode == 400 || response.statusCode == 401) {
        final newAccessToken = await AccessRegenerator().accessRegenerator(
            accessToken: accessToken!, refreshToken: refreshToken!);
        if (newAccessToken.isNotEmpty) {
          await storeTokens(newAccessToken, refreshToken);
          final response = await http.post(url, headers: {
            'x-api-key': 'apikey@ciao',
            'x-access-token': newAccessToken,
            //'x-refresh-token': '$refreshToken',
          });
          if (response.statusCode == 200) {
            print('successfully followed');
             final jsonResponse = json.decode(response.body);
        final follow = Follow.fromJson(jsonResponse);
        return follow;
          }else{
            print('failed to follow');
          }
        }
      }
    } catch (e) {
      print('Error parsing JSON response: $e');
    }
    return null;
  }

  Future<Follow?> unFollowUsers(int id) async {
    final url = Uri.parse('${EndPoints.baseUrl}/relation/unfollow/$id');
    try {
      final accessToken = await getAccessToken();
      final refreshToken = await getRefreshToken();
      final response = await http.delete(url, headers: {
        'x-api-key': 'apikey@ciao',
        'x-access-token': '$accessToken',
        //'x-refresh-token': '$refreshToken'
      });
      log(response.statusCode);
      if (response.statusCode == 200) {
        print('${response.body}');
        print('successfully unfollowed');
        final jsonResponse = json.decode(response.body);
        final follow = Follow.fromJson(jsonResponse);
        return follow;
      }else if(response.statusCode==400||response.statusCode==401){
        final newAccessToken=await AccessRegenerator().accessRegenerator(accessToken: accessToken!, refreshToken: refreshToken!);
        if(newAccessToken.isNotEmpty){
          await storeTokens(newAccessToken, refreshToken);
           final response = await http.delete(url, headers: {
        'x-api-key': 'apikey@ciao',
        'x-access-token': newAccessToken,
        //'x-refresh-token': '$refreshToken'
      });
      if(response.statusCode==200){
        final jsonResponse = json.decode(response.body);
        final follow = Follow.fromJson(jsonResponse);
        return follow;
      }
        }
      }
    } catch (e) {
      
    }
    return null;
  }

  Future<List<FollowingUser>> getFollowingList() async {
    final url = Uri.parse('${EndPoints.baseUrl}${EndPoints.followinglist}');
    try {
      final accessToken = await getAccessToken();
      final refreshToken = await getRefreshToken();
      final response = await http.get(url, headers: {
        'x-api-key': 'apikey@ciao',
        'x-access-token': '$accessToken',
       // 'x-refresh-token': '$refreshToken'
      });
      log(response.statusCode);
      if (response.statusCode == 200) {
        print('successfully fetched following list');
        final jsonResponse = json.decode(response.body);
        List<dynamic> afterExecutionJson =
            jsonResponse['after execution']['UserData'] ?? [];
        List<FollowingUser> followingList = afterExecutionJson
            .map((data) => FollowingUser.fromJson(data))
            .toList();
        return followingList;
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
        List<dynamic> afterExecutionJson =
            jsonResponse['after execution']['UserData'] ?? [];
        List<FollowingUser> followingList = afterExecutionJson
            .map((data) => FollowingUser.fromJson(data))
            .toList();
        return followingList;
      }else{
        print('failed to fetch');
      }
        }
      }
    } catch (e) {
      print('Error fetching following list: $e');
    }
    return [];
  }

  Future<List<FollowingUser>> getFollowersList() async {
    final url = Uri.parse('${EndPoints.baseUrl}${EndPoints.followerslist}');
    try {
      final accessToken = await getAccessToken();
      final refreshToken = await getRefreshToken();
      final response = await http.get(url, headers: {
        'x-api-key': 'apikey@ciao',
        'x-access-token': '$accessToken',
        //'x-refresh-token': '$refreshToken'
      });
      log(response.statusCode);
      if (response.statusCode == 200) {
        print('successfully fetched following list');
        final jsonResponse = json.decode(response.body);
        List<dynamic> afterExecutionJson =
            jsonResponse['after execution']['UserData'] ?? [];
        List<FollowingUser> followersList = afterExecutionJson
            .map((data) => FollowingUser.fromJson(data))
            .toList();
        return followersList;
      }else if(response.statusCode==400||response.statusCode==401){
        final newAccessToken=await AccessRegenerator().accessRegenerator(accessToken: accessToken!, refreshToken: refreshToken!);
        if(newAccessToken.isNotEmpty){
          await storeTokens(newAccessToken, refreshToken);
           final response = await http.get(url, headers: {
        'x-api-key': 'apikey@ciao',
        'x-access-token': newAccessToken,
        //'x-refresh-token': '$refreshToken'
      });
      if(response.statusCode==200){
         final jsonResponse = json.decode(response.body);
        List<dynamic> afterExecutionJson =
            jsonResponse['after execution']['UserData'] ?? [];
        List<FollowingUser> followersList = afterExecutionJson
            .map((data) => FollowingUser.fromJson(data))
            .toList();
        return followersList;
      }else{
        print('failed to fetch');
      }
        }
      }
    } catch (e) {
      print('Error fetching following list: $e');
    }
    return [];
  }
}
