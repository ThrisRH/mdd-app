import 'package:mddblog/src/models/blog_model.dart';
import 'package:mddblog/src/models/category_model.dart';

class BlogDetailsResponse {
  final BlogDetails data;

  BlogDetailsResponse({required this.data});

  factory BlogDetailsResponse.fromJson(Map<String, dynamic> json) =>
      BlogDetailsResponse(data: BlogDetails.fromJson(json['data']));
}

class BlogDetails extends BlogData {
  final List<SubContent> subContent;
  final List<OptionImage>? optionImage;
  final CategoryData categoryData;
  BlogDetails({
    required super.documentId,
    required super.title,
    required super.publishedAt,
    required super.mainContent,
    required super.slug,
    required super.cover,
    required this.categoryData,
    required this.subContent,
    required this.optionImage,
  });

  factory BlogDetails.fromJson(Map<String, dynamic> json) => BlogDetails(
    documentId: json['documentId'],
    title: json['title'],
    publishedAt: json['publishedAt'],
    mainContent: json['mainContent'],
    slug: json['slug'],
    cover: BlogCover.fromJson(json['cover']),
    optionImage:
        (json['optionImage'] as List<dynamic>?)
            ?.map((e) => OptionImage.fromJson(e))
            .toList() ??
        [],

    subContent:
        (json['subContent'] as List<dynamic>)
            .map((e) => SubContent.fromJson(e))
            .toList(),
    categoryData: CategoryData.fromJson(json['cate']),
  );
}

class SubContent {
  final String content;

  SubContent({required this.content});

  factory SubContent.fromJson(Map<String, dynamic> json) =>
      SubContent(content: json['content']);
}

class OptionImage {
  final List<BlogCover> images;

  OptionImage({required this.images});

  factory OptionImage.fromJson(Map<String, dynamic> json) => OptionImage(
    images:
        (json['image'] as List<dynamic>)
            .map((e) => BlogCover.fromJson(e as Map<String, dynamic>))
            .toList(),
  );
}
