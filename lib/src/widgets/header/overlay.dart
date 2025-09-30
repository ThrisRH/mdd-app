// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mddblog/src/controllers/auth_controller.dart';
import 'package:mddblog/src/controllers/author_controller.dart';
import 'package:mddblog/src/controllers/blog_by_cate_controller.dart';
import 'package:mddblog/src/widgets/decoration/dot.dart';
import 'package:mddblog/src/widgets/post/header_line.dart';
import 'package:mddblog/theme/controller/theme_controller.dart';
import 'package:mddblog/src/models/category_model.dart';
import 'package:mddblog/src/services/category_service.dart';
import 'package:mddblog/src/widgets/header/topic_nav.dart';
import 'package:mddblog/src/widgets/header/user_info_card.dart';
import 'package:mddblog/src/widgets/main/button.dart';
import 'package:mddblog/theme/element/app_colors.dart';

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
  final AuthController authController = Get.put(AuthController());

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
    return Obx(() {
      if (authController.isLoading.value) {
        return SizedBox.shrink();
      }
      return Scaffold(
        backgroundColor:
            Theme.of(context).brightness == Brightness.dark
                ? Colors.black
                : Colors.white,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: GestureDetector(
                  onTap: closeOverlay,
                  child: Icon(
                    Icons.close,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 12,
                children: [
                  // Thông tin của Blogger
                  Divider(
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withOpacity(0.2),
                    thickness: 1,
                  ),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Obx(() {
                      final data = authController.userDetail.value;
                      if (data == null) {
                        return UserInfoCardUnAuth();
                      }
                      return GestureDetector(
                        onTap: () => authorController.toAuthorPage(),
                        child: UserInfoCard(data: data),
                      );
                    }),
                  ),
                  Divider(
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withOpacity(0.2),
                    thickness: 1,
                  ),

                  // Thanh điều hướng
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                                        style: Theme.of(
                                          context,
                                        ).textTheme.headlineMedium?.copyWith(
                                          fontSize: 20,
                                          color:
                                              isActive
                                                  ? AppColors.secondary
                                                  : Theme.of(
                                                    context,
                                                  ).colorScheme.onSurface,
                                        ),
                                      ),
                            ),
                          );
                        }),
                        Obx(() {
                          if (authController.isLoggedIn.value) {
                            return GestureDetector(
                              child: MDDButton(
                                bgColor: AppColors.primary,
                                label: "Đăng xuất",
                                onTap: () => authController.logout(),
                              ),
                            );
                          }
                          return HeaderLine(
                            child: Row(
                              spacing: 6,
                              children: [
                                Dot(),
                                Text(
                                  'Settings',
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                                Dot(),
                              ],
                            ),
                          );
                        }),

                        Container(
                          margin: EdgeInsets.only(top: 12),
                          child: Row(
                            children: [
                              Text(
                                "Dark mode",
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium
                                    ?.copyWith(fontSize: 20),
                              ),
                              Spacer(),
                              Theme.of(context).brightness == Brightness.light
                                  ? SizedBox(
                                    child: IconButton(
                                      style: ButtonStyle(
                                        iconSize: WidgetStatePropertyAll(32),
                                      ),
                                      onPressed: () {
                                        Get.find<ThemeController>()
                                            .toggleTheme();
                                      },
                                      icon: Icon(Icons.toggle_off),
                                    ),
                                  )
                                  : IconButton(
                                    style: ButtonStyle(
                                      iconSize: WidgetStatePropertyAll(32),
                                    ),
                                    onPressed: () {
                                      Get.find<ThemeController>().toggleTheme();
                                    },
                                    icon: Icon(Icons.toggle_on),
                                  ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}
