// ignore_for_file: unused_import, use_super_parameters, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:myapp/account/accountacreate.dart';
import 'package:myapp/account/createac.dart';
import 'package:myapp/others/login.dart';
import 'package:myapp/others/prime.dart';
import 'package:myapp/pages/signin.dart';

import 'others/primarycolor.dart';
import 'slider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    // Get screen size for responsive design
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => OnboardingScreen()));}
        ),
      ),
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: screenHeight,
            minWidth: screenWidth,
          ),
          child: IntrinsicHeight(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.06, // Responsive horizontal padding
                vertical: screenHeight * 0.00, // Responsive vertical padding
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Back Button

                  // Logo

                  Image.asset(
                    'assets/logo/6333204.jpg',
                    height: screenHeight * 0.25,
                    width: screenWidth * 0.8,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(height: screenHeight * 0.04),

                  // Title
                  Text(
                    'Login with',
                    style: TextStyle(
                      fontFamily: 'Nunito',
                      fontSize: screenWidth * 0.07,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.04),

                  // Social Login Buttons
                  _buildSocialLoginButton(
                    context,
                    'https://upload.wikimedia.org/wikipedia/commons/6/6c/Facebook_Logo_2023.png',
                    'Continue with Facebook',
                    isNetwork: true,
                  ),

                  SizedBox(height: screenHeight * 0.01),

                  _buildSocialLoginButton(
                    context,
                    'assets/logo/Google_Icons-09-512.webp',
                    'Continue with Google',
                  ),

                  SizedBox(height: screenHeight * 0.01),

                  _buildSocialLoginButton(
                    context,
                    'assets/logo/apple-logo-transparent.png',
                    'Continue with Apple',
                  ),

                  SizedBox(height: screenHeight * 0.04),

                  // Divider
                  Row(
                    children: [
                      Expanded(child: Divider(color: Colors.grey)),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.03),
                        child: Text(
                          'or',
                          style: TextStyle(
                            fontFamily: 'Nunito',
                            fontSize: screenWidth * 0.04,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Expanded(child: Divider(color: Colors.grey)),
                    ],
                  ),

                  SizedBox(height: screenHeight * 0.03),

                  // Sign In Button
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Signinscreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primary,
                      minimumSize: Size(screenWidth * 0.9, screenHeight * 0.07),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(33),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      'Sign in',
                      style: TextStyle(
                        fontFamily: 'Nunito',
                        fontSize: screenWidth * 0.045,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.02),

                  // Sign Up Text
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don\'t have an account?',
                        style: TextStyle(
                          fontFamily: 'Nunito',
                          fontSize: screenWidth * 0.035,
                          color: Colors.black,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Homepage1()),
                          );
                        },
                        child: Text(
                          'Sign up',
                          style: TextStyle(
                            fontFamily: 'Nunito',
                            fontSize: screenWidth * 0.035,
                            color: primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Helper method to build social login buttons
  Widget _buildSocialLoginButton(
      BuildContext context, String imagePath, String text,
      {bool isNetwork = false}) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen2()),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 247, 247, 247),
        minimumSize: Size(screenWidth * 0.9, screenHeight * 0.07),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(33),
        ),
        elevation: 0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          isNetwork
              ? Image.network(imagePath, height: screenHeight * 0.035)
              : Image.asset(imagePath, height: screenHeight * 0.035),
          SizedBox(width: screenWidth * 0.03),
          Text(
            text,
            style: TextStyle(
              fontFamily: 'Nunito',
              fontSize: screenWidth * 0.04,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
