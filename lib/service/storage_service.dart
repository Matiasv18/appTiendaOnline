import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static const _tokenKey = 'auth_token';

  Future<String?> getToken() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getString(_tokenKey);
  }

  Future<void> saveToken(String token) async {
    final preferences = await SharedPreferences.getInstance();
    final saved = await preferences.setString(_tokenKey, token);
    if (!saved) {
      throw StateError('No se pudo guardar el token de autenticación.');
    }
  }

  Future<void> removeToken() async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.remove(_tokenKey);
  }
}