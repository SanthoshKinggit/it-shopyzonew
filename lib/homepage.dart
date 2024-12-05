// ignore_for_file: use_super_parameters, prefer_const_constructors, avoid_print, prefer_const_literals_to_create_immutables, sort_child_properties_last, unused_import, unused_element, library_private_types_in_public_api

import 'dart:async';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/others/banking.dart';
import 'package:myapp/account/createac.dart';
import 'package:myapp/others/edit.dart';
import 'package:myapp/pages/history.dart';
import 'package:myapp/loginpage.dart';
import 'package:myapp/mainpages/plan.dart';
import 'package:myapp/others/prime.dart';
import 'package:myapp/others/profile.dart';
import 'package:myapp/others/profileedit.dart';
import 'package:myapp/mainpages/qrcode.dart';
import 'package:myapp/mainpages/qrscan.dart';
import 'package:myapp/mainpages/sevices.dart';
import 'package:myapp/usertype.dart';

import 'signup.dart';

class PaymentApp extends StatefulWidget {
  const PaymentApp({Key? key}) : super(key: key);

  @override
  State<PaymentApp> createState() => _PaymentAppState();
}

class PremiumGoldIcon extends StatefulWidget {
  final double size;
  final Color baseColor;

  const PremiumGoldIcon({
    Key? key,
    this.size = 50.0,
    this.baseColor = const Color(0xFFFFD700), // Default gold color
  }) : super(key: key);

  @override
  _PremiumGoldIconState createState() => _PremiumGoldIconState();
}

class _PremiumGoldIconState extends State<PremiumGoldIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotationAnimation;
  late Animation<double> glowAnimation;

  @override
  void initState() {
    super.initState();

    // Animation Controller
    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    // Scale Animation (Pulsing Effect)
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    // Rotation Animation
    _rotationAnimation = Tween<double>(begin: 0, end: 2 * pi).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.linear,
      ),
    );

    // Glow Animation
    glowAnimation = Tween<double>(begin: 0.3, end: 0.8).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Transform.rotate(
            angle: _rotationAnimation.value / 6, // Subtle rotation
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PricingPlansScreen()));
                  },
                  icon: Icon(
                    Icons.workspace_premium,
                    color: widget.baseColor,
                    size: widget.size,
                  )),
            ),
          ),
        );
      },
    );
  }
}

class _PaymentAppState extends State<PaymentApp> {
  late PageController _pageController;
  Timer? _timer;
  int _currentPage = 0;

