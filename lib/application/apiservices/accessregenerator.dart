
import 'dart:convert';
import 'dart:developer';
import 'package:socialmedia/application/securestorage/securestorage.dart';
import 'package:socialmedia/application/sharedpreference/sharedpreference.dart';
import 'package:socialmedia/core/endpoints.dart';
import 'package:http/http.dart'as http;
class AccessRegenerator{
  Future<String>accessRegenerator({required String accessToken,required String refreshToken})async{
 try {
      final accessToken = await getAccessToken();
      final refreshToken = await getRefreshToken();
      final url = Uri.parse('${EndPoints.baseUrl}${EndPoints.profileUrl}');
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'x-api-key': 'apikey@ciao',
          'x-access-token': accessToken!,
          'x-refresh-token': '$refreshToken'
        },
      );
      log('😒😒😒😒Status Code: ${response.statusCode}');
      log('😒😒😒😒😒😒Response Body: ${response.body}');
      if (response.statusCode == 200) {
        
        final responseBody=jsonDecode(response.body);
        print(responseBody);
        final newAccessToken=responseBody['after execution']['AccesToken'];
        print('👍👍👍👍$newAccessToken');
        return newAccessToken;
      } else if(response.statusCode==400){
        SharedPreferenceService.getLoginStatus();
      }
    } catch (e) {
    }
    return '';
  }
}
