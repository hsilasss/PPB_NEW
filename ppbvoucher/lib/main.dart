import 'package:flutter/material.dart';
import 'package:ppbvoucher/EditProfileScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'Homepage.dart';
import 'SplashScreen.dart';
import 'LoginScreen.dart';
import 'SignupScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
      '/login': (context) => const LoginScreen(),
      '/signup': (context) => const SignUpScreen(),
      '/home': (context) => const HomePage(),
      '/EditProfile': (context) => const EditProfileScreen(),
       },
      title: 'reward page',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Poppins',
        scaffoldBackgroundColor: const Color(0xFFF6EFDC),
        primaryColor: const Color(0xFF6B8E5F),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const SplashScreen(),


    );
  }
}

