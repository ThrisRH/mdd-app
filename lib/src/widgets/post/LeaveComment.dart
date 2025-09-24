import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mddblog/src/config/constants.dart';
import 'package:mddblog/src/models/comment_model.dart';
import 'package:mddblog/src/views/blog_details/blog_details.dart';
import 'package:mddblog/src/widgets/post/SectionWrapper.dart';
import 'package:mddblog/theme/app_text_styles.dart';

class LeaveComment extends GetWidget {
  final List<CommentContent> comments;
  final String blogId;
  LeaveComment(this.comments, {super.key, required this.blogId});

  final BlogDetailsController c = Get.put(BlogDetailsController());
  final TextEditingController _commentInputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SectionWrapper(
      child: Column(
        spacing: 24,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('LEAVE A COMMENT', style: AppTextStyles.h4),

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
                              "$baseUrlNoUrl${item.reader.readerAvatar.url}",
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
                                    item.reader.readerName,
                                    style: AppTextStyles.body3.copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Spacer(),
                                  Text(
                                    DateFormat(
                                      'dd.MM.yyy',
                                    ).format(DateTime.parse(item.createdAt)),
                                    style: AppTextStyles.body3.copyWith(
                                      fontSize: 14,
                                      color: Colors.grey.shade500,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                item.content,
                                style: AppTextStyles.body3.copyWith(
                                  fontSize: 14,
                                ),
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
                      final response = await c.sendComment(
                        blogId,
                        "rlz4v0au4gae47o4uocybx0s",
                        _commentInputController.text,
                      );
                      if (response) {
                        await c.fetchComment(blogId); // fetch lại danh sách
                        _commentInputController.clear();
                      }
                    },
                    child: Center(
                      child: Container(
                        width: double.infinity,
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(width: 1, color: Colors.black),
                        ),
                        child: Center(child: Text('Post Comment')),
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
