// ignore_for_file: unnecessary_import, library_private_types_in_public_api, use_build_context_synchronously

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thrift_pantry/pages/welcome/introduction_animation_screen.dart';
import 'package:thrift_pantry/provider/farm_cart_provider.dart';
import 'package:thrift_pantry/provider/receipt_provider.dart';
import 'package:thrift_pantry/theme/dark_mode.dart';
import 'package:thrift_pantry/theme/light_mode.dart';
import 'package:thrift_pantry/theme/theme_provider.dart';
import 'pages/home_page.dart';
import 'provider/cart_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CartModel()),
        ChangeNotifierProvider(create: (context) => ReceiptModel()),
        ChangeNotifierProvider(create: (context) => FarmCartProvider()),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Check if the user is signed in
    final user = FirebaseAuth.instance.currentUser;
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeProvider.isDarkMode ? darkmode : lightmode,
      home: user != null ? HomePage() : const SplashScreen(), // Start from HomePage or SplashScreen
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Navigate to the IntroductionAnimationScreen after a delay
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const IntroductionAnimationScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(
          'assets/splash_animation.gif', // Load GIF from assets
          fit: BoxFit.contain, // Adjust this if needed
        ),
      ),
    );
  }
}
