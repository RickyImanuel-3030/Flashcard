import 'package:flutter/material.dart';
import 'home_page.dart';
import 'flash_learn_page.dart';
import 'quiz_page.dart';
import 'html_basic_page.dart';
import 'text_format_page.dart';
import 'link_image_page.dart';

void main() {
  runApp(const FlashLearnApp());
}

class FlashLearnApp extends StatelessWidget {
  const FlashLearnApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: ' ',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
      
      routes: {
        '/home': (context) => const HomePage(),
        '/flashlearn': (context) => const FlashLearnPage(),
        '/quiz': (context) => const QuizPage(),
        '/html_basic': (context) => const HtmlBasicPage(),
        '/text_format': (context) => const TextFormatPage(),
        '/link_image': (context) => const LinkImagePage(),
      }
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
 @override
void initState() {
  super.initState();
  Future.delayed(const Duration(seconds: 3), () {
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    }
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Gambar Splash (logo aplikasi)
            Image.asset(
              "assets/image.png", // pastikan path sesuai
              width: 200,
            ),
            const SizedBox(height: 20),
            const Text(
              " ",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Belajar HTML dengan Flashcard",
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
