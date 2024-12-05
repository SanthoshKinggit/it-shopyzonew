// ignore_for_file: unused_import, use_super_parameters, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:myapp/account/accountacreate.dart';
import 'package:myapp/mainpages/pingenerator.dart';
import 'package:myapp/mainpages/step.dart';


class LoginScreen2 extends StatefulWidget {
  const LoginScreen2({Key? key}) : super(key: key);

  @override
  State<LoginScreen2> createState() => _LoginScreen2State();
}

class _LoginScreen2State extends State<LoginScreen2> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: screenHeight,
              minWidth: screenWidth,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: screenHeight * 0.05),
                
                Text(
                  'Please login to continue',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.black87,
                    fontSize: screenWidth * 0.04,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                
                SizedBox(height: screenHeight * 0.05),
                
                // Email TextField
                _buildTextField(
                  context, 
                  hintText: 'email@address.com', 
                  icon: Icons.person_outline,
                ),
                
                SizedBox(height: screenHeight * 0.02),
                
                // Password TextField
                _buildTextField(
                  context, 
                  hintText: 'password', 
                  icon: Icons.lock_outline,
                  isPassword: true,
                ),
                
                SizedBox(height: screenHeight * 0.03),
                
                // Sign In Button
                _buildSignInButton(context),
                
                SizedBox(height: screenHeight * 0.03),
                
                _buildDividerText(),
                
                SizedBox(height: screenHeight * 0.02),
                
                _buildSocialLogins(screenWidth),
                
                SizedBox(height: screenHeight * 0.02),
                
                _buildCreateAccountRow(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(BuildContext context, {
    required String hintText, 
    required IconData icon, 
    bool isPassword = false,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.06),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(30),
        ),
        child: TextField(
          obscureText: isPassword ? _obscureText : false,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(fontFamily: 'Poppins'),
            prefixIcon: Icon(icon, color: const Color(0xFF0A1F44)),
            suffixIcon: isPassword 
              ? IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                    color: const Color(0xFF0A1F44),
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                )
              : null,
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 16,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSignInButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.06),
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PinInputScreen()),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 145, 255, 149),
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          elevation: 0,
        ),
        child: const Text(
          'Log In',
          style: TextStyle(
            fontSize: 17,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w800,
            color: Color(0xFF0A1F44),
          ),
        ),
      ),
    );
  }

  Widget _buildDividerText() {
    return Center(
      child: Text(
        'or continue with',
        style: TextStyle(
          color: Colors.grey[600],
          fontSize: 14,
        ),
      ),
    );
  }

  Widget _buildSocialLogins(double screenWidth) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/logo/Google_Icons-09-512.webp',
          height: screenWidth * 0.1,
        ),
        SizedBox(width: screenWidth * 0.1),
        Image.asset(
          'assets/logo/apple-logo-transparent.png',
          height: screenWidth * 0.08,
        ),
      ],
    );
  }

  Widget _buildCreateAccountRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Dont have an account?',
          style: TextStyle(
            fontFamily: 'Poppins',
            color: Colors.black87,
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SignUpScreen()),
            );
          },
          child: const Text(
            'Create one',
            style: TextStyle(
              fontFamily: 'Poppins',
              color: Color(0xFF0A1F44),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}