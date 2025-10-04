// ignore_for_file: must_call_super

import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mddblog/src/controllers/blog_controller.dart';
import 'package:mddblog/src/models/blog_model.dart';
import 'package:mddblog/src/views/home/home.dart';
import 'package:mddblog/src/widgets/header/navbar.dart';
import 'package:mddblog/src/widgets/main/error.dart';
import 'package:mddblog/src/widgets/main/loading.dart';

/// Mock controller kế thừa BlogController nhưng không gọi API
class MockBlogController extends BlogController {
  @override
  void onInit() {} // Không gọi fetchPage hay fetchFavorites

  @override
  void fetchPage(int page) {}

  @override
  void fetchFavorites() {}

  @override
  void openBlogsDetail(String slug) {}
}

void main() {
  late MockBlogController controller;

  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();

    await dotenv.load(fileName: ".env").catchError((_) {
      dotenv.env.addAll({'BASE_URL': 'http://192.168.1.173:1337/api'});
    });
    HttpOverrides.global = null;
  });

  setUp(() {
    controller = MockBlogController();
    Get.put<BlogController>(controller);
    Get.put(NavbarController());
  });

  tearDown(() {
    Get.delete<BlogController>();
  });

  testWidgets('Hiển thị widget Loading khi đang tải', (tester) async {
    controller.isLoading.value = true;

    await tester.pumpWidget(GetMaterialApp(home: Home()));
    await tester.pump();

    expect(find.byType(Loading), findsOneWidget);
  });

  testWidgets('Hiển thị ErrorNotification khi không có dữ liệu', (
    tester,
  ) async {
    controller.isLoading.value = false;
    controller.blogs.value = [];

    await tester.pumpWidget(GetMaterialApp(home: Home()));
    await tester.pumpAndSettle();

    expect(find.byType(ErrorNotification), findsOneWidget);
  });

  testWidgets('Hiển thị tiêu đề "Blogs" khi có dữ liệu', (tester) async {
    controller.isLoading.value = false;
    controller.blogs.value = [
      BlogData(
        documentId: '1',
        title: 'Review Book 2',
        publishedAt: '2025-08-25T03:43:28.745Z',
        mainContent:
            'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
        slug: 'review-book-2',
        cover: BlogCover(
          url: '/uploads/img',
          documentId: '1',
          name: 'test-image',
        ),
      ),
    ];

    await tester.pumpWidget(GetMaterialApp(home: Home()));
    await tester.pumpAndSettle();

    expect(find.text('Blogs'), findsOneWidget);
    expect(find.text('Review Book 2'), findsOneWidget);
  });
}
