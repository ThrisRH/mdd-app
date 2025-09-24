import 'package:mddblog/src/models/about_model.dart';

class CommentResponse {
  final List<CommentContent> comments;

  CommentResponse({required this.comments});

  factory CommentResponse.fromJson(Map<String, dynamic> json) =>
      CommentResponse(
        comments:
            (json['data'] as List)
                .map((e) => CommentContent.fromJson(e))
                .toList(),
      );
}

class CommentContent {
  final String documentId;
  final String content;
  final String createdAt;
  final Reader reader;

  CommentContent({
    required this.documentId,
    required this.content,
    required this.createdAt,
    required this.reader,
  });

  factory CommentContent.fromJson(Map<String, dynamic> json) => CommentContent(
    documentId: json['documentId'],
    content: json['content'],
    createdAt: json['createdAt'],
    reader: Reader.fromJson(json['reader']),
  );
}

class Reader {
  final String readerName;
  final String createdAt;
  final AuthorAvatar readerAvatar;

  Reader({
    required this.readerAvatar,
    required this.createdAt,
    required this.readerName,
  });

  factory Reader.fromJson(Map<String, dynamic> json) => Reader(
    readerAvatar: AuthorAvatar.fromJson(json['avatar']),
    createdAt: json['createdAt'],
    readerName: json['Fullname'],
  );
}
