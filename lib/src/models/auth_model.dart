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
  final String fullname;
  final AuthorAvatar avatar;

  UserDetailInfo({required this.fullname, required this.avatar});

  factory UserDetailInfo.fromJson(Map<String, dynamic> json) => UserDetailInfo(
    fullname: json['Fullname'],
    avatar: AuthorAvatar.fromJson(json['avatar']),
  );
}
