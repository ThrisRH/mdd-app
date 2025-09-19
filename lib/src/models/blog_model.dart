class BlogResponse {
  final List<BlogData> data;
  final Meta meta;

  BlogResponse({required this.data, required this.meta});

  factory BlogResponse.fromJson(Map<String, dynamic> json) {
    return BlogResponse(
      data:
          (json['data'] as List<dynamic>)
              .map((item) => BlogData.fromJson(item))
              .toList(),
      meta: Meta.fromJson(json['meta']),
    );
  }
}

class BlogData {
  final String documentId;
  final String title;
  final String publishedAt;
  final String mainContent;
  final String slug;
  final BlogCover cover;

  BlogData({
    required this.documentId,
    required this.title,
    required this.publishedAt,
    required this.mainContent,
    required this.slug,
    required this.cover,
  });

  factory BlogData.fromJson(Map<String, dynamic> json) => BlogData(
    documentId: json['documentId'],
    title: json['title'],
    publishedAt: json['publishedAt'],
    mainContent: json['mainContent'],
    slug: json['slug'],
    cover: BlogCover.fromJson(json['cover']),
  );
}

class BlogCover {
  final String documentId;
  final String name;
  final String url;

  BlogCover({required this.documentId, required this.name, required this.url});

  factory BlogCover.fromJson(Map<String, dynamic> json) => BlogCover(
    documentId: json["documentId"],
    name: json['name'],
    url: json['url'],
  );
}

// Pagination
class Meta {
  final PaginationDetail pagination;

  Meta({required this.pagination});

  factory Meta.fromJson(Map<String, dynamic> json) =>
      Meta(pagination: PaginationDetail.fromJson(json['pagination']));
}

class PaginationDetail {
  final int pageCount;
  final int total;

  PaginationDetail({required this.pageCount, required this.total});

  factory PaginationDetail.fromJson(Map<String, dynamic> json) =>
      PaginationDetail(pageCount: json['pageCount'], total: json['total']);
}
