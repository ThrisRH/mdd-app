import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mddblog/src/models/category_model.dart';
import 'package:mddblog/src/widgets/header/overlay.dart';
import 'package:mddblog/theme/app_colors.dart';
import 'package:mddblog/theme/app_text_styles.dart';

class TopicNav extends StatelessWidget {
  final List<CategoryData> cates;
  final String navLabel;
  final bool isOpenCate;
  final bool isSelected;
  TopicNav({
    super.key,
    required this.cates,
    required this.navLabel,
    required this.isOpenCate,
    required this.isSelected,
  });

  final CategoryController c = Get.put(CategoryController());
  final currentCateId =
      Get.arguments != null ? (Get.arguments as Map)["id"] : null;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          Row(
            children: [
              Text(
                navLabel,
                style: AppTextStyles.h2.copyWith(
                  color: isSelected ? AppColors.secondary : Colors.white,
                ),
              ),
              Spacer(),
              Icon(
                !isOpenCate
                    ? Icons.keyboard_arrow_down
                    : Icons.keyboard_arrow_up,
                color: Colors.white,
              ),
            ],
          ),
          if (isOpenCate)
            SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...cates.map(
                    (cate) => GestureDetector(
                      onTap: () {
                        c.toCategoryView(cate.documentId, cate.tile);
                      },
                      child: Column(
                        children: [
                          SizedBox(height: 32),

                          Text(
                            cate.tile,
                            style: AppTextStyles.body2.copyWith(
                              color:
                                  cate.documentId == currentCateId
                                      ? AppColors.secondary
                                      : Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
