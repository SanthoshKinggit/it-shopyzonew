// ignore_for_file: prefer_const_constructors, unused_element, unused_import

import 'package:flutter/material.dart';
import 'package:myapp/homepage.dart';
import 'package:myapp/others/forgot.dart';
import 'package:myapp/indicator.dart';
import 'package:myapp/setfinger.dart';
import 'package:myapp/mainpages/pingenerator.dart';
import 'package:myapp/others/prime.dart';
import 'package:myapp/others/profile.dart';
import 'package:myapp/mainpages/step.dart';

class Homepage0 extends StatefulWidget {
  const Homepage0({super.key});

  @override
  State<Homepage0> createState() => _Homepage0State();
}

class _Homepage0State extends State<Homepage0> {
  // Add controllers for text fields
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _rememberMe = false;
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    // Clean up controllers when the widget is disposed
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Get the screen size
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = MediaQuery.of(context).size.width * 0.90;
    final screenHeight = MediaQuery.of(context).size.height * 0.90;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.06, // Responsive horizontal padding
              // Responsive vertical padding
            ),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: screenHeight * 0.03),

                  // Back Button
                  Row(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: IconButton(
                          icon: Icon(Icons.arrow_back_ios),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.03),

                  // Title
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Login to\nAccount',
                      style: TextStyle(
                        fontSize: screenWidth * 0.08,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Nunito',
                        height: 1.2,
                      ),
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.05),
                  // Email TextField
                  _buildTextField(
                    controller: _emailController,
                    hintText: 'Email',
                    prefixIcon: Icons.email_outlined,
                    keyboardType: TextInputType.emailAddress,
                    validator: _isEmailValid,
                    screenWidth: screenWidth,
                  ),

                  SizedBox(height: screenHeight * 0.04),

                  // Password TextField
                  _buildTextField(
                    controller: _passwordController,
                    hintText: 'Password',
                    prefixIcon: Icons.lock_outline,
                    obscureText: !_isPasswordVisible,
                    validator: _isPasswordValid,
                    screenWidth: screenWidth,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordVisible
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        color: Colors.grey[500],
                      ),
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.03),

                  // Remember me checkbox
                  Row(
                    children: [
                      Checkbox(
                        value: _rememberMe,
                        onChanged: (value) {
                          setState(() {
                            _rememberMe = value ?? false;
                          });
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(33),
                        ),
                        side: BorderSide(color: Colors.grey[500]!),
                      ),
                      Text(
                        'Remember me',
                        style: TextStyle(
                          fontFamily: 'Nunito',
                          color: Colors.grey[600],
                          fontSize: screenWidth * 0.035,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: screenHeight * 0.04),

                  // Sign up button
                  SizedBox(
                    width: double.infinity,
                    height: screenHeight * 0.07,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (_) => PaymentApp()),
                        );

                        final snackBar = SnackBar(
                          content: Center(child: Text('Login Successful')),
                          backgroundColor: primary, // Background color
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                33.0), // Apply border radius
                          ),

                          behavior: SnackBarBehavior
                              .floating, // Make the SnackBar floating
                          margin: EdgeInsets.symmetric(
                              horizontal: 80.0,
                              vertical: 10.0), // Margin to center it
                          duration:
                              Duration(seconds: 3), // Snackbar display duration
                        );

                        ScaffoldMessenger.of(context)
                            .showSnackBar(snackBar); // Show the Snackbar
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(33),
                        ),
                        // Add disabled state styling
                      ),
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          fontFamily: 'Nunito',
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),

                  TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PinInputScreen()),
                        );
                      },
                      child: Text(
                        'Forgot Password?',
                        style: TextStyle(
                          fontFamily: 'Nunito',
                          color: primary,
                          fontSize: screenSize.width * 0.035,
                        ),
                      )),
                  const SizedBox(height: 22),
                  Center(
                    child: Text(
                      'or continue with',
                      style: TextStyle(
                        fontFamily: 'Nunito',
                        color: const Color.fromARGB(255, 85, 85, 85),
                        fontSize: screenSize.width * 0.035,
                      ),
                    ),
                  ),
                  const SizedBox(height: 22),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.network(
                        'https://upload.wikimedia.org/wikipedia/commons/6/6c/Facebook_Logo_2023.png',
                        height: screenSize.width * 0.063,
                      ),
                      Image.asset(
                        'assets/logo/Google_Icons-09-512.webp',
                        height: screenSize.width * 0.1,
                      ),
                      Image.asset(
                        'assets/logo/apple-logo-transparent.png',
                        height: screenSize.width * 0.08,
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),

                  Center(
                    child: InkWell(
                      onTap: () {
                        // Add sign in navigation logic here
                      },
                      child: RichText(
                        text: TextSpan(
                          text: "Already have an account? ",
                          style: TextStyle(
                            fontFamily: 'Nunito',
                            color: Colors.grey[600],
                            fontSize: screenSize.width * 0.035,
                          ),
                          children: const [
                            TextSpan(
                              text: "Sign in",
                              style: TextStyle(
                                fontFamily: 'Nunito',
                                color: primary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData prefixIcon,
    required bool Function(String) validator,
    required double screenWidth,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
    Widget? suffixIcon,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      cursorColor: Colors.black,
      onChanged: (value) {
        setState(() {}); // Rebuild to show validation
      },
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.grey[400],
          fontFamily: 'Nunito',
          fontSize: screenWidth * 0.04,
        ),
        prefixIcon: Icon(
          prefixIcon,
          color: Colors.grey[500],
        ),
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(33),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: const Color.fromARGB(255, 255, 255, 255),
        // errorText: validator(controller.text) ? null : _getErrorText(hintText),
      ),
    );
  }

  // Validation methods
  bool _isEmailValid(String email) {
    if (email.isEmpty) return true; // Don't show error for empty field
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  bool _isPasswordValid(String password) {
    if (password.isEmpty) return true; // Don't show error for empty field
    return password.length >= 6;
  }

  bool _isFormValid() {
    return _isEmailValid(_emailController.text) &&
        _isPasswordValid(_passwordController.text) &&
        _emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty;
  }

  bool _canSubmit() {
    return _emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty;
  }
}
