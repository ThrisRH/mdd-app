import 'package:dio/dio.dart';
import 'package:mddblog/config/api.dart';
import 'package:mddblog/models/category-model.dart';
import 'package:mddblog/utils/dio-error-handler.dart';
import 'package:mddblog/utils/toast.dart';

class CategoryService {
  final dio = Dio();
  Future<CategoryResponse> getCategories() async {
    final url = '$baseUrl/cates?populate=*';
    try {
      final response = await dio.get(url);
      final body = response.data;
      return CategoryResponse.fromJson(body);
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
}
