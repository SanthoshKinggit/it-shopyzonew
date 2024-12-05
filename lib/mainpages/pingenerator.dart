// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:myapp/others/prime.dart';
import 'package:myapp/setfinger.dart';

class PinInputScreen extends StatefulWidget {
  @override
  _PinInputScreenState createState() => _PinInputScreenState();
}

class _PinInputScreenState extends State<PinInputScreen> {
  // Create list of text controllers and focus nodes for each PIN digit
  final List<TextEditingController> _pinControllers = 
      List.generate(4, (_) => TextEditingController());
  final List<FocusNode> _pinFocusNodes = 
      List.generate(4, (_) => FocusNode());

  @override
  void dispose() {
    // Dispose controllers and focus nodes to prevent memory leaks
    for (var controller in _pinControllers) {
      controller.dispose();
    }
    for (var focusNode in _pinFocusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text(
          'Create Your PIN',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w200,
            color: const Color.fromARGB(255, 68, 68, 68),
            fontFamily: 'Nunito',
            letterSpacing: 1.2,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 80),
              Text(
                'Add a PIN number to make your account more secure',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w200,
                  color: const Color.fromARGB(255, 68, 68, 68),
                  fontFamily: 'Nunito',
                  letterSpacing: 1.2,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Text(
                'Secure your account with a 4-digit PIN',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Nunito',
                  color: Colors.white70,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(4, (index) {
                  return Container(
                    width: 55,
                    height: 60,
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22),
                      boxShadow: [
                        BoxShadow(
                          color: primary.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: TextFormField(
                      controller: _pinControllers[index],
                      focusNode: _pinFocusNodes[index],
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      maxLength: 1,
                      obscureText: true,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      style: TextStyle(
                        fontSize: 24,
                        fontFamily: 'Nunito',
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: InputDecoration(
                        counterText: '',
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.9),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: Colors.deepPurple.shade300,
                            width: 2,
                          ),
                        ),
                      ),
                      onChanged: (value) {
                        // Automatically move to next field when a digit is entered
                        if (value.length == 1) {
                          if (index < 3) {
                            FocusScope.of(context).requestFocus(_pinFocusNodes[index + 1]);
                          } else {
                            // Last field - remove focus
                            _pinFocusNodes[index].unfocus();
                          }
                        }
                      },
                    ),
                  );
                }),
              ),
              const SizedBox(height: 60),
              ElevatedButton(
                onPressed: () {
                  // Validate PIN input
                  String pin = _pinControllers.map((controller) => controller.text).join();
                  if (pin.length == 4) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SetFingerprintScreen()));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Please enter a complete 4-digit PIN'),
                        backgroundColor: primary,
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primary,
                  foregroundColor: const Color.fromARGB(255, 255, 255, 255),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 80,
                    vertical: 15,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 8,
                ),
                child: Text(
                  'Create MPIN',
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('Contact support for assistance'),
                      backgroundColor: Colors.deepPurple.shade700,
                    ),
                  );
                },
                child: const Text(
                  'Need Help?',
                  style: TextStyle(
                    color: primary,
                    fontFamily: 'Nunito',
                    fontSize: 16,
                  ),
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}