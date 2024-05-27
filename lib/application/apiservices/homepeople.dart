import 'dart:convert';
import 'dart:developer';

import 'package:socialmedia/application/models/homepost.dart';
import 'package:socialmedia/application/securestorage/securestorage.dart';
import 'package:socialmedia/core/endpoints.dart';
import 'package:http/http.dart'as http;

class HomeService{
  Future<List<PostData?>>fetchHomeDetails()async{
    
final url=Uri.parse('${EndPoints.baseUrl}${EndPoints.homepost}');
 try {
      final accessToken = await getAccessToken();
      final refreshToken = await getRefreshToken();
      final response = await http.get(url, headers: {
        'x-api-key': 'apikey@ciao',
        'x-access-token': '$accessToken',
        'x-refresh-token': '$refreshToken'
      });
      print('ameenanadheem');
      
      if (response.statusCode == 200) {
        log('😂😂😂😂${response.body}');
        print('😊😊😊😊😊${response.body}');
        final jsonResponse = json.decode(response.body);
        final List<dynamic> postData = jsonResponse['after execution']['PostsData'];
        if (postData.isEmpty) {
         
          return [];
        }
        final List<PostData> post =
            postData.map((postJson) => PostData.fromJson(postJson)).toList();
        return post;
      } else {
        log('failed to fetch ${response.statusCode}');
      }
    } catch (e) {
      print('😶‍🌫️oooooo');
      log(e.toString());
    }
  return [];
}
  }
