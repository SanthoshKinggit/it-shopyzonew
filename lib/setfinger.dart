// ignore_for_file: use_super_parameters, library_private_types_in_public_api, prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:myapp/homepage.dart';
import 'package:myapp/others/prime.dart';
class SetFingerprintScreen extends StatefulWidget {
  const SetFingerprintScreen({Key? key}) : super(key: key);

  @override
  _SetFingerprintScreenState createState() => _SetFingerprintScreenState();
}
class _SetFingerprintScreenState extends State<SetFingerprintScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Timer _navigationTimer;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    // Use Timer instead of Future.delayed
    _navigationTimer = Timer(const Duration(seconds: 2), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const PaymentApp()),
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _navigationTimer.cancel(); // Cancel the timer
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Opacity(
                  opacity: _fadeAnimation.value,
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: primary,
                    ),
                    child: const Icon(
                      Icons.fingerprint,
                      size: 60,
                      color: Colors.white
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 24),
            FadeTransition(
              opacity: _fadeAnimation,
              child: const Text(
                "Processing",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: primary
                ),
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: Text(
                  "Your account is ready to use. You will be redirected to the Home page in a few seconds.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[700],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class congrats extends StatefulWidget {
//   const congrats({super.key});

//   @override
//   State<congrats> createState() => _congratsState();
// }

// class _congratsState extends State<congrats> {
//   late AnimationController _animationController;

//   @override
//   void initState() {
//     super.initState();
//     // Create an animation controller for the dots
//     _animationController = AnimationController(
//       vsync: this,
//       duration: Duration(milliseconds: 800),
//     )..repeat(reverse: true);
//   }

//   @override
//   void dispose() {
//     _animationController.dispose();
//     super.dispose();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
//   void _showAlertDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (BuildContext context) {
//         // Start a timer to navigate after 4 seconds
//         Timer(Duration(seconds: 4), () {
//           // Close the dialog
//           Navigator.of(context).pop();

//           // Navigate to the next page (replace with your actual next page)
//           Navigator.of(context).push(
//             MaterialPageRoute(
//                 builder: (context) =>
//                     SetFingerprintScreen()), // Assuming SetFingerprintScreen exists
//           );
//         });

//         return Dialog(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(33),
//           ),
//           backgroundColor: Colors.white,
//           child: Padding(
//             padding: const EdgeInsets.all(20.0),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 CircleAvatar(
//                   radius: 40,
//                   backgroundColor: Colors.black,
//                   child: Icon(
//                     Icons.person,
//                     color: Colors.white,
//                     size: 40,
//                   ),
//                 ),
//                 SizedBox(height: 16),
//                 Text(
//                   "Congrats",
//                   style: TextStyle(
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black,
//                   ),
//                 ),
//                 SizedBox(height: 8),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 40.0),
//                   child: Text(
//                     "Your account is ready to use. You will be redirected to the Home page in a few seconds.",
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       fontSize: 14,
//                       color: Colors.grey[700],
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 16),
//                 SpinKitFadingCircle(
//                   color: Colors.black,
//                   size: 40.0,
//                 ),
//                 SizedBox(height: 16),
//                 AnimatedDots(controller: _animationController),
//               ],
//             ),
//           ),
//         );
//       },
//     );

//     @override
//     Widget build(BuildContext context) => Scaffold(
//           // ... (rest of the build method remains the same)
//           body: SingleChildScrollView(
//             // ...
//             child: Form(
//               key: _formKey,
//               child: Column(
//                 children: [
//                   // ... other form fields
//                   SizedBox(
//                     width: double.infinity,
//                     height: 50,
//                     child: ElevatedButton(
//                       onPressed: () {
//                         // Directly call _showAlertDialog with context
//                         _showAlertDialog(context);
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: primary,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(33),
//                         ),
//                       ),
//                       child: const Text(
//                         'Continue',
//                         style: TextStyle(
//                           fontFamily: 'Nunito',
//                           fontSize: 16,
//                           color: Color.fromARGB(255, 255, 255, 255),
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//   }
// }
