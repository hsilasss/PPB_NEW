import 'package:flutter/material.dart';
import 'package:ppbvoucher/EditProfileScreen.dart';
import 'Homepage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
      '/EditProfile': (context) => const EditProfileScreen(),
       },
      title: 'reward page',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Poppins',
        scaffoldBackgroundColor: const Color(0xFFF6EFDC),
        primaryColor: const Color(0xFF3BB54A),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const HomePage(),
    );
  }
}

