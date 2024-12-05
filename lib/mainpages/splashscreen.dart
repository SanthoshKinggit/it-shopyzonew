// ignore_for_file: use_super_parameters, prefer_const_constructors, prefer_const_literals_to_create_immutables, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:myapp/others/prime.dart';

class TechSplashScreen extends StatefulWidget {
  final String logoPath;
  final Function(BuildContext) onAnimationComplete;

  const TechSplashScreen({
    Key? key,
    required this.logoPath,
    required this.onAnimationComplete,
    required Color primaryColor,
  }) : super(key: key);

  @override
  _TechSplashScreenState createState() => _TechSplashScreenState();
}

class _TechSplashScreenState extends State<TechSplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _mainController;
  late AnimationController _backgroundController;
  late AnimationController _ringController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;
  late Animation<double> _slideAnimation;
  late Animation<double> zoomOutAnimation; // Added animation for zoom-out

  final Color primaryColor = const Color.fromARGB(255, 81, 23, 88);
  final Color accentColor = const Color.fromARGB(255, 81, 23, 88);

  final List<CircleConfig> _circles = [];
  final int numberOfCircles =
      15; // Reduced number of circles for a less complex design

  @override
  void initState() {
    super.initState();
    _generateCircles();

    _mainController = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    );

    _backgroundController = AnimationController(
      duration: const Duration(milliseconds: 10000),
      vsync: this,
    )..repeat();

    _ringController = AnimationController(
      duration: const Duration(milliseconds: 5000),
      vsync: this,
    )..repeat();

    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.2, 0.7, curve: Curves.elasticOut),
      ),
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.4, 0.8, curve: Curves.easeIn),
      ),
    );

    _slideAnimation = Tween<double>(begin: 50.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.2, 0.7, curve: Curves.easeOut),
      ),
    );

    zoomOutAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.6, 1.0, curve: Curves.easeIn),
      ),
    );

    _mainController.forward().then((_) {
      widget.onAnimationComplete(context);
    });
  }

  void _generateCircles() {
    for (int i = 0; i < numberOfCircles; i++) {
      _circles.add(
        CircleConfig(
          angle: (i * 2 * math.pi) / numberOfCircles,
          radius: 100.0, // Reduced radius for simplicity
          size: 5.0 + math.Random().nextDouble() * 5, // Small but visible dots
        ),
      );
    }
  }

  @override
  void dispose() {
    _mainController.dispose();
    _backgroundController.dispose();
    _ringController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary,
      body: AnimatedBuilder(
        animation: _backgroundController,
        builder: (context, child) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [primaryColor, primary],
              ),
            ),
            child: Stack(
              children: [
                // Digital network background with animated lines and nodes
                ...List.generate(10, (index) {
                  // Reduced number of lines for simplicity
                  final random = math.Random(index);
                  return Positioned(
                    left:
                        random.nextDouble() * MediaQuery.of(context).size.width,
                    top: random.nextDouble() *
                        MediaQuery.of(context).size.height,
                    child: AnimatedBuilder(
                      animation: _backgroundController,
                      builder: (context, child) {
                        return Transform.translate(
                          offset: Offset(
                            math.sin(_backgroundController.value * 2 * math.pi +
                                    index) *
                                20,
                            math.cos(_backgroundController.value * 2 * math.pi +
                                    index) *
                                20,
                          ),
                          child: CustomPaint(
                            size: Size(200, 200),
                          ),
                        );
                      },
                    ),
                  );
                }),

                // Main content with rotating circles and logo
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          // Rotating circles animation
                          AnimatedBuilder(
                            animation: _ringController,
                            builder: (context, child) {
                              return Transform.rotate(
                                angle: _ringController.value * 2 * math.pi,
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: _circles.map((circle) {
                                    return Transform.translate(
                                      offset: Offset(
                                        circle.radius * math.cos(circle.angle),
                                        circle.radius * math.sin(circle.angle),
                                      ),
                                      child: Container(
                                        width: circle.size,
                                        height: circle.size,
                                        decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 255, 255, 255),
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              );
                            },
                          ),
                          // Main logo and container
                          AnimatedBuilder(
                            animation: _mainController,
                            builder: (context, child) {
                              return Transform.translate(
                                offset: Offset(0, _slideAnimation.value),
                                child: Transform.scale(
                                  scale: _scaleAnimation.value,
                                  child: Opacity(
                                    opacity: _opacityAnimation.value,
                                    child: Container(
                                      width: 150,
                                      height: 150,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white.withOpacity(0.1),
                                        border: Border.all(
                                          color: Colors.white,
                                          width: 2,
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: primary,
                                            blurRadius: 30,
                                            spreadRadius: 5,
                                          ),
                                        ],
                                      ),
                                      child: Center(
                                        child: SizedBox(
                                          width: 250,
                                          height: 110,
                                          child: Image.asset(
                                            widget.logoPath,
                                            width: 200,
                                            height: 200,

                                            errorBuilder:
                                                (context, error, stackTrace) {
                                              return Icon(
                                                Icons.view_in_ar_rounded,
                                                size: 60,
                                                color: Colors.white,
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 600.0),
                            child: AnimatedBuilder(
                              animation: _mainController,
                              builder: (context, child) {
                                return Opacity(
                                  opacity: _opacityAnimation.value,
                                  child: Column(
                                    children: [
                                      Text(
                                        'ShopyZo',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 28,
                                          fontFamily: 'Nunito',
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 2,
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),

                      // CircularProgressIndicator(
                      //   color: primary,
                      //   backgroundColor: Colors.white,
                      //   strokeWidth: 1.0,
                      // ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class CircleConfig {
  final double angle;
  final double radius;
  final double size;

  CircleConfig({
    required this.angle,
    required this.radius,
    required this.size,
  });
}
