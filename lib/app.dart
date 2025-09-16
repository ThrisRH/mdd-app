import 'package:flutter/material.dart';
import 'package:mddblog/src/views/about/about.dart';
import 'package:mddblog/src/views/faq/faq.dart';
import 'package:mddblog/src/views/home/home.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/home',
      routes: {
        '/home': (context) => const Home(),
        '/about': (context) => const About(),
        // '/topics': (context) => const TopicsView(),
        '/faq': (context) => const FAQ(),
      },
    );
  }
}
