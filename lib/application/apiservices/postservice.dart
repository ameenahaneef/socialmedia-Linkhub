import 'dart:convert';
import 'dart:developer';
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
      response.headers['x-refresh-token'] = refreshToken;

      response.fields['caption'] = caption;

      for (int i = 0; i < mediaUrls.length; i++) {
        var mediaUrl = mediaUrls[i];
        response.files
            .add(await http.MultipartFile.fromPath('media', mediaUrl));
      }

      final res = await response.send();

      if (res.statusCode == 200) {
        log('image uploaded succefully');
      } else {
        log('failed to upload image.statuscode:${res.statusCode}');
      }
    } catch (e) {
      log('error posting image:${e.toString()}');
    }
  }

  Future<List<AfterExecution>> postFetch() async {
    try {
      final accessToken = await getAccessToken();
      final refreshToken = await getRefreshToken();
      log(accessToken!);
      log(refreshToken!);

      final url = Uri.parse('${EndPoints.baseUrl}${EndPoints.postAddUrl}');
      final response = await http.get(
        url,
        headers: {
          'x-api-key': 'apikey@ciao',
          'x-access-token': accessToken,
          'x-refresh-token': refreshToken
        },
      );
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final List<dynamic> postData = jsonResponse['after execution'];
        if (postData.isEmpty) {
          log('nothing is available');
          return [];
        }
        final List<AfterExecution> post = postData
            .map((postJson) => AfterExecution.fromJson(postJson))
            .toList();

        log('❤️❤️❤️❤️${response.body}');
        print('👀👀👀👀👀👀$post');

        return post;
      } else {
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

      final url = Uri.parse('${EndPoints.baseUrl}${EndPoints.postAddUrl}');
      final body = {"postid": postid};
      final response = await http.delete(url,
          headers: {
            'Content-Type': 'application/json',
            'x-api-key': 'apikey@ciao',
            'x-access-token': '$accessToken',
            'x-refresh-token': '$refreshToken'
          },
          body: jsonEncode(body));

      log(response.body);
    } catch (e) {
      log(e.toString());
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
            'x-refresh-token': '$refreshToken'
          },
          body: jsonEncode(body));

      log(response.body);
    } catch (e) {
      log(e.toString());
    }
  }
}
