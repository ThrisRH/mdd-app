class CategoryResponse {
  final List<CategoryData> data;

  CategoryResponse({required this.data});

  factory CategoryResponse.fromJson(Map<String, dynamic> json) {
    return CategoryResponse(
      data:
          (json['data'] as List<dynamic>)
              .map((e) => CategoryData.fromJson(e as Map<String, dynamic>))
              .toList(),
    );
  }
}

class CategoryData {
  final String documentId;
  final String tile;
  final String slug;

  CategoryData({
    required this.documentId,
    required this.tile,
    required this.slug,
  });

  factory CategoryData.fromJson(Map<String, dynamic> json) => CategoryData(
    documentId: json['documentId'],
    tile: json['tile'],
    slug: json['slug'],
  );
}
