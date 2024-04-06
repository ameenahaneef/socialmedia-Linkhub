import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceService {
  static Future<void> saveLoginStatus(bool status) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool('isLoggedIn', status);
  }

  static Future<bool> getLoginStatus() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool('isLoggedIn') ?? false;
  }

  static Future<void> deleteLoginStatus() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove('isLoggedIn');
  }
}
