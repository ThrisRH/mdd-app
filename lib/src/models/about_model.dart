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
  final List<ContactInfo> contact;
  final AuthorAvatar authorAvt;

  AboutData({
    required this.id,
    required this.documentId,
    required this.aboutContent,
    required this.contact,
    required this.authorAvt,
  });

  factory AboutData.fromJson(Map<String, dynamic> json) => AboutData(
    id: json['id'],
    documentId: json['documentId'],
    authorAvt: AuthorAvatar.fromJson(json['authorAvt'] as Map<String, dynamic>),
    aboutContent:
        (json['aboutContent'] as List)
            .map((e) => AboutContent.fromJson(e))
            .toList(),
    contact:
        (json['contact'] as List).map((e) => ContactInfo.fromJson(e)).toList(),
  );
}

// AboutDetail
class TextNode {
  final String type;
  final String text;

  TextNode({required this.type, required this.text});

  factory TextNode.fromJson(Map<String, dynamic> json) =>
      TextNode(type: json["type"], text: json["text"]);
}

// AboutContainer
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

// ContactInfo
class ContactInfo {
  final String content;

  ContactInfo({required this.content});

  factory ContactInfo.fromJson(Map<String, dynamic> json) =>
      ContactInfo(content: json["content"]);
}

// Lưu avatar
class AuthorAvatar {
  final int id;
  final String name;
  final String url;

  AuthorAvatar({required this.id, required this.name, required this.url});

  factory AuthorAvatar.fromJson(Map<String, dynamic> json) {
    return AuthorAvatar(id: json['id'], name: json['name'], url: json['url']);
  }
}
