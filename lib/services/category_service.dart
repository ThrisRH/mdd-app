import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:mddblog/models/category_model.dart';

class CategoryService {
  final String baseUrl = dotenv.env['BASE_URL'] ?? "";

  Future<CategoryResponse> getCategories() async {
    final url = Uri.parse('$baseUrl/cates?populate=*');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return CategoryResponse.fromJson(body);
    } else {
      throw Exception("Failed to load Category");
    }
  }
}
