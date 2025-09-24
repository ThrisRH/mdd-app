import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:mddblog/src/models/comment_model.dart';

class CommentService {
  final String baseUrl = dotenv.env['BASE_URL'] ?? "";

  Future<CommentResponse> getComment(String blogId) async {
    final url = Uri.parse(
      '$baseUrl/comments?filters[blog][documentId][\$eq]=$blogId&populate[reader][populate]=avatar',
    );
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = json.decode(response.body);

      return CommentResponse.fromJson(jsonData);
    } else {
      throw Exception("Failed to load comments");
    }
  }

  Future<bool> sendComment(
    String readerId,
    String comment,
    String blogId,
  ) async {
    final url = Uri.parse('$baseUrl/comments');
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'data': {'reader': readerId, 'content': comment, 'blog': blogId},
      }),
    );

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return true;
    } else {
      return false;
    }
  }
}
