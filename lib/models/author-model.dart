import 'package:mddblog/models/about-model.dart';

class AuthorResponse {
  final List<AuthorInfo> data;

  AuthorResponse({required this.data});

  factory AuthorResponse.fromJson(Map<String, dynamic> json) => AuthorResponse(
    data: (json['data'] as List).map((e) => AuthorInfo.fromJson(e)).toList(),
  );
}

class AuthorInfo {
  final String documentId;
  final String fullname;
  final String biography;
  final AuthorAvatar authorAvatar;
  final List<ContactSocialMedia> contactSocialMedia;
  final List<AuthorHobbies> authorHobbies;

  AuthorInfo({
    required this.documentId,
    required this.fullname,
    required this.biography,
    required this.authorAvatar,
    required this.contactSocialMedia,
    required this.authorHobbies,
  });

  factory AuthorInfo.fromJson(Map<String, dynamic> json) => AuthorInfo(
    documentId: json['documentId'],
    fullname: json['fullname'],
    biography: json['biography'],
    authorAvatar: AuthorAvatar.fromJson(json['avatar']),
    contactSocialMedia:
        (json['contact'] as List)
            .map((e) => ContactSocialMedia.fromJson(e))
            .toList(),
    authorHobbies:
        (json['interest'] as List)
            .map((e) => AuthorHobbies.fromJson(e))
            .toList(),
  );
}

class ContactSocialMedia {
  final String url;
  final String platform;

  ContactSocialMedia({required this.url, required this.platform});

  factory ContactSocialMedia.fromJson(Map<String, dynamic> json) =>
      ContactSocialMedia(url: json['url'], platform: json['platform']);
}

class AuthorHobbies {
  final String interest;

  AuthorHobbies({required this.interest});

  factory AuthorHobbies.fromJson(Map<String, dynamic> json) =>
      AuthorHobbies(interest: json['interest']);
}
