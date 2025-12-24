import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mddblog/app.dart';

Future<void> main() async {
  const env = String.fromEnvironment('FLAVOR', defaultValue: 'production');

  await dotenv.load(fileName: ".env.$env");

  runApp(const App());
}
