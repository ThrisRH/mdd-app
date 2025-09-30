import 'package:mddblog/src/models/about_model.dart';

class UserInfoResponse {
  final String username;
  final String email;
  final UserDetailInfo userDetailInfo;

  UserInfoResponse({
    required this.username,
    required this.email,
    required this.userDetailInfo,
  });

  factory UserInfoResponse.fromJson(Map<String, dynamic> json) =>
      UserInfoResponse(
        username: json['username'],
        email: json['email'],
        userDetailInfo: UserDetailInfo.fromJson(json['reader']),
      );
}

class UserDetailInfo {
  final String documentId;
  final String fullname;
  final AuthorAvatar? avatar; // avatar từ Strapi
  final String avatarUrl; // avatar từ Cloudinary

  UserDetailInfo({
    required this.documentId,
    required this.fullname,
    this.avatar,
    required this.avatarUrl,
  });

  factory UserDetailInfo.fromJson(Map<String, dynamic> json) => UserDetailInfo(
    documentId: json['documentId'],
    fullname: json['Fullname'],
    avatarUrl: json['avatarCloudUrl'] ?? "",
    avatar:
        json['avatar'] != null ? AuthorAvatar.fromJson(json['avatar']) : null,
  );
}
