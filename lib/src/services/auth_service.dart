import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class AuthenticationService {
  final String baseUrl = dotenv.env['BASE_URL'] ?? "";

  Future<void> signIn(String identifier, String password) async {
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
      final user = data['user'];
      print("JWT: $jwt");
      print("User: $user");
    } else {
      print("Login failed: ${response.body}");
    }
  }
}
