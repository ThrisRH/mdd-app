import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mddblog/src/views/search/search.dart';
import 'package:mddblog/src/widgets/main/button.dart';
import 'package:mddblog/theme/element/app_colors.dart';

class NavbarController extends GetxController {
  var isSearching = false.obs;

  void activeSearchMode() {
    isSearching.value = !isSearching.value;
  }

  var inputValue = "".obs;

  void onSearch() {
    if (inputValue.value.isEmpty) {
      return;
    } else {
      isSearching.value = false;
      Get.delete<BlogBySearchQueryController>();
      Get.toNamed(
        "/home/search/${inputValue.value}",
        arguments: {"query": inputValue.value},
      );
    }
  }
}

class MDDNavbar extends GetWidget<NavbarController> {
  final VoidCallback onMenuTap;
  const MDDNavbar({super.key, required this.onMenuTap});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isSearching.value) {
        return Column(
          children: [
            AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.black,
              elevation: 0,
              title: Row(
                spacing: 12,
                children: [
                  Flexible(
                    flex: 10,
                    child: Container(
                      padding: EdgeInsets.only(
                        top: 4,
                        right: 4,
                        bottom: 4,
                        left: 12,
                      ),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: Colors.white),
                      ),
                      height: 48,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Flexible(
                            flex: 1,
                            child: Row(
                              children: [
                                Icon(Icons.search, color: AppColors.secondary),

                                Flexible(
                                  flex: 3,
                                  child: TextField(
                                    onChanged:
                                        (value) =>
                                            controller.inputValue.value = value,
                                    style: TextStyle(color: Colors.white),
                                    decoration: InputDecoration(
                                      hintText: "Tìm kiếm",
                                      hintStyle: TextStyle(
                                        color: Colors.white54,
                                      ),
                                      border: InputBorder.none,
                                      isDense: true,
                                      contentPadding: EdgeInsets.symmetric(
                                        vertical: 8,
                                        horizontal: 8,
                                      ),
                                    ),
                                  ),
                                ),
                                Flexible(
                                  flex: 2,
                                  child: MDDButton(
                                    radius: 18,
                                    height: 48,
                                    fontSize: 12,
                                    bgColor: AppColors.primary,
                                    label: "Tìm kiếm",
                                    onTap: () => controller.onSearch(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () => controller.activeSearchMode(),
                      child: Icon(Icons.close, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            Stack(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 190,
                  child: Opacity(
                    opacity: 0.3,
                    child: Image.asset(
                      "assets/banner/banner.jpg",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  top: 0,
                  bottom: 0,
                  child: Center(
                    child: SizedBox(
                      width: 116,
                      height: 114,
                      child: Image.asset(
                        "assets/icons/logo.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      }
      return Column(
        children: [
          AppBar(
            backgroundColor: Colors.black,
            elevation: 0,
            leading: IconButton(
              onPressed: onMenuTap,
              icon: Icon(Icons.menu, color: Colors.white),
            ),
            actions: [
              IconButton(
                onPressed: () => controller.activeSearchMode(),
                icon: Icon(Icons.search, color: Colors.white),
              ),
            ],
          ),
          Stack(
            children: [
              SizedBox(
                width: double.infinity,
                height: 190,
                child: Opacity(
                  opacity: 0.3,
                  child: Image.asset(
                    "assets/banner/banner.jpg",
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              Positioned(
                left: 0,
                right: 0,
                top: 0,
                bottom: 0,
                child: Center(
                  child: SizedBox(
                    width: 116,
                    height: 114,
                    child: Image.asset(
                      "assets/icons/logo.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    });
  }
}
