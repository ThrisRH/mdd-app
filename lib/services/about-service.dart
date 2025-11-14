import 'package:dio/dio.dart';
import 'package:mddblog/config/api.dart';
import 'package:mddblog/models/about-model.dart';
import 'package:mddblog/utils/dio-error-handler.dart';
import 'package:mddblog/utils/toast.dart';

class AboutService {
  final dio = Dio();

  Future<AboutResponse> getAbout() async {
    final url = '$baseUrl/about?populate=*';

    try {
      final response = await dio.get(url);

      final Map<String, dynamic> jsonData = response.data;
      return AboutResponse.fromJson(jsonData);
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
