// ignore_for_file: use_super_parameters, library_private_types_in_public_api, prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import

import 'package:flutter/material.dart';

import 'package:myapp/indicator.dart';
import 'package:myapp/mainpages/splashscreen.dart';

import 'package:myapp/others/prime.dart';

import 'dart:math' as math;

import 'package:myapp/slider.dart';
import 'package:myapp/usertype.dart';

import 'account/createac.dart';
import 'mainpages/pingenerator.dart';
import 'mainpages/plan.dart';
import 'mainpages/qrcode.dart';
import 'mainpages/qrscan.dart';
import 'mainpages/sevices.dart';
import 'mainpages/video.dart';
import 'others/add.dart';
import 'others/banking.dart';
import 'others/choosemember.dart';
import 'others/edit.dart';
import 'others/forgot.dart';
import 'others/image_carousel.dart';
import 'others/profileedit.dart';
import 'pages/forgotpass.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  final String logoPath =
      'assets/logo/Coin - 2.png';

  final Color primaryColor = const Color(0xFF0A1F44);

  void _handleAnimationComplete(BuildContext context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => Homepage1()),
    );
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: primaryColor,
        useMaterial3: true,
      ),
      home: TechSplashScreen(
        logoPath: logoPath,

        primaryColor: primaryColor,
        onAnimationComplete: (context) => _handleAnimationComplete(context),
      ),
    );
  }
}
