import 'package:get/get.dart';
import 'package:mddblog/models/author_model.dart';
import 'package:mddblog/services/author_service.dart';

class AuthorController extends GetxController {
  final AuthorService _authorService = AuthorService();

  var authorInfo = Rxn<AuthorInfo>();
  var isLoading = true.obs;
  var errorMessage = "".obs;
  @override
  void onInit() {
    super.onInit();
    Future.delayed(Duration(seconds: 1), () {
      fetchAuthorData();
    });
  }

  void fetchAuthorData() async {
    try {
      isLoading.value = true;
      final response = await _authorService.getAuthorInfo();
      authorInfo.value = response.data.first;
    } catch (error) {
      errorMessage.value = "Lỗi kết nối, vui lòng kiểm tra lại đường truyền!";
    } finally {
      isLoading.value = false;
    }
  }

  void toAuthorPage() {
    Get.toNamed('/author');
  }
}
