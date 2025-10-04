import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mddblog/src/widgets/main/pagination_bar.dart';

void main() {
  testWidgets("Hiển thị đúng số lượng trang và xử lý khi bấm nút", (
    tester,
  ) async {
    int currentPage = 1;
    int totalPages = 3;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: PaginationBar(
            totalPages: totalPages,
            onPageSelected: (page) {
              currentPage = page;
            },
            currentPage: currentPage,
          ),
        ),
      ),
    );

    expect(find.text('1'), findsOneWidget);
    expect(find.text('2'), findsOneWidget);
    expect(find.text('3'), findsOneWidget);

    await tester.tap(find.text("3"));
    await tester.pump();

    expect(currentPage, 3);
  });
}
