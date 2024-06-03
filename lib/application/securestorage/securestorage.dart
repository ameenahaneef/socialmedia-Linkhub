import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const FlutterSecureStorage _storage = FlutterSecureStorage();

const String accessTokenKey = 'AccessToken';
const String refreshTokenKey = 'RefreshToken';

void storeTokens(String accessToken, String refreshToken) async {
  await _storage.write(key: accessTokenKey, value: accessToken);
  await _storage.write(key: refreshTokenKey, value: refreshToken);
}

Future<String?> getAccessToken() async {
  return await _storage.read(key: accessTokenKey);
}

Future<String?> getRefreshToken() async {
  return await _storage.read(key: refreshTokenKey);
}
