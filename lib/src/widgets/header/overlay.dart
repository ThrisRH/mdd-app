// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mddblog/src/controllers/author_controller.dart';
import 'package:mddblog/src/models/category_model.dart';
import 'package:mddblog/src/services/category_service.dart';
import 'package:mddblog/src/views/category/category.dart';
import 'package:mddblog/src/widgets/header/topic_nav.dart';
import 'package:mddblog/src/widgets/header/userInfoCard.dart';
import 'package:mddblog/theme/app_colors.dart';
import 'package:mddblog/theme/app_text_styles.dart';

class CategoryController extends GetxController {
  final CategoryService _categoryService = CategoryService();
  var cates = <CategoryData>[].obs;
  var isLoading = true.obs;
  var isOpenCate = false.obs;

  var selectedCate = Rxn<CategoryData>();

  @override
  void onInit() {
    super.onInit();
    fetchCategory();
  }

  void fetchCategory() async {
    try {
      isLoading.value = true;
      final response = await _categoryService.getCategories();
      cates.assignAll(response.data);

      if (cates.isNotEmpty) {
        selectedCate.value = cates.first;
      }
    } catch (error) {
      Get.snackbar("Error", error.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void openCate() {
    isOpenCate.value = !isOpenCate.value;
  }

  void changeCategory(CategoryData? cate) {
    if (cate != null) {
      selectedCate.value = cate;
    }
  }

  void toCategoryView(String documentId, String cateName) {
    Get.delete<BlogByCateController>();
    Get.offNamed(
      '/topics/$documentId',
      arguments: {"id": documentId, "name": cateName},
    );
  }
}

class OverlayToggle extends StatelessWidget {
  final VoidCallback closeOverlay;
  OverlayToggle({super.key, required this.closeOverlay});

  final CategoryController c = Get.put(CategoryController());
  final AuthorController authorController = Get.put(AuthorController());

  final double spacing = 32;

  final List<Map<String, String>> menuItems = const [
    {"title": "TRANG CHỦ", "route": "/home"},
    {"title": "GIỚI THIỆU", "route": "/about"},
    {"title": "CHỦ ĐỀ", "route": "/topics"},
    {"title": "HỎI ĐÁP", "route": "/faq"},
  ];
  @override
  Widget build(BuildContext context) {
    final currentRoute = ModalRoute.of(context)?.settings.name ?? "";
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: GestureDetector(
                onTap: closeOverlay,
                child: Icon(Icons.close, color: Colors.white),
              ),
            ),
            Divider(color: Colors.white.withOpacity(0.2), thickness: 1),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Thông tin của Blogger
                  SizedBox(height: 32),
                  Obx(() {
                    final data = authorController.authorInfo.value;
                    if (data == null) {
                      return Text('Author not found');
                    }
                    return GestureDetector(
                      onTap: () => authorController.toAuthorPage(),
                      child: UserInfoCard(data: data),
                    );
                  }),
                  SizedBox(height: 32),
                  Divider(color: Colors.white.withOpacity(0.2), thickness: 1),
                  SizedBox(height: 32),

                  // Thanh điều hướng
                  ...menuItems.map((item) {
                    final isActive = item["route"] == currentRoute;

                    return Padding(
                      padding: EdgeInsets.only(bottom: spacing),
                      child: GestureDetector(
                        onTap: () {
                          if (item['route'] != "/topics") {
                            closeOverlay();
                            Get.toNamed(item['route']!);
                          } else {
                            c.openCate();
                          }
                        },
                        child:
                            item["route"] == "/topics"
                                ? Obx(
                                  () => TopicNav(
                                    isSelected: isActive,
                                    isOpenCate: c.isOpenCate.value,
                                    cates: c.cates,
                                    navLabel: item["title"]!,
                                  ),
                                )
                                : Text(
                                  item["title"]!,
                                  style: AppTextStyles.h3.copyWith(
                                    color:
                                        isActive
                                            ? AppColors.secondary
                                            : Colors.white,
                                  ),
                                ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
