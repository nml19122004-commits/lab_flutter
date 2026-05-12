import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import '../services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  String? _token;
  String? _role;
  String? _fullName;
  String? _userId;

  String? get token => _token;
  String? get role => _role;
  String? get fullName => _fullName;
  String? get userId => _userId;

  bool get isAuthenticated => _token != null;
  bool get isAdmin => _role == 'Admin';

  final AuthService _authService = AuthService();

  Future<void> loadFromStorage() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token != null && !JwtDecoder.isExpired(token)) {
      _token = token;
      _role = prefs.getString('role');
      _fullName = prefs.getString('fullName');
      _userId = prefs.getString('userId');
      notifyListeners();
    }
  }

  Future<void> login(String email, String password) async {
    final data = await _authService.login(email, password);
    final token = data['token'] as String;
    final role = data['role'] as String;
    final fullName = data['fullName'] as String;

    final decoded = JwtDecoder.decode(token);
    // ASP.NET Core uses the long claim URI or 'sub' for user ID
    final userId = (decoded['sub'] ??
            decoded['nameid'] ??
            decoded[
                'http://schemas.xmlsoap.org/ws/2005/05/identity/claims/nameidentifier'] ??
            '')
        .toString();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
    await prefs.setString('role', role);
    await prefs.setString('fullName', fullName);
    await prefs.setString('userId', userId);

    _token = token;
    _role = role;
    _fullName = fullName;
    _userId = userId;
    notifyListeners();
  }

  Future<void> register(
    String fullName,
    String email,
    String password,
    String role,
  ) async {
    await _authService.register(fullName, email, password, role);
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    _token = null;
    _role = null;
    _fullName = null;
    _userId = null;
    notifyListeners();
  }
}
