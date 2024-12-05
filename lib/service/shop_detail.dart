
// ignore_for_file: prefer_final_fields, unused_field, use_key_in_widget_constructors, library_private_types_in_public_api, deprecated_member_use, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:url_launcher/url_launcher.dart';

class RestaurantDetailsPage extends StatefulWidget {
  @override
  _RestaurantDetailsPageState createState() => _RestaurantDetailsPageState();
}

class _RestaurantDetailsPageState extends State<RestaurantDetailsPage> {
  TextEditingController searchController = TextEditingController();
  int _currentIndex = 0;
  int _selectedStars = 0;

  final List<String> imageList = [
    'assets/images/service/chinese2.jpg',
    'assets/images/service/chinese4.jpg',
    'assets/images/service/chinese3.png',
    
  ];

  // Call function to make a phone call
  _makeCall() async {
    const phoneNumber = 'tel:+919629176249';
    if (await canLaunch(phoneNumber)) {
      await launch(phoneNumber);
    } else {
      throw 'Could not launch $phoneNumber';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: Icon(Icons.arrow_back_ios, color: Colors.grey),
        ),
        title: Text(
          "ShopyZo",
          style: TextStyle(color: 
Theme.of(context).primaryColor, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          Icon(Icons.notifications, color: Theme.of(context).primaryColor),
          SizedBox(width: 10),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: 'Search for a restaurant',
                  hintStyle: TextStyle(color: const Color.fromARGB(255, 217, 186, 247)),
                  prefixIcon: Icon(Icons.search, color: const Color.fromARGB(255, 222, 184, 247)),
                  suffixIcon: Icon(Icons.mic, color: const Color.fromARGB(255, 224, 187, 245)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                 enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(color: const Color.fromARGB(255, 242, 235, 245), width: 1.0), // Border when not focused
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: BorderSide(color: const Color.fromARGB(255, 229, 204, 241), width: 1), // Border when focused
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),

            // Image Carousel
            CarouselSlider.builder(
              itemCount: imageList.length,
              itemBuilder: (context, index, realIndex) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset(
                    imageList[index],
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 250.0,
                  ),
                );
              },
              options: CarouselOptions(
                height: 250,
                viewportFraction: 1.0,
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
              ),
            ),
            SizedBox(height: 16.0),

            // Image Indicator
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(imageList.length, (index) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 3.0),
                  height: 8.0,
                  width: 8.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentIndex == index
                        ? Theme.of(context).primaryColor
                        : Colors.grey.shade300,
                  ),
                );
              }),
            ),
            SizedBox(height: 16.0),

            // Restaurant Details
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'The Black Pearl Restaurant',
                    style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4.0),
                  Text('Koramangala 5th Block', style: TextStyle(color: Colors.grey)),
                  SizedBox(height: 8.0),
                  Row(
                    children: [
                      Icon(Icons.star, color: 
Theme.of(context).primaryColor, size: 16.0),
                      Text('4.0', style: TextStyle(fontSize: 14.0)),
                      SizedBox(width: 8.0),
                      Text('46970 Ratings', style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                  SizedBox(height: 8.0),
                  Text('₹2000 Price for two - 10 yrs', style: TextStyle(color: Colors.grey)),
                  SizedBox(height: 8.0),
                  Text('Cuisine: Italian, Continental',
                      style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600)),
                  SizedBox(height: 4.0),
                  Text('Open Hours: 11:00 AM - 11:00 PM', style: TextStyle(color: Colors.grey)),
                ],
              ),
            ),
            SizedBox(height: 16.0),

            // Action Buttons Row
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  actionButton(Icons.call, 'Call', _makeCall),
                  actionButton(Icons.location_on, 'Map', () {}),
                  actionButton(Icons.menu_book, 'Menu', () {}),
                  actionButton(Icons.share, 'Share', () {}),
                ],
              ),
            ),
            SizedBox(height: 16.0),

            // Primary Buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: 
Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                      ),
                      child: Text('Order Online', style: TextStyle(color: Colors.white)),
                    ),
                  ),
                  SizedBox(width: 16.0),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: 
Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                      ),
                      child: Text('Book A Table', style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.0),

            // Similar Restaurants Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Similar Restaurants',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 8.0),
            SizedBox(
              height: 140.0,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  similarRestaurantCard(),
                  similarRestaurantCard(),
                  similarRestaurantCard(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget actionButton(IconData icon, String label, VoidCallback onPressed) {
    return Column(
      children: [
        CircleAvatar(
          radius: 25.0,
          backgroundColor: Colors.orange.shade100,
          child: IconButton(
            icon: Icon(icon, color: Colors.deepOrange),
            onPressed: onPressed,
          ),
        ),
        SizedBox(height: 4.0),
        Text(label, style: TextStyle(fontSize: 12.0)),
      ],
    );
  }

  Widget similarRestaurantCard() {
    return Container(
      width: 120.0,
      margin: EdgeInsets.only(right: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.asset(
              'assets/images/service/chinese5.jpg',
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 4.0),
          Text('Restaurant Name', style: TextStyle(fontWeight: FontWeight.bold)),
          Text('Location', style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}
