import 'package:get/get.dart';
import 'package:mddblog/models/author-model.dart';
import 'package:mddblog/models/blog-model.dart';
import 'package:mddblog/services/author-service.dart';
import 'package:mddblog/services/blog-service.dart';

class AuthorController extends GetxController {
  final AuthorService _authorService = AuthorService();
  final BlogService _blogService = BlogService();

  var authorInfo = Rxn<AuthorInfo>();
  var favoriteBlogs = <BlogData>[].obs;
  var isLoading = true.obs;
  var errorMessage = "".obs;
  @override
  void onInit() {
    super.onInit();
    fetchAuthorData();
    fetchFavorites();
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

  // Fetch cho trang cá nhân (6 blogs/trang)
  void fetchFavorites() async {
    try {
      isLoading.value = true;
      final response = await _blogService.getBlogs(page: 1, pageSize: 6);
      favoriteBlogs.assignAll(response.data);
    } catch (e) {
      errorMessage.value = "Không thể lấy dữ liệu";
    } finally {
      isLoading.value = false;
    }
  }

  void toAuthorPage() {
    Get.toNamed('/author');
  }
}
