import 'package:get/get.dart';
import 'package:mddblog/models/blog-model.dart';
import 'package:mddblog/services/blog-service.dart';
import 'package:mddblog/src/screens/blog-details/index.dart';

class BlogController extends GetxController {
  final BlogService _blogService = BlogService();

  var blogs = <BlogData>[].obs;
  var errorMessage = "".obs;

  var isLoading = true.obs;
  var currentPage = RxInt(1);
  var totalPages = 1.obs;

  @override
  void onInit() {
    super.onInit();

    fetchPage(currentPage.value);
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
      errorMessage.value = "Lấy nội dung thất bại!";
    } finally {
      isLoading.value = false;
    }
  }

  void openBlogsDetail(String slug) {
    Get.delete<BlogDetailsController>();
    Get.toNamed('/home/detail/$slug', arguments: {'slug': slug});
  }
}
