import 'package:dio/dio.dart';
import 'package:mddblog/config/api.dart';

class ApiClient {
  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: Duration(seconds: 15),
      receiveTimeout: Duration(seconds: 15),
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
    ),
  );
}
