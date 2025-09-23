import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mddblog/src/models/blog_model.dart';
import 'package:mddblog/src/services/blog_service.dart';
import 'package:mddblog/src/widgets/footer/footer.dart';
import 'package:mddblog/src/widgets/header/navbar.dart';
import 'package:mddblog/src/widgets/header/overlay.dart';
import 'package:mddblog/src/widgets/main/Error.dart';
import 'package:mddblog/src/widgets/main/Loading.dart';
import 'package:mddblog/src/widgets/main/PaginationBar.dart';
import 'package:mddblog/src/widgets/post/PostCard.dart';
import 'package:mddblog/theme/app_text_styles.dart';

class BlogBySearchQueryController extends GetxController {
  final BlogService _blogService = BlogService();

  var blogs = <BlogData>[].obs;
  var isLoading = true.obs;
  var currentPage = RxInt(1);
  var totalPages = 1.obs;
  late String query;

  @override
  void onInit() {
    super.onInit();
    query = Get.arguments['query'] as String;
    fetchBlogByCate(query, currentPage.value);
  }

  // Fetch blog theo CateId
  void fetchBlogByCate(String query, int page) async {
    try {
      isLoading.value = true;
      currentPage.value = page;
      final response = await _blogService.getBlogsByQuery(
        query,
        page: currentPage.value,
      );
      totalPages.value = response.meta.pagination.pageCount;
      blogs.assignAll(response.data);
    } catch (error) {
      return;
    } finally {
      isLoading.value = false;
    }
  }

  void openBlogsDetail(String slug) {
    Get.toNamed('/home/$slug', arguments: {'slug': slug});
  }
}

class BlogBySearchQueryPage extends GetWidget<BlogBySearchQueryController> {
  BlogBySearchQueryPage({super.key});

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

                // Body
                Obx(() {
                  if (controller.isLoading.value) {
                    return Center(child: Loading());
                  }
                  if (controller.blogs.isEmpty) {
                    return ErrorNotification();
                  }
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      children: [
                        SizedBox(height: 32),
                        Text(
                          "Kết quả tìm kiếm cho: ${controller.query}",
                          style: AppTextStyles.h0,
                          textAlign: TextAlign.center,
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: controller.blogs.length,
                          itemBuilder: (context, index) {
                            final blog = controller.blogs[index];
                            return PostCard(
                              blogData: blog,
                              onTap:
                                  () => controller.openBlogsDetail(blog.slug),
                            );
                          },
                        ),
                      ],
                    ),
                  );
                }),
                // Pagination Area
                Obx(() {
                  if (controller.blogs.isEmpty) {
                    return SizedBox.shrink();
                  }
                  return PaginationBar(
                    totalPages: controller.totalPages.value,
                    onPageSelected:
                        (page) => {
                          if (page != controller.currentPage.value)
                            {
                              controller.fetchBlogByCate(
                                controller.query,
                                page,
                              ),
                            },
                        },
                    currentPage: controller.currentPage.value,
                  );
                }),

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
