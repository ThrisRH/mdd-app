import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:mddblog/models/blog-model.dart';
import 'package:mddblog/src/views/home/widgets/banner.dart';
import 'package:mddblog/src/widgets/footer/footer.dart';
import 'package:mddblog/src/widgets/layout/phone-body.dart';
import 'package:mddblog/src/widgets/main/error.dart';
import 'package:mddblog/src/widgets/main/loading.dart';
import 'package:mddblog/src/widgets/main/pagination_bar.dart';
import 'package:mddblog/src/widgets/post/post-card.dart';

class BlogListBody extends StatelessWidget {
  final String title;
  final Future<void> Function() onRefresh;
  final RxBool isLoading;
  final RxList<BlogData> blogs;
  final RxInt currentPage;
  final RxInt totalPages;
  final void Function(int page) onPageSelected;
  final void Function(BlogData blog) onBlogTap;
  const BlogListBody({
    super.key,
    required this.title,
    required this.onRefresh,
    required this.isLoading,
    required this.blogs,
    required this.currentPage,
    required this.totalPages,
    required this.onPageSelected,
    required this.onBlogTap,
  });

  @override
  Widget build(BuildContext context) {
    return PhoneBody(
      body: RefreshIndicator(
        onRefresh: onRefresh,
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            // Banner
            const SliverToBoxAdapter(child: BannerSection()),

            // Header / Title
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 40.0),
                child: Center(
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.headlineLarge,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),

            // Blog list
            Obx(() {
              if (isLoading.value) {
                return const SliverFillRemaining(
                  child: Center(child: Loading()),
                );
              }
              if (blogs.isEmpty) {
                return SliverToBoxAdapter(
                  child: ErrorNotificationWithMessage(
                    errorMessage: "No error found",
                  ),
                );
              }

              return SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final blog = blogs[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 8,
                    ),
                    child: PostCard(
                      blogData: blog,
                      onTap: () => onBlogTap(blog),
                    ),
                  );
                }, childCount: blogs.length),
              );
            }),

            // Pagination
            Obx(() {
              if (blogs.isEmpty) {
                return const SliverToBoxAdapter(child: SizedBox.shrink());
              }
              return SliverToBoxAdapter(
                child: Column(
                  children: [
                    PaginationBar(
                      totalPages: totalPages.value,
                      onPageSelected: onPageSelected,
                      currentPage: currentPage.value,
                    ),
                  ],
                ),
              );
            }),

            SliverToBoxAdapter(child: Footer()),
          ],
        ),
      ),
    );
  }
}
