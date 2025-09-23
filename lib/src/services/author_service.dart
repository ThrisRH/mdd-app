import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:mddblog/src/models/author_model.dart';

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
}
