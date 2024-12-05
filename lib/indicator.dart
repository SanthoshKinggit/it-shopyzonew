// ignore_for_file: use_key_in_widget_constructors, no_leading_underscores_for_local_identifiers, unused_element, use_super_parameters, unused_import, prefer_const_constructors

import 'dart:async';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myapp/loginpage.dart';
import 'package:myapp/mainpages/pingenerator.dart';
import 'package:myapp/others/prime.dart';

class AlertBoxScreen extends StatefulWidget {
  @override
  State<AlertBoxScreen> createState() => _AlertBoxScreenState();
}

class _AlertBoxScreenState extends State<AlertBoxScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    // Create an animation controller for the dots
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();
  String? _imageUrl;
  String? _fullName;
  String? _nickname;
  String? _email;
  String _countryCode = '+1';
  String? _phoneNumber;
  DateTime? _selectedDate;

  Future<void> _openCalendar(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _imageUrl = image.path;
      });
    }
  }

  void _handleSubmit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

    }
  }

  @override
  Widget build(BuildContext context) {
    // Get the screen size
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Responsive sizing
    double profileImageSize = screenWidth * 0.25; // 25% of screen width
    double spacingFactor =
        screenHeight * 0.02; // 2% of screen height for spacing

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        
        title: Text(
          'Fill Your Profile',
          style: TextStyle(
            fontSize: screenWidth * 0.06, // Responsive font size
            fontFamily: 'Nunito',
            fontWeight: FontWeight.bold,
            color: const Color.fromARGB(255, 0, 0, 0),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: const Color.fromARGB(255, 0, 0, 0),
            size: screenWidth * 0.05, // Responsive icon size
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.05, vertical: screenHeight * 0.02),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: constraints.maxWidth,
              ),
              child: IntrinsicHeight(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Profile Image
                      Center(
                        child: Stack(
                          children: [
                            Container(
                              width: profileImageSize,
                              height: profileImageSize,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                shape: BoxShape.circle,
                              ),
                              child: _imageUrl != null
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: Image.asset(
                                        _imageUrl!,
                                        fit: BoxFit.cover,
                                        width: profileImageSize,
                                        height: profileImageSize,
                                      ),
                                    )
                                  : Icon(Icons.person,
                                      size: profileImageSize * 0.5,
                                      color: Colors.grey),
                            ),
                            Positioned(
                              right: 0,
                              bottom: 0,
                              child: GestureDetector(
                                onTap: _pickImage,
                                child: Container(
                                  padding: EdgeInsets.all(screenWidth * 0.01),
                                  decoration: BoxDecoration(
                                    color: primary,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: Colors.white, width: 2),
                                  ),
                                  child: Icon(
                                    Icons.edit,
                                    size: screenWidth * 0.04,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: spacingFactor * 1.5),
                      // Form Fields with Responsive Sizing
                      _buildResponsiveTextField(
                        context,
                        labelText: '  First Name',
                        onSaved: (value) => _fullName = value,
                        validator: (value) => value?.isEmpty ?? true
                            ? 'Please enter your full name'
                            : null,
                      ),
                      SizedBox(height: spacingFactor),
                      _buildResponsiveTextField(
                        context,
                        labelText: '  last Name',
                        onSaved: (value) => _nickname = value,
                      ),
                      SizedBox(height: spacingFactor),
                      GestureDetector(
                        onTap: () => _openCalendar(context),
                        child: Container(
                          height: 60,
                          width: 370,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(33),
                              color: Colors.grey[50]),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              '    Date of Birth',
                              style: TextStyle(
                                color: const Color.fromARGB(255, 85, 85, 85),
                                  fontFamily: 'Nunito',
                                  fontSize: screenWidth * 0.04),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: spacingFactor),
                      _buildResponsiveTextField(
                        context,
                        labelText: '  Email',
                        obscureText: true,
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return 'Please enter your password';
                          }
                          if (value!.length < 6) {
                            return 'Password must be at least 6 characters';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: spacingFactor),
                      // Phone Number with Responsive Country Code Picker
                      _buildPhoneNumberField(context, spacingFactor),
                      SizedBox(height: screenHeight * 0.04),

                      const Text(
                        "Don't worry, you can always change it later",
                        style: TextStyle(
                          fontFamily: 'Nunito',
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: screenHeight * 0.04),
                      // Continue Button
                      _buildContinueButton(context),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

// Helper method for creating responsive text fields
  Widget _buildResponsiveTextField(
    BuildContext context, {
    required String labelText,
    TextInputType? keyboardType,
    bool obscureText = false,
    FormFieldSetter<String>? onSaved,
    FormFieldValidator<String>? validator,
  }) {
    final screenWidth = MediaQuery.of(context).size.width;

    return TextFormField(
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle:
            TextStyle(fontFamily: 'Nunito', fontSize: screenWidth * 0.04),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(33),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Colors.grey[50],
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(33),
          borderSide: BorderSide(color: Colors.grey[50]!),
        ),
      ),
      keyboardType: keyboardType,
      obscureText: obscureText,
      onSaved: onSaved,
      validator: validator,
    );
  }

// Helper method for phone number field with country code
  Widget _buildPhoneNumberField(BuildContext context, double spacingFactor) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Row(
      children: [
        Container(
          width: screenWidth * 0.25, // Responsive width
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[50]!),
            borderRadius: BorderRadius.circular(33),
          ),
          child: CountryCodePicker(
            onChanged: (country) {
              setState(() {
                _countryCode = country.dialCode!;
              });
            },
            initialSelection: 'US',
            favorite: const ['US', 'UK'],
            showCountryOnly: false,
            showOnlyCountryWhenClosed: false,
            alignLeft: false,
            textStyle: TextStyle(fontSize: screenWidth * 0.03),
          ),
        ),
        SizedBox(width: screenWidth * 0.02),
        Expanded(
          child: _buildResponsiveTextField(
            context,
            labelText: 'Phone Number',
            keyboardType: TextInputType.phone,
            onSaved: (value) => _phoneNumber = value,
            validator: (value) => value?.isEmpty ?? true
                ? 'Please enter your phone number'
                : null,
          ),
        ),
      ],
    );
  }

// Helper method for continue button
  Widget _buildContinueButton(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return SizedBox(
      width: screenWidth * 0.9, // 90% of screen width
      height: screenHeight * 0.07, // 7% of screen height
      child: ElevatedButton(
        onPressed: () 
           => _showAlertDialog(context),
          
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(33),
          ),
        ),
        child: Text(
          'Continue',
          style: TextStyle(
            fontFamily: 'Nunito',
            fontSize: screenWidth * 0.045, // Responsive font size
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  void _showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        // Start a timer to navigate after 4 seconds
        Timer(Duration(seconds: 2), () {
          // Close the dialog
          Navigator.of(context).pop();

          // Navigate to the next page (replace with your actual next page)
          Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) =>
                    PinInputScreen()), // Assuming SetFingerprintScreen exists
          );
        });

        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(33),
          ),
          backgroundColor: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.grey[200],
                  child: Icon(
                    Icons.person,
                    color: Colors.grey,
                    size: 40,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  "Congratulations!",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: primary,
                  ),
                ),
                SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: Text(
                    "Your account is ready to use. You will be redirected to the Login page in a few seconds.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[700],
                    ),
                  ),
                ),
                SizedBox(height: 16),
                SpinKitFadingCircle(
                  color: primary,
                  size: 40.0,
                ),
                SizedBox(height: 16),
                AnimatedDots(controller: _animationController),
              ],
            ),
          ),
        );
      },
    );

    @override
    Widget build(BuildContext context) => Scaffold(
          // ... (rest of the build method remains the same)
          body: SingleChildScrollView(
            // ...
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  // ... other form fields
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        // Directly call _showAlertDialog with context
                        _showAlertDialog(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(33),
                        ),
                      ),
                      child: const Text(
                        'Continue',
                        style: TextStyle(
                          fontFamily: 'Nunito',
                          fontSize: 16,
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
        .add(DiagnosticsProperty<DateTime?>('_selectedDate', _selectedDate));
    properties.add(StringProperty('_countryCode', _countryCode));
    properties.add(StringProperty('_phoneNumber', _phoneNumber));
    properties.add(StringProperty('_nickname', _nickname));
    properties.add(StringProperty('_email', _email));
    properties.add(StringProperty('_fullName', _fullName));
  }
}

class AnimatedDots extends StatefulWidget {
  final AnimationController controller;

  const AnimatedDots({Key? key, required this.controller}) : super(key: key);

  @override
  State<AnimatedDots> createState() => _AnimatedDotsState();
}

class _AnimatedDotsState extends State<AnimatedDots> {
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.controller,
      builder: (context, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildDot(0),
            _buildDot(1),
            _buildDot(2),
          ],
        );
      },
    );
  }

  Widget _buildDot(int index) {
    return AnimatedBuilder(
      animation: widget.controller,
      builder: (context, child) {
        double scale = 1.0;
        // Create a pulsing effect for dots with staggered animation
        double value = widget.controller.value;
        scale = 1.0 + (0.5 * (1 - ((value + (index * 0.2)) % 1.0).abs()));

        return Transform.scale(
          scale: scale,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 4.0),
            width: 8.0,
            height: 8.0,
            decoration: BoxDecoration(
              color: primary.withOpacity(scale > 1.0 ? 1.0 : 0.5),
              shape: BoxShape.circle,
            ),
          ),
        );
      },
    );
  }
}
