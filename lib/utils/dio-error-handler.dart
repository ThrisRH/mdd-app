import 'package:dio/dio.dart';
import 'package:mddblog/utils/toast.dart';

void handleDioError(DioException e) {
  // Nếu server có trả về response
  if (e.response != null) {
    final status = e.response!.statusCode;

    switch (status) {
      case 400:
        SnackbarNotification.showError(
          "Lỗi khi lấy dữ liệu, thử lại sau!",
          title: "Lỗi dữ liệu",
        );
        break;

      case 401:
        SnackbarNotification.showError(
          "Bạn chưa đăng nhập!",
          title: "Không được phép",
        );
        break;

      case 403:
        SnackbarNotification.showError(
          "Bạn không có quyền truy cập vào trang này!",
          title: "Truy cập bị cấm",
        );
        break;

      default:
        SnackbarNotification.showError(
          "Đã xảy ra lỗi, thử lại sau!",
          title: "Lỗi server",
        );
    }

    return;
  }

  // Nếu không có response → lỗi về mạng / timeout
  switch (e.type) {
    case DioExceptionType.connectionTimeout:
    case DioExceptionType.receiveTimeout:
    case DioExceptionType.sendTimeout:
      SnackbarNotification.showError(
        "Vui lòng thử lại sau!",
        title: "Lỗi kết nối",
      );
      break;

    case DioExceptionType.connectionError:
    case DioExceptionType.unknown:
      SnackbarNotification.showError(
        "Vui lòng kiểm tra lại kết nối!",
        title: "Lỗi mạng",
      );
      break;

    case DioExceptionType.badCertificate:
      SnackbarNotification.showError(
        "Chứng chỉ máy chủ không hợp lệ!",
        title: "Lỗi bảo mật",
      );
      break;

    case DioExceptionType.cancel:
      break;

    case DioExceptionType.badResponse:
      SnackbarNotification.showError(
        "Server trả dữ liệu không hợp lệ",
        title: "Lỗi server",
      );
      break;
  }
}
