import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:socialmedia/application/apiservices/accessregenerator.dart';
import 'package:socialmedia/application/models/profilemodel.dart';
import 'package:socialmedia/application/models/usermodel.dart';
import 'package:socialmedia/application/securestorage/securestorage.dart';
import 'package:socialmedia/application/sharedpreference/sharedpreference.dart';
import 'package:socialmedia/core/endpoints.dart';

class SignupService {
  Future<String> createUser(UserModel user) async {
    final url = Uri.parse('${EndPoints.baseUrl}${EndPoints.signupUrl}');
    final body = {
      'name': user.name,
      'username': user.userName,
      'email': user.emailid,
      'password': user.password,
      'confirmpassword': user.confirmPassword
    };
    try {
      final response = await http.post(url,
          headers: {
            'x-api-key': 'apikey@ciao',
            'Content-Type': 'application/json'
          },
          body: jsonEncode(body));
      log('Error:${response.statusCode}');
      log(response.body);
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        final token = jsonResponse['after execution']['Token'] ?? '';
        return token;
      }
    } catch (e) {
      log(e.toString());
    }
    return '';
  }

  Future<bool> otpVerification(String otp, String token) async {
    final url = Uri.parse('${EndPoints.baseUrl}${EndPoints.otpUrl}');
    final body = {'otp': otp};
    try {
      final response = await http.post(url,
          headers: {
            'Content-Type': 'application/json',
            'x-api-key': 'apikey@ciao',
            'x-temp-token': token
          },
          body: jsonEncode(body));
      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      log(e.toString());
    }
    return false;
  }

  Future<bool> login(String email, String password) async {
    final url = Uri.parse('${EndPoints.baseUrl}${EndPoints.loginUrl}');
    final body = {'email': email, 'password': password};
    try {
      final response = await http.post(url,
          headers: {
            'Content-Type': 'application/json',
            'x-api-key': 'apikey@ciao',
          },
          body: jsonEncode(body));
      log(response.body);
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        final accessToken = jsonResponse['after execution']['AccessToken'];
        final refreshToken = jsonResponse['after execution']['RefreshToken'];
        storeTokens(accessToken, refreshToken);
        log(accessToken);
        log(refreshToken);
        await SharedPreferenceService.saveLoginStatus(true);
        return true;
      }
    } catch (e) {
      log('🤦‍♀️🤦‍♀️🤦‍♀️🤦‍♀️${e.toString()}');
    }
    return false;
  }

  Future<String> forgotpassword(String email) async {
    final url = Uri.parse('${EndPoints.baseUrl}${EndPoints.forgotPassworUrl}');
    final body = {'email': email};
    try {
      final response = await http.post(url,
          headers: {
            'Content-Type': 'application/json',
            'x-api-key': 'apikey@ciao',
          },
          body: jsonEncode(body));
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        final token = jsonResponse['after execution']['Token'];
        return token;
      }
    } catch (e) {
      log(e.toString());
    }
    return '';
  }

  Future<void> resetPassword(String otp, String newPassword,
      String confirmNewPassword, String token) async {
    final url = Uri.parse('${EndPoints.baseUrl}${EndPoints.resetPasswordUrl}');
    final body = {
      'otp': otp,
      'password': newPassword,
      'confirmpassword': confirmNewPassword
    };
    try {
      final response = await http.patch(
        url,
        headers: {
          'Content-Type': 'application/json',
          'x-api-key': 'apikey@ciao',
          'x-temp-token': token
        },
        body: jsonEncode(body),
      );
      log('🤦‍♂️🤦‍♂️🤦‍♂️${response.body}');
      log('🤦‍♀️🤦‍♀️🤦‍♀️🤦‍♀️🤦‍♀️🤦‍♀️🤦‍♀️${response.statusCode}');
    } catch (e) {
      log('🤦‍♂️🤦‍♂️🤦‍♂️${e.toString()}');
    }
  }

  Future<ProfileModel?> fetchUser() async {
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
          //'x-refresh-token': '$refreshToken'
        },
      );
      if (response.statusCode == 200) {
        print('${response.statusCode}');
        final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        final ProfileModel details = ProfileModel.fromJson(jsonResponse);
        final userId = details.afterExecution!.id;
        await SharedPreferenceService.saveUserId(userId);
        return details;
      } else if (response.statusCode == 401||response.statusCode==400) {
        final newAccessToken = await AccessRegenerator().accessRegenerator(
            accessToken: accessToken, refreshToken: refreshToken!);
        if (newAccessToken.isNotEmpty) {
          await storeTokens(newAccessToken, refreshToken);

          final response = await http.get(url, headers: {
            'Content-Type': 'application/json',
            'x-api-key': 'apikey@ciao',
            'x-access-token': newAccessToken,
          });
          if (response.statusCode == 200) {
            final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
            final ProfileModel details = ProfileModel.fromJson(jsonResponse);
            final userId = details.afterExecution!.id;
            await SharedPreferenceService.saveUserId(userId);
            return details;
          } else {
            log('🍿🍿🍿🍿failed to fetch ${response.statusCode}');
          }
        } else {
          log('🍿🍿🍿🍿failed to fetch ${response.statusCode}');
        }
      }
    } catch (e) {
      log('👀😒😒😒😒😒error ${e.toString()}');
    }
    return null;
  }
}
