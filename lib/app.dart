import 'package:flutter/material.dart';
import 'package:mddblog/src/views/faq/faq.dart';
import 'package:mddblog/src/views/home/home.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/home',
      routes: {
        '/home': (context) => const HomePage(),
        // '/about': (context) => const AboutView(),
        // '/topics': (context) => const TopicsView(),
        '/faq': (context) => const FAQ(),
      },
    );
  }
}
