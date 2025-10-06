import 'package:get/get.dart';
import 'package:mddblog/models/blog_model.dart';
import 'package:mddblog/services/blog_service.dart';
import 'package:mddblog/src/views/blog_details/blog_details.dart';

class BlogController extends GetxController {
  final BlogService _blogService = BlogService();

  var blogs = <BlogData>[].obs;
  var favoriteBlogs = <BlogData>[].obs; // Cho bảng favorite trong trang cá nhân
  var errorMessage = "".obs;

  var isLoading = true.obs;
  var currentPage = RxInt(1);
  var totalPages = 1.obs;

  @override
  void onInit() {
    super.onInit();

    Future.delayed(Duration(seconds: 1), () {
      fetchPage(currentPage.value);
      fetchFavorites();
    });
  }

  // Fetch toàn bộ blogs ( 3 blogs/trang )
  void fetchPage(int page) async {
    try {
      isLoading.value = true;
      currentPage.value = page;

      final response = await _blogService.getBlogs(page: currentPage.value);

      totalPages.value = response.meta.pagination.pageCount;
      blogs.assignAll(response.data);
      errorMessage.value = "";
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
    } finally {
      isLoading.value = false;
    }
  }

  void openBlogsDetail(String slug) {
    Get.delete<BlogDetailsController>();
    Get.toNamed('/home/$slug', arguments: {'slug': slug});
  }
}
