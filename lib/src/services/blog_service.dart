import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:mddblog/src/models/blog_details_model.dart';
import 'package:mddblog/src/models/blog_model.dart';

class BlogService {
  final String baseUrl = dotenv.env['BASE_URL'] ?? "";

  Future<BlogResponse> getBlogs({int page = 1, int pageSize = 3}) async {
    final url = Uri.parse(
      '$baseUrl/blogs?pagination[page]=$page&pagination[pageSize]=$pageSize&populate=*&sort=createdAt:desc',
    );
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = json.decode(response.body);

      return BlogResponse.fromJson(jsonData);
    } else {
      throw Exception("Failed to load About");
    }
  }

  Future<BlogDetailsResponse> getBlogsBySlug(String slug) async {
    final url = Uri.parse('$baseUrl/blogs/by-slug/$slug');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = json.decode(response.body);
      return BlogDetailsResponse.fromJson(jsonData);
    } else {
      throw Exception("Failed to load About");
    }
  }

  Future<BlogResponse> getBlogsByCate(String cateId, {int page = 1}) async {
    final url = Uri.parse(
      '$baseUrl/blogs?filters[cate][documentId][\$eq]=$cateId&populate=cover&pagination[page]=$page&pagination[pageSize]=3&sort=createdAt:desc',
    );
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = json.decode(response.body);
      return BlogResponse.fromJson(jsonData);
    } else {
      throw Exception("Failed to load Blogs");
    }
  }

  Future<BlogResponse> getBlogsByQuery(String query, {int page = 1}) async {
    final url = Uri.parse(
      '$baseUrl/blogs/by-title/$query?page=$page&pageSize=3&populate=*',
    );
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = json.decode(response.body);
      return BlogResponse.fromJson(jsonData);
    } else {
      throw Exception("Failed to load Blogs");
    }
  }
}
