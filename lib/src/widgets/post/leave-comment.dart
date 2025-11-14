import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mddblog/config/api.dart';
import 'package:mddblog/controllers/auth-controller.dart';
import 'package:mddblog/models/comment-model.dart';
import 'package:mddblog/src/views/blog-details/blog-details.dart';
import 'package:mddblog/src/widgets/post/section-wrapper.dart';
import 'package:mddblog/utils/env.dart';

class LeaveComment extends GetWidget {
  final List<CommentContent> comments;
  final String blogId, blogSlug;
  LeaveComment(
    this.comments, {
    super.key,
    required this.blogId,
    required this.blogSlug,
  });

  final BlogDetailsController blogDetailsController = Get.put(
    BlogDetailsController(),
  );
  final AuthController authController = Get.put(AuthController());
  final TextEditingController _commentInputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SectionWrapper(
      child: Column(
        spacing: 24,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('LEAVE A COMMENT', style: Theme.of(context).textTheme.bodySmall),

          Obx(() {
            if (comments.isEmpty) {
              return SizedBox.shrink();
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 16,
              children: [
                ...comments.map(
                  (item) => SizedBox(
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 12,
                      children: [
                        SizedBox(
                          height: 48,
                          width: 48,
                          child: ClipOval(
                            child: Image.network(
                              item.reader.avatar != null &&
                                      item.reader.avatar!.url.isNotEmpty
                                  ? (Env.isDev
                                      ? "$baseUrlNoUrl${item.reader.avatar!.url}"
                                      : item.reader.avatar!.url)
                                  : item.reader.avatarUrl,
                              errorBuilder:
                                  (context, error, stackTrace) =>
                                      Icon(Icons.person),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: 6,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    item.reader.fullname,
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodySmall?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Spacer(),
                                  Text(
                                    DateFormat(
                                      'dd.MM.yyy',
                                    ).format(DateTime.parse(item.createdAt)),
                                    style: Theme.of(context).textTheme.bodySmall
                                        ?.copyWith(color: Colors.grey.shade500),
                                  ),
                                ],
                              ),
                              Text(
                                item.content,
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }),

          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Color(0xFFD5CBCB)),
            ),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(12.0),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minHeight: 300),
                    child: Column(
                      children: [
                        TextField(
                          controller: _commentInputController,
                          maxLength: 500,
                          maxLines: null,
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(
                            hintText: "Write a comment",
                            hintStyle: TextStyle(color: Colors.grey.shade400),
                            border: InputBorder.none,
                            counterText: "",
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 32),
                  width: double.infinity,
                  height: 80,
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(width: 1, color: Color(0xFFD5CBCB)),
                    ),
                  ),
                  child: GestureDetector(
                    onTap: () async {
                      final response = await blogDetailsController.sendComment(
                        blogId,
                        authController
                            .userDetail
                            .value!
                            .userDetailInfo
                            .documentId,
                        _commentInputController.text,
                      );
                      if (response) {
                        await blogDetailsController.fetchBlogPage(
                          blogSlug,
                        ); // fetch lại danh sách
                        _commentInputController.clear();
                      }
                    },
                    child: Center(
                      child: Container(
                        width: double.infinity,
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                            width: 1,
                            color: Color(0xFFD5CBCB),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'Post Comment',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
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
