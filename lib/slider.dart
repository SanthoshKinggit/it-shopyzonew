// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myapp/others/prime.dart';
import 'package:myapp/signup.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with TickerProviderStateMixin {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  // Animation controllers
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late AnimationController _scaleController;
  late AnimationController _buttonController;

  // Animations
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> buttonScaleAnimation;
  late Animation<double> _buttonFadeAnimation;

  final List<Map<String, dynamic>> _contents = [
    {
      'title': 'Order',
      'description':
          'The best app for finance, banking, & e-wallet          today',
      'image': 'assets/logo/5865172.jpg',
      'gradient': [
        Color.fromARGB(255, 255, 255, 255),
        Color.fromARGB(255, 255, 255, 255),
      ],
    },
    {
      'title': 'Shop',
      'description': 'Have an amazing experience with Allpay right now!',
      'image': 'assets/logo/9010415.jpg',
      'gradient': [
        Color.fromARGB(255, 255, 255, 255),
        Color.fromARGB(255, 255, 255, 255),
      ],
    },
    {
      'title': 'Fast Payment',
      'description': 'Manage finances easily with secure and Fast payments',
      'image': 'assets/logo/6036950.jpg',
      'gradient': [
        Color.fromARGB(255, 255, 255, 255),
        Color.fromARGB(255, 255, 255, 255),
      ],
    },
  ];

  @override
  void initState() {
    super.initState();

    // Initialize animation controllers
    _fadeController = AnimationController(
      duration: Duration(milliseconds: 1000),
      vsync: this,
    );

    _slideController = AnimationController(
      duration: Duration(milliseconds: 1000),
      vsync: this,
    );

    _scaleController = AnimationController(
      duration: Duration(milliseconds: 1200),
      vsync: this,
    );

    _buttonController = AnimationController(
      duration: Duration(milliseconds: 800),
      vsync: this,
    );

    // Setup animations
    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeOut,
    );

    _slideAnimation = Tween<Offset>(
      begin: Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOutCubic,
    ));

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _scaleController,
      curve: Curves.easeOutBack,
    ));

    buttonScaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _buttonController,
      curve: Curves.elasticOut,
    ));

    _buttonFadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _buttonController,
      curve: Interval(0.4, 1.0, curve: Curves.easeOut),
    ));

    // Start initial animations
    Future.delayed(Duration(milliseconds: 100), () {
      _fadeController.forward();
      _slideController.forward();
      _scaleController.forward();
      _buttonController.forward();
    });
  }

  void _animateToNextPage() {
    // Reset animations
    _fadeController.reset();
    _slideController.reset();
    _scaleController.reset();

    // Animate to next page
    if (_currentIndex < _contents.length - 1) {
      _pageController.nextPage(
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }

    // Start animations for new page
    Future.delayed(Duration(milliseconds: 100), () {
      _fadeController.forward();
      _slideController.forward();
      _scaleController.forward();
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _fadeController.dispose();
    _slideController.dispose();
    _scaleController.dispose();
    _buttonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Get screen size for responsive design
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: AnimatedContainer(
          duration: Duration(milliseconds: 500),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: _contents[_currentIndex]['gradient'],
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                // Skip Button
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.04,
                    vertical: screenHeight * 0.01,
                  ),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: ScaleTransition(
                      scale: buttonScaleAnimation,
                      child: SizedBox(
                        height: 46,
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen()));
                          },
                          child: Text(
                            'Skip',
                            style: TextStyle(
                              fontFamily: 'Nunito',
                              color: primary,
                              fontSize: screenWidth * 0.045,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                // Onboarding Content
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: (index) {
                      setState(() {
                        _currentIndex = index;
                        _fadeController.reset();
                        _fadeController.forward();
                        _slideController.reset();
                        _slideController.forward();
                        _scaleController.reset();
                        _scaleController.forward();
                      });
                    },
                    itemCount: _contents.length,
                    itemBuilder: (context, index) {
                      return FadeTransition(
                        opacity: _fadeAnimation,
                        child: SlideTransition(
                          position: _slideAnimation,
                          child: ScaleTransition(
                            scale: _scaleAnimation,
                            child: OnboardingContent(
                              title: _contents[index]['title'],
                              description: _contents[index]['description'],
                              image: _contents[index]['image'],
                              screenWidth: screenWidth,
                              screenHeight: screenHeight,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                // Bottom Navigation and Button
                ScaleTransition(
                  scale: buttonScaleAnimation,
                  child: FadeTransition(
                    opacity: _buttonFadeAnimation,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.05,
                        vertical: screenHeight * 0.03,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Page Indicator
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              _contents.length,
                              (index) => TweenAnimationBuilder(
                                duration: Duration(milliseconds: 300),
                                tween: Tween<double>(
                                  begin: 0.0,
                                  end: _currentIndex == index ? 1.0 : 0.5,
                                ),
                                builder: (context, double value, child) {
                                  return Container(
                                    margin: EdgeInsets.symmetric(horizontal: 4),
                                    height: 8,
                                    width: _currentIndex == index ? 24 : 8,
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(value),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),

                          // Next/Get Started Button
                          SizedBox(
                            width: screenWidth * 0.8,
                            height: screenHeight * 0.07,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: primary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(28),
                                ),
                                elevation: 8,
                              ),
                              onPressed: () {
                                if (_currentIndex == _contents.length - 1) {
                                  Navigator.pushReplacement(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder: (context, animation,
                                              secondaryAnimation) =>
                                          LoginScreen(),
                                    ),
                                  );
                                } else {
                                  // Added the method to animate to the next page
                                  _animateToNextPage();
                                }
                              },
                              child: Text(
                                _currentIndex == _contents.length - 1
                                    ? 'Get Started'
                                    : 'Next',
                                style: TextStyle(
                                  fontFamily: 'Nunito',
                                  color: Colors.white,
                                  fontSize: screenWidth * 0.05,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.03),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class OnboardingContent extends StatelessWidget {
  final String title;
  final String description;
  final String image;
  final double screenWidth;
  final double screenHeight;

  const OnboardingContent({
    super.key,
    required this.title,
    required this.description,
    required this.image,
    required this.screenWidth,
    required this.screenHeight,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Responsive Image
          Image.asset(
            image,
            height: screenHeight * 0.35,
            width: screenWidth * 0.97,
            fit: BoxFit.contain,
          ),
          SizedBox(height: screenHeight * 0.03),

          // Title and Description
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
            child: Column(
              children: [
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: primary,
                    fontSize: screenWidth * 0.08,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                    fontFamily: 'Nunito',
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                Text(
                  description,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: primary,
                    fontSize: screenWidth * 0.07,
                    height: 1.5,
                    fontFamily: 'Nunito',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
