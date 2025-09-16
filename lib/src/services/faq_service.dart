import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:mddblog/src/models/faq_model.dart';

class FaqService {
  final String baseUrl = dotenv.env['BASE_URL'] ?? "";

  Future<FaqResponse> getFaqs() async {
    final url = Uri.parse('$baseUrl/faq?populate=*');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      print("body: $body");

      return FaqResponse.fromJson(body);
    } else {
      throw Exception("Failed to load FAQ");
    }
  }
}
