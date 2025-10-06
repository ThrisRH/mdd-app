import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static const _storage = FlutterSecureStorage();
  static const _biometricKey = 'biometric_enabled';

  static Future<void> saveStrapiToken(String jwt, String refreshToken) async {
    await _storage.write(key: 'access_token', value: jwt);
    await _storage.write(key: 'refresh_token', value: refreshToken);
    await _storage.write(key: 'account_type', value: "Strapi");
  }

  static Future<void> saveTokensOAuth(
    String accessToken,
    String? idToken,
    String name,
    String email,
    String image,
  ) async {
    await _storage.write(key: 'access_token', value: accessToken);
    await _storage.write(key: 'user_name', value: name);
    await _storage.write(key: 'user_email', value: email);
    await _storage.write(key: 'image_url', value: image);
    await _storage.write(key: 'account_type', value: "OAuth");
    if (idToken != null) {
      await _storage.write(key: 'id_token', value: idToken);
    }
  }

  static Future<Map<String, String?>> getTokens() async {
    return {
      'access_token': await _storage.read(key: 'access_token'),
      'refresh_token': await _storage.read(key: 'refresh_token'),
      'id_token': await _storage.read(key: 'id_token'),
      'user_name': await _storage.read(key: 'user_name'),
      'user_email': await _storage.read(key: 'user_email'),
      'image_url': await _storage.read(key: 'image_url'),
      'account_type': await _storage.read(key: 'account_type'),
    };
  }

  static Future<String?> getRefreshToken() async {
    return await _storage.read(key: 'refresh_token');
  }

  static Future<bool> hasToken() async {
    final token = await _storage.read(key: 'access_token');
    return token != null && token.isNotEmpty;
  }

  static Future<void> clearTokens() async {
    await _storage.delete(key: 'access_token');
    await _storage.delete(key: 'id_token');
  }

  static Future<void> setBiometricEnabled(bool enabled) async {
    await _storage.write(key: 'biometric_enabled', value: enabled.toString());
  }

  static Future<bool> getBiometricEnabled() async {
    final val = await _storage.read(key: 'biometric_enabled');
    return val == 'true';
  }
}
