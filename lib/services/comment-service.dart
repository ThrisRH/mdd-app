import 'package:dio/dio.dart';
import 'package:mddblog/config/api.dart';
import 'package:mddblog/models/comment-model.dart';
import 'package:mddblog/utils/dio-error-handler.dart';
import 'package:mddblog/utils/toast.dart';

class CommentService {
  final dio = Dio();
  Future<CommentResponse> getComment(String blogId) async {
    final url =
        '$baseUrl/comments?filters[blog][documentId][\$eq]=$blogId&populate[reader][populate]=avatar';

    try {
      final response = await dio.get(url);
      final Map<String, dynamic> jsonData = response.data;
      return CommentResponse.fromJson(jsonData);
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

  Future<bool> sendComment(
    String readerId,
    String comment,
    String blogId,
  ) async {
    final url = '$baseUrl/comments';
    try {
      await dio.post(
        url,
        options: Options(
          headers: {'Content-Type': 'application/json; charset=UTF-8'},
        ),
        data: {
          'data': {'reader': readerId, 'content': comment, 'blog': blogId},
        },
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
