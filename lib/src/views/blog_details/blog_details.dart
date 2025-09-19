import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mddblog/src/models/blog_details_model.dart';
import 'package:mddblog/src/services/blog_service.dart';
import 'package:mddblog/src/widgets/footer/footer.dart';
import 'package:mddblog/src/widgets/header/navbar.dart';
import 'package:mddblog/src/widgets/header/overlay.dart';
import 'package:mddblog/src/widgets/post/PostDetails.dart';

// Controller
class BlogDetailsController extends GetxController {
  final BlogService _blogService = BlogService();

  var blogDetail = Rxn<BlogDetails>();
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    final slug = Get.arguments as String;
    fetchBlogDetails(slug);
  }

  Future<void> fetchBlogDetails(String slug) async {
    try {
      isLoading.value = true;
      final response = await _blogService.getBlogsBySlug(slug);
      blogDetail.value = response.data;
    } catch (error) {
      Get.snackbar("Error", error.toString());
    } finally {
      isLoading.value = false;
    }
  }
}

class BlogDetailsPage extends GetWidget<BlogDetailsController> {
  BlogDetailsPage({super.key});

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
                MDDNavbar(onSearchTap: () => {}, onMenuTap: toggleOverlay),

                // // Body
                Obx(() {
                  final detail = controller.blogDetail.value;
                  if (detail == null) {
                    return Center(child: CircularProgressIndicator());
                  }
                  return Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    margin: EdgeInsets.only(top: 40),
                    child: BlogDetailsContainer(detail: detail),
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
