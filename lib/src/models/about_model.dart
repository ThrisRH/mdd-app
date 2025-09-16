class AboutResponse {
  final AboutData data;

  AboutResponse({required this.data});

  factory AboutResponse.fromJson(Map<String, dynamic> json) =>
      AboutResponse(data: AboutData.fromJson(json['data']));
}

class AboutData {
  final int id;
  final String documentId;
  final List<AboutContent> aboutContent;

  AboutData({
    required this.id,
    required this.documentId,
    required this.aboutContent,
  });

  factory AboutData.fromJson(Map<String, dynamic> json) => AboutData(
    id: json['id'],
    documentId: json['documentId'],
    aboutContent:
        (json['aboutContent'] as List)
            .map((e) => AboutContent.fromJson(e))
            .toList(),
  );
}

class TextNode {
  final String type;
  final String text;

  TextNode({required this.type, required this.text});

  factory TextNode.fromJson(Map<String, dynamic> json) =>
      TextNode(type: json["type"], text: json["text"]);
}

class AboutContent {
  final String type;
  final List<TextNode> children;

  AboutContent({required this.type, required this.children});

  factory AboutContent.fromJson(Map<String, dynamic> json) => AboutContent(
    type: json["type"],
    children:
        (json["children"] as List).map((e) => TextNode.fromJson(e)).toList(),
  );
}

class AuthorAvatar {
  final int id;
  final String name;
  final String url;

  AuthorAvatar({required this.id, required this.name, required this.url});

  factory AuthorAvatar.fromJson(Map<String, dynamic> json) =>
      AuthorAvatar(id: json['id'], name: json['name'], url: json["url"]);
}
