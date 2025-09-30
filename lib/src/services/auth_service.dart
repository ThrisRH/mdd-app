import 'dart:convert';
import 'dart:io';

import 'package:cloudinary_sdk/cloudinary_sdk.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:mddblog/src/models/auth_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

final cloudinary = Cloudinary.full(
  apiKey: dotenv.env['CLOUDINARY_API_KEY']!,
  apiSecret: dotenv.env['CLOUDINARY_API_SECRET']!,
  cloudName: dotenv.env['CLOUDINARY_NAME']!,
);
Future<void> saveJwt(String jwt) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('jwtToken', jwt);
}

Future<String?> loadJwt() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('jwtToken');
}

Future<void> removeJwt() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('jwtToken');
}

class AuthenticationService {
  final String baseUrl = dotenv.env['BASE_URL'] ?? "";

  static Future<bool> isLoggedIn() async {
    // Lấy token từ SharedPreferences
    final token = await loadJwt();
    return token != null;
  }

  // Đăng nhập
  Future<bool> signIn(String identifier, String password) async {
    final url = Uri.parse("$baseUrl/auth/local");
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'identifier': identifier,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final jwt = data['jwt'];
      await saveJwt(jwt);
      return true;
    } else {
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
      // B1: Tạo User
      final registerUrl = Uri.parse("$baseUrl/auth/local/register");
      final registerResponse = await http.post(
        registerUrl,
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode({
          'username': username,
          'email': email,
          'password': password,
        }),
      );

      final registerData = jsonDecode(registerResponse.body);

      if (registerResponse.statusCode < 200 ||
          registerResponse.statusCode >= 300) {
        return {
          "success": false,
          "error": registerData["error"]?["message"] ?? "Đăng ký thất bại",
        };
      }

      final userId = registerData['user']['id'];

      // B2: Tạo Reader và liên kết với User vừa tạo
      final readerUrl = Uri.parse("$baseUrl/readers");
      final readerResponse = await http.post(
        readerUrl,
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode({
          "data": {
            "Fullname": fullname,
            "avatarCloudUrl": avatarUrl,
            "users_permissions_user": userId,
          },
        }),
      );

      final readerData = jsonDecode(readerResponse.body);

      if (readerResponse.statusCode >= 200 && readerResponse.statusCode < 300) {
        return {"success": true, "data": readerData};
      } else {
        return {
          "success": false,
          "error": readerData["error"]?["message"] ?? "Tạo Reader thất bại",
        };
      }
    } catch (e) {
      return {"success": false, "error": e.toString()};
    }
  }

  Future<String?> uploadToCloudinary(File imageFile) async {
    final response = await cloudinary.uploadResource(
      CloudinaryUploadResource(
        filePath: imageFile.path,
        fileBytes: await imageFile.readAsBytes(),
        resourceType: CloudinaryResourceType.image,
        fileName: 'avatar',
      ),
    );

    if (response.isSuccessful) {
      return response.secureUrl;
    } else {
      return null;
    }
  }

  // Hàm Get Me
  Future<UserInfoResponse> getMe(String jwtToken) async {
    final url = Uri.parse(
      "$baseUrl/users/me?populate[reader][populate]=avatar",
    );
    final response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $jwtToken',
      },
    );

    if (response.statusCode >= 200 && response.statusCode < 300) {
      final Map<String, dynamic> jsonData = json.decode(response.body);
      return UserInfoResponse.fromJson(jsonData);
    } else {
      throw Exception('Failed to load User Data');
    }
  }
}
