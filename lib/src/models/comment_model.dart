import 'package:mddblog/src/models/auth_model.dart';

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
  final UserDetailInfo reader;

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
    reader: UserDetailInfo.fromJson(json['reader']),
  );
}

// class Reader {
//   final String readerName;
//   final String avatarCloudUrl;
//   final String createdAt;
//   final AuthorAvatar? readerAvatar;

//   Reader({
//     this.readerAvatar,
//     required this.createdAt,
//     required this.readerName,
//     required this.avatarCloudUrl,
//   });

//   factory Reader.fromJson(Map<String, dynamic> json) => Reader(
//     readerAvatar:
//         json['avatar'] != null ? AuthorAvatar.fromJson(json['avatar']) : null,
//     createdAt: json['createdAt'],
//     readerName: json['Fullname'],
//     avatarCloudUrl: json['avatarCloudUrl'],
//   );
// }
