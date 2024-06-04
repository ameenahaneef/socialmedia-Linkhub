import 'dart:convert';
import 'dart:developer';
import 'package:socialmedia/application/apiservices/accessregenerator.dart';
import 'package:socialmedia/application/models/commentmodel.dart';
import 'package:socialmedia/application/securestorage/securestorage.dart';
import 'package:socialmedia/core/endpoints.dart';
import 'package:http/http.dart' as http;

class CommentService {
  Future<void> addComment(int postId, String comment) async {
    print('function gets called');
    final url = Uri.parse('${EndPoints.baseUrl}${EndPoints.addComment}');
    try {
      final accessToken = await getAccessToken();
      final refreshToken = await getRefreshToken();
      final response = await http.post(url,
          headers: {
            'x-api-key': 'apikey@ciao',
            'x-access-token': '$accessToken',
            // 'x-refresh-token': '$refreshToken',
            'Content-Type': 'application/json'
          },
          body: json.encode({'PostID': postId, 'CommentText': comment}));
      print('${response.body}');
      if (response.statusCode == 200) {
        print('comment added successfully');
      } else if (response.statusCode == 400 || response.statusCode == 401) {
        final newAccessToken = await AccessRegenerator().accessRegenerator(
            accessToken: accessToken!, refreshToken: refreshToken!);
        if (newAccessToken.isNotEmpty) {
          await storeTokens(accessToken, refreshToken);
          final response = await http.post(url,
              headers: {
                'x-api-key': 'apikey@ciao',
                'x-access-token': newAccessToken,
                // 'x-refresh-token': '$refreshToken',
                'Content-Type': 'application/json'
              },
              body: json.encode({'PostID': postId, 'CommentText': comment}));
          if (response.statusCode == 200) {
            print('comment edited successfully');
          } else {
            print('failed to edit comment');
          }
        }
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<CommentModel> getAllComments(int postId) async {
    log('getAllComments function gets called');
    final url = Uri.parse('${EndPoints.baseUrl}${EndPoints.getComment}$postId');
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
      log('Response status code: ${response.statusCode}');
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBody = json.decode(response.body);
        final CommentModel commentModel = CommentModel.fromJson(responseBody);
        return commentModel;
      } else if (response.statusCode == 400 || response.statusCode == 401) {
        final newAccessToken = await AccessRegenerator().accessRegenerator(
            accessToken: accessToken!, refreshToken: refreshToken!);
        if (newAccessToken.isNotEmpty) {
          await storeTokens(newAccessToken, refreshToken);
          final response = await http.get(
            url,
            headers: {
              'x-api-key': 'apikey@ciao',
              'x-access-token': newAccessToken,
              // 'x-refresh-token': '$refreshToken',
              'Content-Type': 'application/json',
            },
          );
          if (response.statusCode == 200) {
            final Map<String, dynamic> responseBody =
                json.decode(response.body);
            final CommentModel commentModel =
                CommentModel.fromJson(responseBody);
            return commentModel;
          }
        }
      }

      log('Failed to fetch comments');
      throw Exception('failed ti fetch comments');
    } catch (e) {
      log(e.toString());
      throw Exception('failed to fetch comments');
    }
  }

  Future<void> deleteComment(int commentId) async {
    log('delete comment gets called');
    final url =
        Uri.parse('${EndPoints.baseUrl}${EndPoints.getComment}$commentId');
    try {
      final accessToken = await getAccessToken();
      final refreshToken = await getRefreshToken();
      final response = await http.delete(
        url,
        headers: {
          'x-api-key': 'apikey@ciao',
          'x-access-token': '$accessToken',
          //'x-refresh-token': '$refreshToken',
          'Content-Type': 'application/json',
        },
      );
      log(response.body);
      log('${response.statusCode}');
      if (response.statusCode == 200) {
        log('comment deleted successfully');
      } else if (response.statusCode == 400 || response.statusCode == 401) {
        final newAccessToken = await AccessRegenerator().accessRegenerator(
            accessToken: accessToken!, refreshToken: refreshToken!);
        if (newAccessToken.isNotEmpty) {
          await storeTokens(newAccessToken, refreshToken);
          final response = await http.delete(
            url,
            headers: {
              'x-api-key': 'apikey@ciao',
              'x-access-token': newAccessToken,
              //'x-refresh-token': '$refreshToken',
              'Content-Type': 'application/json',
            },
          );
          if (response.statusCode == 200) {
            log('comment deleted successfully');
          }
        }
      } else {
        log('failed to dlete');
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> editComment(int commentId, String commentText) async {
    final url = Uri.parse('${EndPoints.baseUrl}${EndPoints.getComment}');
    try {
      final accessToken = await getAccessToken();
      final refreshToken = await getRefreshToken();
      final response = await http.patch(url,
          headers: {
            'x-api-key': 'apikey@ciao',
            'x-access-token': '$accessToken',
            //'x-refresh-token': '$refreshToken',
            'Content-Type': 'application/json',
          },
          body:
              jsonEncode({'CommentId': commentId, 'CommentText': commentText}));
      log(response.body);
      if (response.statusCode == 200) {
        print('edited successfully');
      } else if (response.statusCode == 400 || response.statusCode == 401) {
        final newAccessToken = await AccessRegenerator().accessRegenerator(
            accessToken: accessToken!, refreshToken: refreshToken!);
        if (newAccessToken.isNotEmpty) {
          await storeTokens(newAccessToken, refreshToken);
          final response = await http.patch(url,
              headers: {
                'x-api-key': 'apikey@ciao',
                'x-access-token': newAccessToken,
                //'x-refresh-token': '$refreshToken',
                'Content-Type': 'application/json',
              },
              body: jsonEncode(
                  {'CommentId': commentId, 'CommentText': commentText}));
          if (response.statusCode == 200) {
            log('edited successfully');
          }
        }
      } else {
        log('not edited');
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
