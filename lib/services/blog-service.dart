import 'package:dio/dio.dart';
import 'package:mddblog/config/api.dart';
import 'package:mddblog/models/blog-details-model.dart';
import 'package:mddblog/models/blog-model.dart';
import 'package:mddblog/utils/dio-error-handler.dart';
import 'package:mddblog/utils/toast.dart';

class BlogService {
  final dio = Dio();

  Future<BlogResponse> getBlogs({int page = 1, int pageSize = 3}) async {
    await Future.delayed(Duration(milliseconds: 100));

    final url =
        '$baseUrl/blogs?pagination[page]=$page&pagination[pageSize]=$pageSize&populate=*&sort=createdAt:desc';

    try {
      final response = await dio.get(url);
      final Map<String, dynamic> jsonData = response.data;
      return BlogResponse.fromJson(jsonData);
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

  Future<BlogDetailsResponse> getBlogsBySlug(String slug) async {
    final url = '$baseUrl/blogs/by-slug/$slug';

    try {
      final response = await dio.get(url);
      final Map<String, dynamic> jsonData = response.data;
      return BlogDetailsResponse.fromJson(jsonData);
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

  Future<BlogResponse> getBlogsByCate(String cateId, {int page = 1}) async {
    final url =
        '$baseUrl/blogs?filters[cate][documentId][\$eq]=$cateId&populate=cover&pagination[page]=$page&pagination[pageSize]=3&sort=createdAt:desc';

    try {
      final response = await dio.get(url);
      final Map<String, dynamic> jsonData = response.data;
      return BlogResponse.fromJson(jsonData);
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

  Future<BlogResponse> getBlogsByQuery(String query, {int page = 1}) async {
    final url =
        '$baseUrl/blogs/by-title/$query?page=$page&pageSize=3&populate=*';

    try {
      final response = await dio.get(url);
      final Map<String, dynamic> jsonData = response.data;
      return BlogResponse.fromJson(jsonData);
    } on DioException catch (e) {
      handleDioError(e);
      rethrow;
    } catch (e) {
      SnackbarNotification.showError(
        title: "Đã xảy ra lỗi",
        "Vui lòng thử lại sau.",
      );
      throw Exception("Failed to load Blogs");
    }
  }
}
