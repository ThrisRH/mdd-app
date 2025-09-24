import 'package:get/get.dart';
import 'package:mddblog/src/models/blog_model.dart';
import 'package:mddblog/src/services/blog_service.dart';

class BlogByCateController extends GetxController {
  final BlogService _blogService = BlogService();

  var blogs = <BlogData>[].obs;
  var isLoading = true.obs;
  var currentPage = RxInt(1);
  var totalPages = 1.obs;
  late String cateId, cateName;

  @override
  void onInit() {
    super.onInit();
    cateId = Get.arguments['id'] as String;
    cateName = Get.arguments['name'] as String;
    Future.delayed(Duration(seconds: 1), () {
      fetchBlogByCate(cateId, currentPage.value);
    });
  }

  // Fetch blog theo CateId
  void fetchBlogByCate(String cateId, int page) async {
    try {
      isLoading.value = true;
      currentPage.value = page;
      final response = await _blogService.getBlogsByCate(
        cateId,
        page: currentPage.value,
      );
      totalPages.value = response.meta.pagination.pageCount;
      blogs.assignAll(response.data);
    } catch (error) {
      Get.snackbar("Error", error.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void openBlogsDetail(String slug) {
    Get.toNamed('/home/$slug', arguments: {'slug': slug});
  }
}
