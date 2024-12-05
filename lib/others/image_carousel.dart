// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, library_private_types_in_public_api, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:myapp/others/prime.dart';


class MainDashboardScreen extends StatefulWidget {
  @override
  _MainDashboardScreenState createState() => _MainDashboardScreenState();
}

class _MainDashboardScreenState extends State<MainDashboardScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    DashboardScreen(),
    ShopCategoryScreen(),
    PaymentHistoryScreen(),
    EarningHistoryScreen(),
    QuickLinksScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: primary,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Dashboard'),
          BottomNavigationBarItem(icon: Icon(Icons.shop), label: 'Shops'),
          BottomNavigationBarItem(icon: Icon(Icons.payment), label: 'Payments'),
          BottomNavigationBarItem(icon: Icon(Icons.money), label: 'Earnings'),
          BottomNavigationBarItem(icon: Icon(Icons.link), label: 'Quick Links'),
        ],
      ),
    );
  }
}

class DashboardScreen extends StatelessWidget {
  final List<String> adBanners = [
    'https://example.com/banner1.jpg',
    'https://example.com/banner2.jpg',
    'https://example.com/banner3.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          // Ad Banners Carousel
          CarouselSlider(
            options: CarouselOptions(
              height: 200,
              autoPlay: true,
              enlargeCenterPage: true,
            ),
            items: adBanners.map((banner) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                        image: CachedNetworkImageProvider(banner),
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              );
            }).toList(),
          ).animate().fadeIn(duration: 500.ms),

          // Earnings Summary
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Earnings Summary',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildEarningTile('Total Earnings', '\$5,420.50'),
                        _buildEarningTile('Referral Earnings', '\$1,200.75'),
                      ],
                    ),
                  ],
                ),
              ),
            ).animate().slideIn(duration: 500.ms),
          ),
        ],
      ),
    );
  }

  Widget _buildEarningTile(String title, String amount) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Colors.grey,
            fontSize: 14,
          ),
        ),
        Text(
          amount,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: primary
          ),
        ),
      ],
    );
  }
}

extension on Animate {
  slideIn({required Duration duration}) {}
}

class ShopCategoryScreen extends StatelessWidget {
  final List<Map<String, String>> shopCategories = [
    {'name': 'Electronics', 'icon': 'https://example.com/electronics.png'},
    {'name': 'Fashion', 'icon': 'https://example.com/fashion.png'},
    {'name': 'Home & Kitchen', 'icon': 'https://example.com/home.png'},
    {'name': 'Books', 'icon': 'https://example.com/books.png'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shop Categories', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(16),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: shopCategories.length,
        itemBuilder: (context, index) {
          final category = shopCategories[index];
          return Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CachedNetworkImage(
                  imageUrl: category['icon']!,
                  width: 80,
                  height: 80,
                ),
                SizedBox(height: 10),
                Text(
                  category['name']!,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ).animate().scale(duration: 500.ms);
        },
      ),
    );
  }
}

class PaymentHistoryScreen extends StatelessWidget {
  final List<Map<String, dynamic>> paymentHistory = [
    {
      'date': '2023-12-01',
      'amount': '\$450.25',
      'type': 'Referral Earning',
    },
    {
      'date': '2023-11-15',
      'amount': '\$750.50',
      'type': 'Shop Earnings',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment History', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: paymentHistory.length,
        itemBuilder: (context, index) {
          final payment = paymentHistory[index];
          return Card(
            elevation: 4,
            margin: EdgeInsets.only(bottom: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: ListTile(
              title: Text(
                payment['amount'],
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(payment['type']),
              trailing: Text(payment['date']),
            ),
          ).animate().slideIn(duration: 500.ms);
        },
      ),
    );
  }
}

class EarningHistoryScreen extends StatelessWidget {
  final List<Map<String, dynamic>> earningHistory = [
    {
      'date': '2023-12-01',
      'amount': '\$250.25',
      'source': 'Referral Commission',
    },
    {
      'date': '2023-11-15',
      'amount': '\$500.50',
      'source': 'Shop Sales',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Earning History', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: earningHistory.length,
        itemBuilder: (context, index) {
          final earning = earningHistory[index];
          return Card(
            elevation: 4,
            margin: EdgeInsets.only(bottom: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: ListTile(
              title: Text(
                earning['amount'],
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              subtitle: Text(earning['source']),
              trailing: Text(earning['date']),
            ),
          ).animate().slideIn(duration: 500.ms);
        },
      ),
    );
  }
}

class QuickLinksScreen extends StatelessWidget {
  final List<Map<String, dynamic>> quickLinks = [
    {
      'title': 'Support',
      'icon': Icons.support_agent,
      'onTap': () {/* Implement support navigation */},
    },
    {
      'title': 'FAQ',
      'icon': Icons.help_outline,
      'onTap': () {/* Implement FAQ navigation */},
    },
    {
      'title': 'Settings',
      'icon': Icons.settings,
      'onTap': () {/* Implement settings navigation */},
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quick Links', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: quickLinks.length,
        itemBuilder: (context, index) {
          final link = quickLinks[index];
          return Card(
            elevation: 4,
            margin: EdgeInsets.only(bottom: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: ListTile(
              leading: Icon(link['icon'], color: Colors.blue),
              title: Text(
                link['title'],
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: link['onTap'],
            ),
          ).animate().slideIn(duration: 500.ms);
        },
      ),
    );
  }
}