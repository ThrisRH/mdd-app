import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mddblog/models/category-model.dart';
import 'package:mddblog/src/widgets/header/overlay.dart';
import 'package:mddblog/theme/element/app-colors.dart';

class TopicNav extends StatelessWidget {
  final List<CategoryData> cates;
  final VoidCallback? closeOverlay;
  final VoidCallback? closeCate;
  final String navLabel;
  final bool isOpenCate;
  final bool isSelected;
  TopicNav({
    super.key,
    required this.cates,
    required this.navLabel,
    required this.isOpenCate,
    required this.isSelected,
    this.closeOverlay,
    this.closeCate,
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
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontSize: 22,
                  color:
                      isSelected
                          ? AppColors.secondary
                          : Theme.of(context).colorScheme.onSurface,
                ),
              ),
              Spacer(),
              Icon(
                !isOpenCate
                    ? Icons.keyboard_arrow_down
                    : Icons.keyboard_arrow_up,
                color: Theme.of(context).colorScheme.onSurface,
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
                    (cate) => Padding(
                      padding: EdgeInsets.only(left: 16),
                      child: GestureDetector(
                        onTap: () {
                          closeCate!();
                          closeOverlay!();
                          c.toCategoryView(cate.documentId, cate.tile);
                        },
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 32),
                              child: Text(
                                cate.tile,
                                style: Theme.of(
                                  context,
                                ).textTheme.bodyMedium?.copyWith(
                                  color:
                                      cate.documentId == currentCateId
                                          ? AppColors.secondary
                                          : Theme.of(
                                            context,
                                          ).colorScheme.onSurface,
                                ),
                              ),
                            ),
                          ],
                        ),
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
