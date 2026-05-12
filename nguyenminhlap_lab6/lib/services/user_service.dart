import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';

class UserService {
  static const String baseUrl = 'http://10.0.2.2:5133';

  Map<String, String> _headers(String token) => {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token',
  };

  Future<List<UserModel>> getUsers(String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/api/users'),
      headers: _headers(token),
    );
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((e) => UserModel.fromJson(e)).toList();
    }
    throw Exception('Failed to load users (${response.statusCode})');
  }

  Future<UserModel> getUserById(String id, String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/api/users/$id'),
      headers: _headers(token),
    );
    if (response.statusCode == 200) {
      return UserModel.fromJson(jsonDecode(response.body));
    }
    throw Exception('Failed to load user (${response.statusCode})');
  }

  Future<void> updateUser(
    String id,
    String fullName,
    String email,
    String token,
  ) async {
    final response = await http.put(
      Uri.parse('$baseUrl/api/users/$id'),
      headers: _headers(token),
      body: jsonEncode({'fullName': fullName, 'email': email}),
    );
    if (response.statusCode != 200 && response.statusCode != 204) {
      throw Exception('Failed to update user (${response.statusCode})');
    }
  }

  Future<void> deleteUser(String id, String token) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/api/users/$id'),
      headers: _headers(token),
    );
    if (response.statusCode != 200 && response.statusCode != 204) {
      throw Exception('Failed to delete user (${response.statusCode})');
    }
  }

  Future<void> assignRole(String id, String role, String token) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/users/$id/role'),
      headers: _headers(token),
      body: jsonEncode({'role': role}),
    );
    if (response.statusCode != 200 && response.statusCode != 204) {
      throw Exception('Failed to assign role (${response.statusCode})');
    }
  }
}