  // List of image paths
  final List<String> imagePaths = [
    'assets/logo/fvdfggd.jpg',
    'assets/logo/istockphoto-1263429560-1024x1024.jpg',
    'assets/logo/vccccccccc.jpg',
    'assets/logo/istockphoto-1284747681-1024x1024.jpg',
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: 0,
      viewportFraction: 0.85, // This will show a bit of next/previous images
    );
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      if (_currentPage < imagePaths.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      if (_pageController.hasClients) {
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    switch (index) {
      case 0:
        setState(() {});
        break;
      case 1:
      //  Navigator.push(
      //     context,
      //     MaterialPageRoute(builder: (context) => ShopHomeScreen()),
      //   );
      
        setState(() {});
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => QRScannerPage()),
        );
        setState(() {});

        break;
      case 3:
        if (index == 3) {
          print('object');
        } else if (index == 0) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Qrcode()));
        } else if (index == 1) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => const Qrcode()));
        } else if (index == 2) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const QRScannerPage()));
        } else if (index == 3) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const banking()));
        } else {
          print('object');
        }
        setState(() {});
        break;
      case 4:
        if (index == 4) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => PaymentHistoryScreen()));
        } else {
          print('object');
        }

        break;
    }
  }

  bool isDarkMode = true;
  String selectedLanguage = 'English (US)';
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(

        drawer: Drawer(
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              // Custom Drawer Header
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: 75,
                          height: 75,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white,
                              width: 3,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 10,
                                spreadRadius: 1,
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.asset(
                              'assets/logo/Coin - 1.png',
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          EditProfileScreen()));
                            },
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: primary,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 2,
                                ),
                              ),
                              child: const Icon(
                                Icons.edit,
                                size: 14,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Andrew Ainsley',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Nunito',
                      ),
                    ),
                    Text(
                      '**** 8957 4774',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                        fontFamily: 'Nunito',
                      ),
                    ),
                  ],
                ),
              ),

              // Drawer Menu Items
              _buildDrawerItem(
                icon: Icons.person_outline,
                title: 'Edit Profile',
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EditProfileScreen()));
                },
                showArrow: true,
              ),

              _buildDrawerItem(
                icon: Icons.card_membership,
                title: 'Membership',
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UserTypeSelection()));
                },
                showArrow: true,
              ),
              _buildDrawerItem(
                icon: Icons.next_plan,
                title: 'Premimum Plans',
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> PricingPlansScreen()));
                },
                showArrow: true,
              ),
              _buildDrawerItem(
                icon: Icons.language_outlined,
                title: 'Language',
                value: selectedLanguage,
                onTap: () => _showLanguageBottomSheet(),
                showArrow: true,
              ),

              _buildDrawerItem(
                icon: Icons.security_outlined,
                title: 'Security',
                onTap: () {},
                showArrow: true,
              ),

              _buildDrawerItem(
                icon: CupertinoIcons.moon,
                title: 'Dark Theme',
                trailing: Switch(
                  value: isDarkMode,
                  onChanged: (value) {
                    setState(() {
                      isDarkMode = value;
                    });
                  },
                  activeColor: primary,
                ),
                onTap: () {},
              ),

              _buildDrawerItem(
                icon: Icons.privacy_tip_outlined,
                title: 'Privacy Policy',
                onTap: () {},
                showArrow: true,
              ),


              _buildDrawerItem(
                icon: Icons.help_outline,
                title: 'Help & Support',
                onTap: () {},
                showArrow: true,
              ),

              _buildDrawerItem(
                icon: Icons.contact_support_outlined,
                title: 'Contact Us',
                onTap: () {},
                showArrow: true,
              ),

              _buildDrawerItem(
                icon: Icons.logout,
                title: 'Logout',
                titleColor: Colors.red,
                onTap: () => _showLogoutDialog(),
              ),
            ],
          ),
        ),
        key: _scaffoldKey,
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          _scaffoldKey.currentState?.openDrawer();
                        },
                        child: Image.asset(
                          'assets/logo/Coin - 1.png',
                          height: 35,
                        ),
                      ),
                      const Text(
                        '  Andrew Ainsley  ',
                        style: TextStyle(
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(
                        width: 120,
                      ),
                      Icon(
                        Icons.notifications_none_outlined,
                        color: primary,
                      )
                      // Row(
                      //   children: [
                      //     IconButton(
                      //       icon: const Icon(Icons.camera_alt_outlined),
                      //       onPressed: () {},
                      //     ),
                      //     IconButton(
                      //       icon: const Icon(
                      //         Icons.qr_code_2_outlined,
                      //         color: primary,
                      //       ),
                      //       onPressed: () {
                      //         Navigator.push(
                      //             context,
                      //             MaterialPageRoute(
                      //                 builder: (context) => Qrcode()));
                      //       },
                      //     ),
                      //     SizedBox(
                      //       width: 4,
                      //     )
                      //   ],
                      // ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 14,
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [

                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 8),
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: primary,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Wallet',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Nunito',
                                          fontSize: 16,
                                        ),
                                      ),

                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: 60,
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            '             Recent Transaction',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'Nunito',
                                              fontSize: 16,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(right: 48.0),
                                            child: IconButton(
                                                onPressed: (){
                                                  Navigator.push(context, MaterialPageRoute(builder: (context) => TotalEarningsScreen()));

                                                },
                                                icon: Icon(
                                                  Icons.wallet_outlined,
                                                  color: Colors.white,
                                                  size: 44,
                                                )
                                            ),
                                          )
                                        ],
                                      ),

                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      const Text(
                                        'Total Amount\n12,689',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'Nunito',
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        width: 150,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => TotalEarningsScreen()));
                              },
                              child: Container(
                                margin: const EdgeInsets.symmetric(horizontal: 8),
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color: primary,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Earnings History',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'Nunito',
                                            fontSize: 16,
                                          ),
                                        ),

                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,

                                    ),
                                    Row(

                                      children: [
                                        SizedBox(
                                          width: 40,
                                        ),
                                        Column(
                                          children: [

                                            Text(
                                              '              Referal',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: 'Nunito',
                                                fontSize: 16,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(left: 60.0),
                                              child: IconButton(
                                                  onPressed: (){
                                                    Navigator.push(context, MaterialPageRoute(builder: (context) => ReferralEarningsScreen()));

                                                  },
                                                  icon: Icon(
                                                    Icons.currency_rupee,
                                                    color: Colors.white,
                                                    size: 44,
                                                  )
                                              ),
                                            ),

                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Text(
                                              '         Purchase',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: 'Nunito',
                                                fontSize: 16,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(left: 34.0),
                                              child: IconButton(
                                                  onPressed: (){
                                                    Navigator.push(context, MaterialPageRoute(builder: (context) => ReferralEarningsScreen()));

                                                  },
                                                  icon: Icon(
                                                    Icons.credit_card,
                                                    color: Colors.white,
                                                    size: 44,
                                                  )
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Text(
                                          'Total Earnings\n₹1,689',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'Nunito',
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          width: 90,
                                        ),

                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              '     Services',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Nunito',
                                fontSize: 16,
                              ),
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ServicesPage()));
                                },
                                child: const Text(
                                  'See All',
                                  style: TextStyle(
                                    fontFamily: 'Nunito',
                                    color: primary,
                                    fontSize: 14,
                                  ),
                                ))
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 14),
                        child: GridView.count(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisCount: 4,
                          children: [
                            _buildServiceItem(
                              Icons.flash_on,
                              'Electricity',
                              Colors.amber,
                            ),
                            _buildServiceItem(Icons.wifi, 'Internet',
                                const Color.fromARGB(255, 0, 203, 34)),
                            _buildServiceItem(
                              Icons.water_drop,
                              'Water',
                              Colors.blue,
                            ),
                            _buildServiceItem(
                                Icons.account_balance_wallet,
                                'E-Wallet',
                                const Color.fromARGB(255, 0, 190, 175)),
                            _buildServiceItem(
                              Icons.security,
                              'Assurance',
                              const Color.fromARGB(255, 18, 64, 200),
                            ),
                            _buildServiceItem(
                              Icons.shopping_bag,
                              'Shopping',
                              const Color.fromARGB(255, 147, 0, 167),
                            ),
                            _buildServiceItem(Icons.local_offer, 'Deals',
                                const Color.fromARGB(255, 216, 223, 0)),
                            _buildServiceItem(Icons.favorite, 'Health',
                                const Color.fromARGB(255, 222, 0, 118)),
                          ],
                        ),
                      ),
                      // Image Carousel Section
                      _buildImageCarousel(),
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              '     Banking',
                              style: TextStyle(
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => banking()));
                                },
                                child: const Text(
                                  'See All',
                                  style: TextStyle(
                                    fontFamily: 'Nunito',
                                    color: primary,
                                    fontSize: 14,
                                  ),
                                ))
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 14),
                        child: GridView.count(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisCount: 4,
                          children: [
                            _buildServiceItem(
                              Icons.flash_on,
                              'Electricity',
                              const Color.fromARGB(255, 0, 56, 169),
                            ),
                            _buildServiceItem(Icons.wifi, 'Internet',
                                const Color.fromARGB(255, 0, 203, 34)),
                            _buildServiceItem(
                              Icons.flash_on,
                              'Electricity',
                              Colors.amber,
                            ),
                            _buildServiceItem(Icons.wifi, 'Internet',
                                const Color.fromARGB(255, 15, 219, 255)),
                            _buildServiceItem(
                              Icons.water_drop,
                              'Water',
                              Colors.blue,
                            ),
                            _buildServiceItem(
                                Icons.account_balance_wallet,
                                'E-Wallet',
                                const Color.fromARGB(255, 0, 190, 175)),
                            _buildServiceItem(
                              Icons.security,
                              'Assurance',
                              const Color.fromARGB(255, 18, 64, 200),
                            ),
                            _buildServiceItem(
                              Icons.shopping_bag,
                              'Shopping',
                              const Color.fromARGB(255, 147, 0, 167),
                            ),
                            _buildServiceItem(Icons.local_offer, 'Deals',
                                const Color.fromARGB(255, 216, 223, 0)),
                            _buildServiceItem(Icons.favorite, 'Health',
                                const Color.fromARGB(255, 222, 0, 118)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: ClipRRect(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
              bottomLeft: Radius.circular(30.0),
              bottomRight: Radius.circular(30.0)),
          child: BottomNavigationBar(
            backgroundColor: const Color.fromARGB(255, 255, 255, 255),
            selectedItemColor: primary,
            unselectedItemColor: Colors.grey,
            currentIndex: 0,
            onTap: _onItemTapped,
            type: BottomNavigationBarType.fixed,
            elevation: 10,
            selectedLabelStyle: const TextStyle(
              fontFamily: 'Nunito',
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
            unselectedLabelStyle: const TextStyle(
              fontFamily: 'Nunito',
              fontSize: 11,
            ),
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.account_balance), label: 'Account'),
              BottomNavigationBarItem(icon: Icon(Icons.shop), label: 'Shop'),
              BottomNavigationBarItem(
                icon: Column(
                  children: [
                    CircleAvatar(
                        backgroundColor: primary,
                        child: Icon(
                          Icons.qr_code_scanner,
                          color: Colors.white,
                        )),
                  ],
                ),
                label: 'Scan',
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.home_repair_service), label: 'Services'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.history), label: 'History'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    String? value,
    required Function() onTap,
    Color? titleColor,
    Widget? trailing,
    bool showArrow = false,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: Colors.grey[600],
        size: 24,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: titleColor ?? Colors.black87,
          fontSize: 16,
          fontFamily: 'Nunito',
        ),
      ),
      trailing: trailing ??
          (showArrow
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (value != null)
                      Text(
                        value,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontFamily: 'Nunito',
                          fontSize: 14,
                        ),
                      ),
                    if (value != null) const SizedBox(width: 8),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.grey[400],
                      size: 16,
                    ),
                  ],
                )
              : null),
      onTap: () {
        // Close drawer before navigation
        Navigator.pop(context);
        onTap();
      },
    );
  }

  void _showLanguageBottomSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Select Language',
                style: TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              ListTile(
                title: const Text(
                  'English (US)',
                  style: TextStyle(
                    fontFamily: 'Nunito',
                  ),
                ),
                trailing: selectedLanguage == 'English (US)'
                    ? const Icon(
                        Icons.check,
                        color: primary,
                      )
                    : null,
                onTap: () {
                  setState(() {
                    selectedLanguage = 'English (US)';
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text(
                  'Spanish',
                  style: TextStyle(
                    fontFamily: 'Nunito',
                  ),
                ),
                trailing: selectedLanguage == 'Spanish'
                    ? const Icon(
                        Icons.check,
                        color: primary,
                      )
                    : null,
                onTap: () {
                  setState(() {
                    selectedLanguage = 'Spanish';
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              // Implement logout logic here
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginScreen()));
            },
            child: const Text(
              'Logout',
              style: TextStyle(
                color: Colors.red,
                fontFamily: 'Nunito',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageCarousel() {
    return Column(
      children: [
        SizedBox(
          height: 120,
          width: 1200,
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
            itemCount: imagePaths.length,
            itemBuilder: (context, index) {
              return Container(
                margin:
                    EdgeInsetsDirectional.symmetric(horizontal: 8, vertical: 0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    imagePaths[index],
                    fit: BoxFit.fill,
                    // This ensures the image covers the entire container
                    // Explicitly set height here as well
                  ),
                ),
              );
            },
          ),
        ),
        SizedBox(
          height: 20,
        ),
        // Page Indicator
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            imagePaths.length,
            (index) => Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 4,
              ),
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _currentPage == index ? primary : Colors.grey.shade300,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton(IconData icon, String label) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 255, 255, 255).withOpacity(0.1),
              borderRadius: BorderRadius.circular(33),
            ),
            child: Icon(icon, color: const Color.fromARGB(255, 255, 255, 255)),
          ),
          const SizedBox(height: 5),
          Text(
            label,
            style: const TextStyle(
                fontFamily: 'Nunito',
                fontSize: 12,
                color: Color.fromARGB(255, 255, 255, 255)),
          ),
        ],
      ),
    );
  }

  Widget buildActionButton(IconData icon, String label) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 255, 255, 255).withOpacity(0.1),
              borderRadius: BorderRadius.circular(33),
            ),
            child: Icon(icon, color: const Color.fromARGB(255, 255, 255, 255)),
          ),
          const SizedBox(height: 5),
          Text(
            label,
            style: const TextStyle(
                fontFamily: 'Nunito',
                fontSize: 12,
                color: Color.fromARGB(255, 255, 255, 255)),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceItem(IconData icon, String label, Color color) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Icon(icon, color: color, size: 30),
        ),
        const SizedBox(height: 5),
        Text(
          label,
          style: const TextStyle(fontFamily: 'Nunito', fontSize: 12),
        ),
      ],
    );
  }
}
