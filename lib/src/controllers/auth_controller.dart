import 'package:get/get.dart';
import 'package:mddblog/src/services/auth_service.dart';
import 'package:mddblog/theme/app_colors.dart';

class AuthController extends GetxController {
  var isLoggedIn = false.obs;
  var errorMessage = "".obs;

  final AuthenticationService _authenticationService = AuthenticationService();

  @override
  void onInit() {
    super.onInit();
    _loadToken();
  }

  void _loadToken() async {
    final token = await loadJwt();
    isLoggedIn.value = token != null;
  }

  Future<void> signIn(String id, String pw) async {
    // id = identifier
    if (id == "" || pw == "") {
      errorMessage.value = "Không được để trống!";
      return;
    }
    final response = await _authenticationService.signIn(id, pw);
    if (!response) {
      errorMessage.value = "Tên đăng nhập hoặc mật khẩu không đúng!";
      return;
    }
    final token = await loadJwt();
    isLoggedIn.value = token != null;
    Get.snackbar(
      "Success",
      "Login thành công",
      backgroundColor: AppColors.primary,
    );
    Get.offNamed("/home");
  }

  Future<void> signUp(String username, String email, String pw) async {
    if (username == "" || email == "" || pw == "") {
      errorMessage.value = "Không được để trống!";
      return;
    }
    final response = await _authenticationService.signUp(username, email, pw);
    if (!response) {
      errorMessage.value = "Tên đăng nhập hoặc email không phù hợp";
      return;
    }
    final token = await loadJwt();
    isLoggedIn.value = token != null;
    Get.snackbar(
      "Success",
      "Đăng ký thành công thành công",
      backgroundColor: AppColors.primary,
    );
    Get.offNamed("/login");
  }

  Future<void> logout() async {
    await removeJwt();
    isLoggedIn.value = false;
    Get.offNamed("/home");
  }

  // Routing
  void toRegister() {
    Get.delete<AuthController>();
    Get.toNamed("/register");
  }

  void toSignIn() {
    Get.delete<AuthController>();
    Get.toNamed("/login");
  }
}
