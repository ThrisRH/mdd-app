import 'package:flutter_dotenv/flutter_dotenv.dart';

final String baseUrlNoUrl = dotenv.env['BASE_URL_WITHOUT_API'] ?? "";
final String baseUrl = dotenv.env['BASE_URL'] ?? "";
