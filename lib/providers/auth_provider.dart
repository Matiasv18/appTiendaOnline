import 'package:flutter/material.dart';
import '../models/user.dart';
import '../service/api_service.dart';
import '../service/storage_service.dart';

class AuthProvider with ChangeNotifier {
  User? _user;
  bool _isLoading = false;

  User? get user => _user;
  bool get isLoading => _isLoading;
  bool get isAuthenticated => _user != null;

  final ApiService _apiService = ApiService();
  final StorageService _storageService = StorageService();

  Future<void> tryAutoLogin() async {
    final token = await _storageService.getToken();
    if (token == null) return;
    try {
      _user = await _apiService.getUserProfile(token);
      notifyListeners();
    } catch (e) {
      await logout();
    }
  }

  Future<bool> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();
    try {
      final data = await _apiService.login(email, password);
      _user = User.fromJson(data['user']);
      await _storageService.saveToken(data['token']);
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> register(String name, String email, String password) async {
    _isLoading = true;
    notifyListeners();
    try {
      await _apiService.register(name, email, password);
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<void> logout() async {
    _user = null;
    await _storageService.removeToken();
    notifyListeners();
  }
}
