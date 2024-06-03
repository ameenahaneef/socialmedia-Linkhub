import 'dart:convert';
import 'dart:developer';
import 'package:socialmedia/application/models/newedit.dart';
import 'package:socialmedia/application/securestorage/securestorage.dart';
import 'package:socialmedia/core/endpoints.dart';
import 'package:http/http.dart' as http;

class EditApi {
  Future<void> editProfile(Profilee profile) async {
    final url = Uri.parse('${EndPoints.baseUrl}${EndPoints.editProfile}');
    try {
      final accessToken = await getAccessToken();
      final refreshToken = await getRefreshToken();
      final response = await http.patch(
        url,
        headers: {
          'x-api-key': 'apikey@ciao',
          'x-access-token': '$accessToken',
          'x-refresh-token': '$refreshToken',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(profile.toJson()),
      );

      if (response.statusCode == 200) {
        log('succefully edited');
      } else if (response.statusCode == 400) {
        final jsonResponse = jsonDecode(response.body);
        final erro = jsonResponse['message'];
        final validerr = jsonResponse['after execution'];
        log('$erro');
         log('$validerr');
      }
    } catch (e) {
      log('$e');
    }
  }
  Future<void>setProfileImage(String img)async{
    final url=Uri.parse('${EndPoints.baseUrl}${EndPoints.setProfile}');
    try {
       final accessToken = await getAccessToken();
      final refreshToken = await getRefreshToken();
      final response = await http.MultipartRequest('POST',url)
       ..headers.addAll(
        {
          'x-api-key': 'apikey@ciao',
          'x-access-token': '$accessToken',
          'x-refresh-token': '$refreshToken',
          'Content-Type': 'multipart/form-data',
        });
        response.files.add(await http.MultipartFile.fromPath('ProfileImg', img));
        final request=await response.send();
      if (request.statusCode == 200) {
        log('😒succefully edited image');
        print('image edited');
      } else{
        print('not edited');
      }
      log('status code is${request.statusCode}');
      
    } catch (e) {
      log(e.toString());
    }
  }
}
