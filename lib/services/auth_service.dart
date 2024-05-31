import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:chat_flutter_app/models/models.dart';
import 'package:chat_flutter_app/globals/environment.dart';

class AuthService with ChangeNotifier {
  late User user;
  bool _authenticating = false;

  // ignore: prefer_const_constructors
  final _storage = FlutterSecureStorage();

  bool get authenticating => _authenticating;
  set authenticating(bool value) {
    _authenticating = value;
    notifyListeners();
  }

  static Future<String?> getToken() async {
    // ignore: prefer_const_constructors, no_leading_underscores_for_local_identifiers
    final _storage = FlutterSecureStorage();
    final token = await _storage.read(key: 'token');

    return token;
  }

  static Future<void> deleteToken() async {
    // ignore: prefer_const_constructors, no_leading_underscores_for_local_identifiers
    final _storage = FlutterSecureStorage();
    await _storage.delete(key: 'token');
  }

  Future<bool> login(String email, String password) async {
    authenticating = true;

    final data = {
      'email': email,
      'password': password,
    };

    final resp = await http.post(
      Uri.parse('${Environments.apiUrl}/login'),
      body: jsonEncode(data),
      headers: {'Content-Type': 'application/json'},
    );

    authenticating = false;

    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      user = loginResponse.user;

      await _addToken(loginResponse.token);

      return true;
    } else {
      return false;
    }
  }

  Future register(String name, String email, String password) async {
    final data = {
      'name': name,
      'email': email,
      'password': password,
    };

    final resp = await http.post(
      Uri.parse('${Environments.apiUrl}/login/new'),
      body: jsonEncode(data),
      headers: {'Content-Type': 'application/json'},
    );

    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      user = loginResponse.user;

      await _addToken(loginResponse.token);

      return true;
    } else {
      final respOk = jsonDecode(resp.body);
      return respOk['msg'];
    }
  }

  Future<bool> isLoggedIn() async {
    try {
      final token = await _storage.read(key: 'token');

      if (token == null) {
        return false;
      } else {
        final resp = await http.get(
          Uri.parse('${Environments.apiUrl}/login/renew'),
          headers: {
            'Content-Type': 'application/json',
            'x-token': token,
          },
        );

        if (resp.statusCode == 200) {
          final loginResponse = loginResponseFromJson(resp.body);
          user = loginResponse.user;

          await _addToken(loginResponse.token);

          return true;
        } else {
          logout();
          return false;
        }
      }
    } catch (error) {
      return false;
    }
  }

  Future _addToken(String token) async {
    await _storage.write(key: 'token', value: token);
  }

  Future logout() async {
    await _storage.delete(key: 'token');
  }
}
