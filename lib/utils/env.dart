import 'package:flutter_dotenv/flutter_dotenv.dart';

class Env {
  static final String appEnv = dotenv.env['APP_ENV'] ?? 'development';

  static bool get isDev => appEnv == 'development';
  static bool get isProd => appEnv == 'production';
}
