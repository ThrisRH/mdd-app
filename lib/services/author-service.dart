import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:mddblog/config/api.dart';
import 'package:mddblog/models/author-model.dart';
import 'package:mddblog/utils/dio-error-handler.dart';
import 'package:mddblog/utils/toast.dart';

class AuthorService {
  final dio = Dio();

  Future<AuthorResponse> getAuthorInfo() async {
    final url = "$baseUrl/authors?populate=*";

    try {
      final response = await dio.get(url);
      final Map<String, dynamic> jsonData = response.data;
      return AuthorResponse.fromJson(jsonData);
    } on DioException catch (e) {
      handleDioError(e);
      rethrow;
    } catch (e) {
      SnackbarNotification.showError(
        title: "Đã xảy ra lỗi",
        "Vui lòng thử lại sau.",
      );
      rethrow;
    }
  }

  Future<bool> sendContent(String contactEmail) async {
    try {
      final url = "$baseUrl/contacts";
      await dio.post(
        url,
        options: Options(
          headers: {'Content-Type': 'application/json; charset=UTF-8'},
        ),
        data: jsonEncode({
          "data": {"contactEmail": contactEmail},
        }),
      );
      return true;
    } on DioException catch (e) {
      handleDioError(e);
      return false;
    } catch (e) {
      SnackbarNotification.showError(
        title: "Đã xảy ra lỗi",
        (e as dynamic).message,
      );
      return false;
    }
  }
}
