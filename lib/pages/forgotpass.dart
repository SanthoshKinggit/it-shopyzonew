// ignore_for_file: unused_field, use_super_parameters, library_private_types_in_public_api, prefer_final_fields

import 'package:flutter/material.dart';
import 'dart:async';

import '../others/prime.dart'; // Ensure this import is correct

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _mobileNumberController = TextEditingController();
  final _otpController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  String _mobileNumber = '';
  String _otp = '';
  bool _showOTPField = false;
  bool _isOTPSent = false;
  int _otpExpirationTimer = 60;

  bool _isNewPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  late AnimationController _animationController;
  late Animation<double> _formAnimation;

  // Use color from prime.dart consistently
  final Color _primaryColor = primary;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _formAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOutBack,
    );
  }

  Future<void> _sendOTP() async {
    if (_formKey.currentState!.validate()) {
      try {
        // Simulated OTP sending - replace with actual API call
        await _simulateSendOTP(_mobileNumberController.text);
        
        setState(() {
          _showOTPField = true;
          _isOTPSent = true;
          _startOTPExpirationTimer();
          _animationController.forward();
        });
      } catch (e) {
        _showErrorSnackBar('Failed to send OTP. Please try again.');
      }
    }
  }

  Future<void> _simulateSendOTP(String mobileNumber) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 2));
    // In a real app, implement actual OTP sending logic
  }

  void _startOTPExpirationTimer() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_otpExpirationTimer > 0) {
          _otpExpirationTimer--;
        } else {
          timer.cancel();
          _isOTPSent = false;
        }
      });
    });
  }

  void _resetPassword() {
    if (_formKey.currentState!.validate()) {
      try {
        // Implement actual password reset logic
        _showSuccessSnackBar('Password reset successful!');
        Navigator.pushReplacementNamed(context, '/login');
      } catch (e) {
        _showErrorSnackBar('Password reset failed. Please try again.');
      }
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  void _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: _primaryColor,
      ),
    );
  }

  InputDecoration _buildInputDecoration({
    required String hintText,
    required IconData iconData,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(
        color: Colors.grey[400],
        fontFamily: 'Nunito',
        fontSize: 22,
      ),
      prefixIcon: Icon(
        iconData,
        color: _primaryColor,
      ),
      suffixIcon: suffixIcon,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide.none,
      ),
      filled: true,
      fillColor: Colors.white,
    );
  }

  @override
  void dispose() {
    _mobileNumberController.dispose();
    _otpController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: _primaryColor,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
        title: const Text(
          'Forgot Password',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Nunito',
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset('assets/logo/apple-logo-transparent.png', height: 90),
                const SizedBox(height: 32.0),

                // Mobile Number Field
                TextFormField(
                  controller: _mobileNumberController,
                  keyboardType: TextInputType.phone,
                  cursorColor: _primaryColor,
                  style: TextStyle(
                    color: _primaryColor,
                    fontFamily: 'Nunito',
                    fontSize: 16,
                  ),
                  decoration: _buildInputDecoration(
                    hintText: 'Enter Mobile Number',
                    iconData: Icons.phone,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your mobile number';
                    }
                    // Add more robust phone number validation if needed
                    return null;
                  },
                  onSaved: (value) => _mobileNumber = value ?? '',
                ),

                // OTP and Password Fields (when OTP is sent)
                if (_isOTPSent) ...[
                  const SizedBox(height: 16.0),
                  TextFormField(
                    controller: _otpController,
                    keyboardType: TextInputType.number,
                    cursorColor: _primaryColor,
                    style: TextStyle(
                      color: _primaryColor,
                      fontFamily: 'Nunito',
                      fontSize: 16,
                    ),
                    decoration: _buildInputDecoration(
                      hintText: 'Enter OTP',
                      iconData: Icons.security,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the OTP';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    'OTP expires in $_otpExpirationTimer seconds',
                    style: TextStyle(
                      color: _primaryColor.withOpacity(0.7),
                      fontFamily: 'Nunito',
                      fontSize: 14,
                    ),
                  ),

                  // New Password Fields
                  const SizedBox(height: 16.0),
                  TextFormField(
                    controller: _newPasswordController,
                    obscureText: !_isNewPasswordVisible,
                    cursorColor: _primaryColor,
                    style: TextStyle(
                      color: _primaryColor,
                      fontFamily: 'Nunito',
                      fontSize: 16,
                    ),
                    decoration: _buildInputDecoration(
                      hintText: 'New Password',
                      iconData: Icons.lock_outline,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isNewPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: _primaryColor,
                        ),
                        onPressed: () {
                          setState(() {
                            _isNewPasswordVisible = !_isNewPasswordVisible;
                          });
                        },
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a new password';
                      }
                      if (value.length < 8) {
                        return 'Password must be at least 8 characters';
                      }
                      // Add more password complexity checks if needed
                      return null;
                    },
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    controller: _confirmPasswordController,
                    obscureText: !_isConfirmPasswordVisible,
                    cursorColor: _primaryColor,
                    style: TextStyle(
                      color: _primaryColor,
                      fontFamily: 'Nunito',
                      fontSize: 16,
                    ),
                    decoration: _buildInputDecoration(
                      hintText: 'Confirm New Password',
                      iconData: Icons.lock,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isConfirmPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: _primaryColor,
                        ),
                        onPressed: () {
                          setState(() {
                            _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                          });
                        },
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please confirm your new password';
                      }
                      if (value != _newPasswordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),
                ],

                const SizedBox(height: 32.0),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isOTPSent ? _resetPassword : _sendOTP,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _primaryColor,
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(33),
                      ),
                    ),
                    child: Text(
                      _isOTPSent ? 'Reset Password' : 'Send OTP',
                      style: const TextStyle(
                        color: Colors.white,
                        fontFamily: 'Nunito',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
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