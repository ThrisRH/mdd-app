import 'package:get/get.dart';
import 'package:mddblog/src/models/author_model.dart';
import 'package:mddblog/src/services/author_service.dart';

class AuthorController extends GetxController {
  final AuthorService _authorService = AuthorService();

  var authorInfo = Rxn<AuthorInfo>();
  var isLoading = true.obs;

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
      Get.snackbar("Error", error.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void toAuthorPage() {
    Get.toNamed('/author');
  }
}
