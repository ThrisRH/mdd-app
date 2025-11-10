import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:mddblog/models/author-model.dart';

class AuthorService {
  final String baseUrl = dotenv.env['BASE_URL'] ?? "";

  Future<AuthorResponse> getAuthorInfo() async {
    final url = Uri.parse("$baseUrl/authors?populate=*");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = json.decode(response.body);

      return AuthorResponse.fromJson(jsonData);
    } else {
      throw Exception("Fail to load Author");
    }
  }

  Future<bool> sendContent(String contactEmail) async {
    try {
      final url = Uri.parse("$baseUrl/contacts");
      final response = await http.post(
        url,
        headers: <String, String>{"Content-Type": "application/json"},
        body: jsonEncode({
          "data": {"contactEmail": contactEmail},
        }),
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      throw Exception("Failed to send contact");
    }
  }
}
