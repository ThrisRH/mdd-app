import 'package:dio/dio.dart';
import 'package:mddblog/config/api.dart';
import 'package:mddblog/models/faq-model.dart';
import 'package:mddblog/utils/dio-error-handler.dart';
import 'package:mddblog/utils/toast.dart';

class FaqService {
  final dio = Dio();

  Future<FaqResponse> getFaqs() async {
    final url = '$baseUrl/faq?populate=*';

    try {
      final response = await dio.get(url);
      final body = response.data;
      return FaqResponse.fromJson(body);
    } on DioException catch (e) {
      handleDioError(e);
      rethrow;
    } catch (e) {
      SnackbarNotification.showError(
        title: "Đã xảy ra lỗi",
        (e as dynamic).message,
      );
      rethrow;
    }
  }
}
