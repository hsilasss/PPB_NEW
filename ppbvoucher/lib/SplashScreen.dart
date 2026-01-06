import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const BouncingScrollPhysics(), // Smooth scroll
        onPageChanged: (index) {
          setState(() {
            _currentPage = index;
          });
          // Navigate to SignUpScreen when swiped to second page
          if (index == 1) {
            Future.delayed(const Duration(milliseconds: 300), () {
              Navigator.of(context).pushReplacementNamed('/signup');
            });
          }
        },
        children: [
          // First Screen - Dark Green
          _buildSplashPage(
            backgroundColor: const Color(0xFF6B8E5F),
            logoType: 'putih',
            textColor: Colors.white,
            canGoBack: false,
            onSwipe: () {
              _pageController.nextPage(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              );
            },
          ),
          // Second Screen - Light Cream
          _buildSplashPage(
            backgroundColor: const Color(0xFFFFF8F0),
            logoType: 'hijau',
            textColor: const Color(0xFF6B8E5F),
            canGoBack: true,
            onSwipe: () {
              _pageController.nextPage(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSplashPage({
    required Color backgroundColor,
    required String logoType,
    required Color textColor,
    required bool canGoBack,
    required VoidCallback onSwipe,
  }) {
    return Container(
      color: backgroundColor,
      child: Stack(
        children: [
          // Back button (hanya di halaman kedua)
          if (canGoBack)
            Positioned(
              top: 40,
              left: 20,
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: textColor,
                  size: 28,
                ),
                onPressed: () {
                  _pageController.previousPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
              ),
            ),
          // Main content - bisa di-tap untuk swipe
          GestureDetector(
            onTap: (){
              onSwipe();
            },
            onHorizontalDragEnd: (details) {
              // Swipe ke kiri (negative velocity)
              if (details.primaryVelocity != null &&
                  details.primaryVelocity! < 0) {
                onSwipe();
              }
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo
                Center(
                  child: Column(
                    children: [
                      const SizedBox(height: 32),
                      Text(
                        'GREEN TRACK',
                        style: TextStyle(
                          color: textColor,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Swipe indicator at bottom
          if (_currentPage == 0)
            Positioned(
              bottom: 60,
              left: 0,
              right: 0,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.arrow_forward,
                      color: textColor,
                      size: 28,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'Swipe to continue',
                      style: TextStyle(
                        color: textColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
