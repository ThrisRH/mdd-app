import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mddblog/src/models/blog_model.dart';
import 'package:mddblog/src/services/blog_service.dart';
import 'package:mddblog/src/widgets/footer/footer.dart';
import 'package:mddblog/src/widgets/header/navbar.dart';
import 'package:mddblog/src/widgets/header/overlay.dart';
import 'package:mddblog/src/widgets/main/PaginationBar.dart';
import 'package:mddblog/src/widgets/post/PostCard.dart';
import 'package:mddblog/theme/app_text_styles.dart';

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

class Category extends GetWidget<BlogByCateController> {
  Category({super.key});

  final RxBool showOverlay = false.obs;

  void toggleOverlay() {
    showOverlay.value = !showOverlay.value;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                // Header Bar
                MDDNavbar(onMenuTap: toggleOverlay),
                SizedBox(height: 32),
                Text(controller.cateName, style: AppTextStyles.h0),

                // Body
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Obx(() {
                    if (controller.isLoading.value) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (controller.blogs.isEmpty) {
                      return Center(child: Text("No blogs found"));
                    }
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: controller.blogs.length,
                      itemBuilder: (context, index) {
                        final blog = controller.blogs[index];
                        return PostCard(
                          blogData: blog,
                          onTap: () => controller.openBlogsDetail(blog.slug),
                        );
                      },
                    );
                  }),
                ),
                // Pagination Area
                Obx(
                  () => PaginationBar(
                    totalPages: controller.totalPages.value,
                    onPageSelected:
                        (page) => {
                          if (page != controller.currentPage.value)
                            {
                              controller.fetchBlogByCate(
                                controller.cateId,
                                page,
                              ),
                            },
                        },
                    currentPage: controller.currentPage.value,
                  ),
                ),

                // Footer
                Footer(),
              ],
            ),
          ),
        ),

        // Show ra Overlay nav điều hướng khi showOverlay === true
        Obx(
          () =>
              showOverlay.value
                  ? OverlayToggle(closeOverlay: toggleOverlay)
                  : SizedBox.shrink(),
        ),
      ],
    );
  }
}
