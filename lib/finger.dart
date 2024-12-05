// ignore_for_file: collection_methods_unrelated_type, avoid_print, use_build_context_synchronously, prefer_const_constructors, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:myapp/homepage.dart';

class SetFingerprintScreen1 extends StatefulWidget {
  const SetFingerprintScreen1({super.key});

  @override
  _SetFingerprintScreen1State createState() => _SetFingerprintScreen1State();
}

class _SetFingerprintScreen1State extends State<SetFingerprintScreen1> {
  final LocalAuthentication _localAuthentication = LocalAuthentication();
  bool _isFingerPrintAvailable = false;

  @override
  void initState() {
    super.initState();
    _checkFingerPrintAvailability();
  }

  Future<void> _checkFingerPrintAvailability() async {
    try {
      final bool canCheckBiometrics =
          await _localAuthentication.canCheckBiometrics;
      final List<BiometricType> availableBiometrics =
          await _localAuthentication.getAvailableBiometrics();

      if (canCheckBiometrics && availableBiometrics.contains(BiometricType)) {
        setState(() {
          _isFingerPrintAvailable = true;
        });
      }
    } catch (e) {
      // Handle any errors that occur during the availability check
      print('Error checking fingerprint availability: $e');
    }
  }

  Future<void> _authenticateWithFingerprint() async {
    try {
      final bool didAuthenticate = await _localAuthentication.authenticate(
        localizedReason: 'Please authenticate with your fingerprint',
      );

      if (didAuthenticate) {
        // Fingerprint authentication successful, navigate to the home page
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => PaymentApp()),
        );
      }
    } catch (e) {
      // Handle fingerprint authentication errors
      print('Error authenticating with fingerprint: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.fingerprint,
              size: 100,
              color: Colors.black.withOpacity(0.8),
            ),
            SizedBox(height: 24),
            Text(
              "Congratulations!",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 8),
            Text(
              "Your account is ready to use. Authenticate\nwith your fingerprint to continue.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(height: 48),
            if (_isFingerPrintAvailable)
              ElevatedButton(
                onPressed: _authenticateWithFingerprint,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                ),
                child: Text(
                  "Authenticate with Fingerprint",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            if (!_isFingerPrintAvailable)
              Text(
                "Fingerprint authentication is not available on this device.",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[700],
                ),
              ),
            SizedBox(
              height: 10,
            ),
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back_ios))
          ],
        ),
      ),
    );
  }
}


