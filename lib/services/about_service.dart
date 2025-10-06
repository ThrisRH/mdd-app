import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:mddblog/models/about_model.dart';

class AboutService {
  final String baseUrl = dotenv.env['BASE_URL'] ?? "";

  Future<AboutResponse> getAbout() async {
    final url = Uri.parse('$baseUrl/about?populate=*');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = json.decode(response.body);

      return AboutResponse.fromJson(jsonData);
    } else {
      throw Exception("Failed to load About");
    }
  }
}
