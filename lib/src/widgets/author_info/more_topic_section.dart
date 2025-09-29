import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mddblog/src/models/category_model.dart';
import 'package:mddblog/src/widgets/header/overlay.dart';

class MoreTopicSection extends GetWidget<CategoryController> {
  const MoreTopicSection({super.key});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 363 / 157, // tỉ lệ của SVG gốc
      child: Stack(
        alignment: Alignment.center,
        children: [
          SvgPicture.asset(
            "assets/svg/MoreTopicFrame.svg",
            fit: BoxFit.fill,
            width: double.infinity,
            height: double.infinity,
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 42,
              bottom: 12,
              right: 24,
              left: 24,
            ),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              width: double.infinity,
              height: 48,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Obx(() {
                if (controller.isLoading.value) {
                  return CircularProgressIndicator();
                }
                if (controller.cates.isEmpty) {
                  return Text("Cate not found!");
                }
                return DropdownButtonHideUnderline(
                  child: DropdownButton<CategoryData>(
                    isExpanded: true,
                    value: controller.selectedCate.value,
                    items:
                        controller.cates
                            .map(
                              (cate) => DropdownMenuItem<CategoryData>(
                                value: cate,
                                child: Text(
                                  cate.tile,
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            )
                            .toList(),
                    onChanged: (cate) {
                      if (cate != null) {
                        controller.toCategoryView(cate.documentId, cate.tile);
                      }
                    },
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
