// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, no_leading_underscores_for_local_identifiers, avoid_print

import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../order/myorder_screen.dart';


class EnterPinscreen extends StatefulWidget {
  const EnterPinscreen({super.key});

  @override
  State<EnterPinscreen> createState() => _EnterPinscreenState();
}

class _EnterPinscreenState extends State<EnterPinscreen> { final int _pinLength = 4;
  final List<TextEditingController> _controllers = [];
  final List<FocusNode> _focusNodes = [];
  int _currentFocusedIndex = 0; // Tracks the currently focused field index
  bool _isPinComplete = false; // Tracks whether the PIN is fully entered

 void _showCongratsDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Image
            Image.asset("assets/images/service/ticks.gif", height: 100, width: 100),
            SizedBox(height: 20),
            // Congrats Text
            Text("Order Successful!", style: TextStyle( fontFamily: 'Nunito',fontSize: 18, fontWeight: FontWeight.bold,color: Color.fromARGB(255, 11, 0, 20))),
            SizedBox(height: 10),
            // Description
            Text("You have successfully mode order", style: TextStyle( fontFamily: 'Nunito',fontSize: 12, color: Color.fromARGB(255, 11, 0, 20))),
            SizedBox(height: 30),
            // Loader
            LoadingAnimationWidget.hexagonDots(
              color: Theme.of(context).primaryColor,
              size: 60,
            ),
          ],
        ),
      ),
    );

    // Simulate a delay for loader, then navigate to the next page
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pop(context); // Close the dialog
      _navigateToNextPage();
    });
  }

  // Navigate to the next page
  void _navigateToNextPage() {
    // Replace this with your actual navigation logic
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MyorderScreen()), // Replace 'NextPage' with the actual page
    );
  }


  @override
  void initState() {
    super.initState();
    // Initialize controllers and focus nodes
    for (int i = 0; i < _pinLength; i++) {
      _controllers.add(TextEditingController());
      _focusNodes.add(FocusNode());
      _focusNodes[i].addListener(() {
        if (_focusNodes[i].hasFocus) {
          setState(() {
            _currentFocusedIndex = i; // Update focused index
          });
        }
      });
    }
  }

  @override
  void dispose() {
    // Dispose controllers and focus nodes
    for (int i = 0; i < _pinLength; i++) {
      _controllers[i].dispose();
      _focusNodes[i].dispose();
    }
    super.dispose();
  }

  void _onPinChanged() {
    // Check if all fields are filled
    bool allFieldsFilled = _controllers.every((controller) => controller.text.isNotEmpty);
    setState(() {
      _isPinComplete = allFieldsFilled;
    });
  }

  String _getEnteredPin() {
    return _controllers.map((controller) => controller.text).join();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
          Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
         backgroundColor: Theme.of(context).primaryColor,
        title: const Text(
          'Create New Pin',
          style: TextStyle( fontFamily: 'Nunito',color: Colors.white,fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 60),
            Text(
              "Enter your PIN to confirm payment",
              style: TextStyle( fontFamily: 'Nunito',fontSize: 14, color: Theme.of(context).primaryColor,),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.only(left: 48.0, right: 48),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(_pinLength, (index) {
                  return SizedBox(
                    height: 45,
                    width: 55,
                    child: StatefulBuilder(
                      builder: (context, setState) {
                        bool _isObscured = true;

                        return Focus(
                          onFocusChange: (hasFocus) {
                            // Reset to obscured mode when the field loses focus
                            if (!hasFocus) {
                              setState(() {
                                _isObscured = true;
                              });
                            }
                          },
                          child: TextFormField(
                            controller: _controllers[index],
                            focusNode: _focusNodes[index],
                            keyboardType: TextInputType.number,
                            obscureText: _isObscured, // Toggle obscured text
                            obscuringCharacter: '●',
                            textAlign: TextAlign.center,
                            maxLength: 1,
                            autofillHints: null,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(10),
                              fillColor: Colors.white,
                              filled: true,
                              counterText: '',
                              enabledBorder: OutlineInputBorder(
                                borderSide:  BorderSide(color: Theme.of(context).primaryColor, width: 0),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: _currentFocusedIndex == index
                                      ? Theme.of(context).primaryColor
                                      : const Color.fromARGB(255, 236, 234, 234),
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onChanged: (value) {
                              setState(() {
                                _isObscured = false; // Temporarily show the character
                                _currentFocusedIndex = index;
                              });

                              Future.delayed(const Duration(milliseconds: 500), () {
                                // Obscure the input after 500ms
                                setState(() {
                                  _isObscured = true;
                                });
                              });

                              if (value.isNotEmpty) {
                                if (index < _pinLength - 1) {
                                  // Automatically move to the next field if not the last field
                                  FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
                                } else {
                                  // Unfocus all if it's the last field
                                  FocusScope.of(context).unfocus();
                                }
                              }
                              _onPinChanged();
                            },
                          ),
                        );
                      },
                    ),
                  );
                }),
              ),
            ),
            const SizedBox(height: 90),
            Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                onPressed: _isPinComplete
                    ? () {
                       _showCongratsDialog();
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => const SetFingerprint(),
                        //   ),
                        // );
                        print("Entered PIN: ${_getEnteredPin()}");
                      }
                    : null, // Disable button if PIN is incomplete
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                
                  disabledBackgroundColor:  const Color.fromARGB(255, 216, 215, 215),
                  padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                  shape: RoundedRectangleBorder(
                    
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: const Text(
                  'Continue',
                  style: TextStyle( fontFamily: 'Nunito',fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
