import 'dart:convert';
import 'package:cart_app/features/authentication/data/model/user_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageService {
  static final _storage = FlutterSecureStorage(
    
  );

  static const _accessTokenKey = 'access_token';
  static const _userKey = "user_data";

  /// Save access token and user data securely
  static Future<void> saveTokenAndUserData(UserModel data) async {
    await _storage.write(key: _accessTokenKey, value: data.token);
    await _storage.write(key: _userKey, value: jsonEncode(data.toJson()));
  }

  /// Retrieve user data securely
   Future<UserModel?> getUserData() async {
    String? userDataString = await _storage.read(key: _userKey);
    if (userDataString != null) {
      return UserModel.fromJson(jsonDecode(userDataString));
    }
    return null;
  }

  /// Retrieve access token securely
  static Future<String?> getAccessToken() async {
    return await _storage.read(key: _accessTokenKey);
  }

  /// Clear stored user data and token
  static Future<void> clearUserData() async {
    await _storage.delete(key: _accessTokenKey);
    await _storage.delete(key: _userKey);
  }
}
