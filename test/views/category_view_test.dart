// ignore_for_file: must_call_super

import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mddblog/src/controllers/blog_by_cate_controller.dart';
import 'package:mddblog/src/models/blog_model.dart';
import 'package:mddblog/src/views/category/category.dart';
import 'package:mddblog/src/widgets/header/navbar.dart';
import 'package:mddblog/src/widgets/main/loading.dart';

class MockBlogByCateController extends BlogByCateController {
  @override
  void onInit() {
    cateId = '1';
    cateName = 'Book Review';
  }

  @override
  void fetchBlogByCate(String cateId, int page) {
    // mô phỏng fetch mà không cần API
    blogs.assignAll([
      BlogData(
        title: "Bài viết test",
        slug: "bai-viet-test",
        documentId: '1',
        publishedAt: '2025-08-25T03:43:28.745Z',
        mainContent: 'noi dung........',
        cover: BlogCover(documentId: 'documentId', name: 'name', url: 'url'),
      ),
    ]);
    isLoading.value = false;
  }

  @override
  void openBlogsDetail(String slug) {}
}

void main() {
  late MockBlogByCateController controller;

  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();

    await dotenv.load(fileName: ".env").catchError((_) {
      dotenv.env.addAll({'BASE_URL': 'http://192.168.1.173:1337/api'});
    });
    HttpOverrides.global = null;
  });

  setUp(() {
    controller = MockBlogByCateController();
    Get.put<BlogByCateController>(controller);
    Get.put(NavbarController());
  });

  tearDown(() {
    Get.delete<BlogByCateController>();
  });

  testWidgets('Hiển thị widget trong Category Loading khi đang tải', (
    tester,
  ) async {
    controller.isLoading.value = true;

    await tester.pumpWidget(GetMaterialApp(home: Category()));
    await tester.pump();

    expect(find.byType(Loading), findsOneWidget);
  });
}
