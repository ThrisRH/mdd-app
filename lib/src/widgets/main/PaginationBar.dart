import 'package:flutter/material.dart';
import 'package:mddblog/theme/app_colors.dart';
import 'package:mddblog/theme/app_text_styles.dart';

class PaginationBar extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final Function(int) onPageSelected;
  const PaginationBar({
    super.key,
    required this.totalPages,
    required this.onPageSelected,
    required this.currentPage,
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> pageButtons = [];

    for (int i = 1; i <= totalPages; i++) {
      pageButtons.add(
        GestureDetector(
          onTap: () => onPageSelected(i),
          child: Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: i == currentPage ? AppColors.primary : Colors.transparent,
            ),
            child: Center(child: Text('$i', style: AppTextStyles.body2)),
          ),
        ),
      );
    }

    return Wrap(
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 24.0,
      children: [
        SizedBox(
          width: 24,
          height: 24,
          child: GestureDetector(
            onTap: () {
              if (currentPage > 1) {
                onPageSelected(currentPage - 1);
              }
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: currentPage == 1 ? Colors.grey : Colors.black,
            ),
          ),
        ),
        ...pageButtons,
        SizedBox(
          width: 24,
          height: 24,
          child: GestureDetector(
            onTap: () {
              if (currentPage < totalPages) {
                onPageSelected(currentPage + 1);
              }
            },
            child: Icon(
              Icons.arrow_forward_ios,
              color: currentPage == totalPages ? Colors.grey : Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
