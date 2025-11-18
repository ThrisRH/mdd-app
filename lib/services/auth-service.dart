// ignore_for_file: unnecessary_null_comparison

import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mddblog/models/auth-model.dart';
import 'package:mddblog/services/secure-storage.dart';
import 'package:cloudinary_sdk/cloudinary_sdk.dart';

import '../utils/dio_client.dart';

final dio = ApiClient.dio;

final cloudinary = Cloudinary.full(
  apiKey: dotenv.env['CLOUDINARY_API_KEY']!,
  apiSecret: dotenv.env['CLOUDINARY_API_SECRET']!,
  cloudName: dotenv.env['CLOUDINARY_NAME']!,
);

class AuthenticationService {
  // Kiểm tra đăng nhập
  static Future<bool> isLoggedIn() async {
    final token = await SecureStorage.getTokens();
    return token != null;
  }

  // Đăng nhập
  Future<bool> signIn(String identifier, String password) async {
    try {
      final response = await dio.post(
        "/auth/local",
        data: {
          'identifier': identifier,
          'password': password,
          "requestRefresh": true,
        },
      );

      final data = response.data;
      final jwt = data['jwt'];
      final refreshToken = data['refreshToken'];

      await SecureStorage.saveStrapiToken(jwt, refreshToken);
      return true;
    } on DioException catch (_) {
      return false;
    }
  }

  // Đăng nhập lại
  Future<bool> reSignIn(String email, String password) async {
    final info = await SecureStorage.getTokens();
    final jwt = info['access_token'];

    // Nếu có token, kiểm tra email trùng với user hiện tại
    if (jwt != null) {
      try {
        final user = await getMe(jwt);
        if (user.email != email) {
          return false;
        }
      } catch (_) {}
    }

    try {
      final response = await dio.post(
        "/auth/local",
        data: {
          'identifier': email,
          'password': password,
          "requestRefresh": true,
        },
      );

      return response.statusCode == 200;
    } on DioException catch (_) {
      return false;
    }
  }

  // Đăng ký
  Future<Map<String, dynamic>> signUp({
    required String username,
    required String email,
    required String password,
    required String fullname,
    required String avatarUrl,
  }) async {
    try {
      // B1: Tạo user
      final registerResponse = await dio.post(
        "/auth/local/register",
        data: {'username': username, 'email': email, 'password': password},
      );

      final registerData = registerResponse.data;

      final userId = registerData['user']['id'];

      // B2: Tạo reader
      final readerResponse = await dio.post(
        "/readers",
        data: {
          "data": {
            "Fullname": fullname,
            "avatarCloudUrl": avatarUrl,
            "users_permissions_user": userId,
          },
        },
      );

      return {"success": true, "data": readerResponse.data};
    } on DioException catch (e) {
      final msg = e.response?.data?["error"]?["message"] ?? e.message;

      return {"success": false, "error": msg};
    }
  }

  // Upload avatar
  Future<String?> uploadToCloudinary(File imageFile) async {
    final response = await cloudinary.uploadResource(
      CloudinaryUploadResource(
        filePath: imageFile.path,
        fileBytes: await imageFile.readAsBytes(),
        resourceType: CloudinaryResourceType.image,
        fileName: 'avatar',
      ),
    );

    return response.isSuccessful ? response.secureUrl : null;
  }

  // Lấy thông tin user
  Future<UserInfoResponse> getMe(String jwtToken) async {
    try {
      final response = await dio.get(
        "/users/me?populate[reader][populate]=avatar",
        options: Options(headers: {'Authorization': 'Bearer $jwtToken'}),
      );

      return UserInfoResponse.fromJson(response.data);
    } on DioException catch (_) {
      throw Exception("Failed to load User Data");
    }
  }
}
