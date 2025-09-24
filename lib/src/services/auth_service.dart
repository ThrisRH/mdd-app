import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveJwt(String jwt) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('jwtToken', jwt);
}

Future<String?> loadJwt() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('jwtToken');
}

Future<void> removeJwt() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('jwtToken');
}

class AuthenticationService {
  final String baseUrl = dotenv.env['BASE_URL'] ?? "";

  static Future<bool> isLoggedIn() async {
    // Lấy token từ SharedPreferences
    final token = await loadJwt();
    return token != null;
  }

  Future<bool> signIn(String identifier, String password) async {
    final url = Uri.parse("$baseUrl/auth/local");
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'identifier': identifier,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final jwt = data['jwt'];
      await saveJwt(jwt);
      return true;
    } else {
      return false;
    }
  }

  Future<bool> signUp(String username, String email, String password) async {
    final url = Uri.parse("$baseUrl/auth/local/register");
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
