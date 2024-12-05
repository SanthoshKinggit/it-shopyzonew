import 'package:flutter/material.dart';

import 'bottombar/bottom_screen.dart';
import 'service/service_home.dart';
import 'shop/shop_homescreen.dart';
import 'slider.dart';
// Your custom bottom navigation bar


class HomePage5 extends StatefulWidget {
  @override
  _HomePage5State createState() => _HomePage5State();
}

class _HomePage5State extends State<HomePage5> {
  int _currentIndex = 0; // Track selected tab index

  // Handle item tap event
  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index; // Update the current index
    });
  }

  @override
  Widget build(BuildContext context) {
    // List of pages for the bottom navigation bar
    List<Widget> _pages = [
      ShopHomeScreen(),
        ShopHomeScreen(),
          ShopHomeScreen(),
          JustDialUI(),
              ShopHomeScreen(),
    ];

    return Scaffold(
     
      body: _pages[_currentIndex], // Show the page based on selected index
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _currentIndex, // Pass current index to the bottom navigation
        onItemTapped: _onItemTapped, // Handle tap event
      ),
    );
  }
}
