// ignore_for_file: unused_local_variable, use_key_in_widget_constructors, no_leading_underscores_for_local_identifiers, prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print, prefer_const_constructors_in_immutables

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class PropertyDetailsScreen extends StatelessWidget {
  final List<String> imageUrls = [
    'assets/images/service/restaurant.jpg',
    'assets/images/service/restaurant.jpg',
    'assets/images/service/restaurant.jpg',
  ];

  // Method to show the form dialog
  void _showFormDialog(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    String name = '', phoneNumber = '', details = '';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Send Request'),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'Name'),
                  onSaved: (value) => name = value!,
                  validator: (value) => value!.isEmpty ? 'Name is required' : null,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Phone Number'),
                  keyboardType: TextInputType.phone,
                  onSaved: (value) => phoneNumber = value!,
                  validator: (value) => value!.isEmpty ? 'Phone number is required' : null,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Details'),
                  onSaved: (value) => details = value!,
                  validator: (value) => value!.isEmpty ? 'Details are required' : null,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  Navigator.of(context).pop(); // Close the form dialog
                  _showSuccessDialog(context); // Show success dialog
                }
              },
              child: Text('Submit'),
            ),
          ],
        );
      },
    );
  }

  // Method to show success dialog
  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Request Sent'),
          content: Text('Your request has been sent successfully!'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
        title: Text('Cozy Restaurant & Hotel', style: TextStyle(fontFamily: 'Nunito', color: Colors.white)),
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image Carousel with attractive look
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: CarouselSlider.builder(
                  itemCount: imageUrls.length,
                  itemBuilder: (context, index, realIdx) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Image.asset(
                        imageUrls[index],
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                  options: CarouselOptions(
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 3),
                    height: 200,
                    enlargeCenterPage: true,
                    viewportFraction: 0.8, // This ensures that the next/previous image is visible
                    enableInfiniteScroll: true,
                    initialPage: 0,
                    scrollPhysics: BouncingScrollPhysics(),
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Price and Location
              Text(
                '\$2,900 / Mo',
                style: TextStyle(fontFamily: 'Nunito', fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              Text(
                '4100 Southernly Pointe Dr, Haverstraw, NY 10927',
                style: TextStyle(fontFamily: 'Nunito', color: Colors.grey),
              ),
              SizedBox(height: 20),

              // Features
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  PropertyFeature(icon: Icons.bed, label: '2 Beds'),
                  PropertyFeature(icon: Icons.bathtub, label: '2 Bath'),
                  PropertyFeature(icon: Icons.square_foot, label: '39 sqft'),
                ],
              ),
              SizedBox(height: 20),

              // Description
              Text(
                'Great place if you have children. There are a few schools, dental clinics, and banks in the area.',
                style: TextStyle(fontFamily: 'Nunito', fontSize: 16, color: Colors.black87),
              ),
              SizedBox(height: 20),

              // Amenities
              Text(
                'Amenities',
                style: TextStyle(fontFamily: 'Nunito', fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Wrap(
                spacing: 10,
                children: [
                  Chip(label: Text('Washer/Dryer')),
                  Chip(label: Text('Central Air')),
                  Chip(label: Text('Private Outdoor Garden')),
                ],
              ),
              SizedBox(height: 20),

              // Contact Agent
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage('assets/images/service/profile.jpg'), // Agent image
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Real Estate Agent\nKatalina McGregor',
                    style: TextStyle(fontFamily: 'Nunito', fontSize: 16),
                  ),
                ],
              ),
              SizedBox(height: 20),

              // Button with call icon
              Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    Expanded(
      child: ElevatedButton(
        onPressed: () {
          _showFormDialog(context); // Show form dialog on button press
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).primaryColor,
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25), // Increase the padding for larger button
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        child: Text(
          'Send request',
          style: TextStyle(fontFamily: 'Nunito', fontSize: 18, color: Colors.white),
        ),
      ),
    ),
    SizedBox(width: 10),
    CircleAvatar(
      radius: 25, // Adjust the size of the circle
      backgroundColor: Theme.of(context).primaryColor, // Background color of the circle
      child: IconButton(
        icon: Icon(Icons.call, color: Colors.white),
        onPressed: () {
          // Call functionality
          print('Calling the agent...');
        },
      ),
    ),
  ],
),

            ],
          ),
        ),
      ),
    );
  }
}

class PropertyFeature extends StatelessWidget {
  final IconData icon;
  final String label;

  PropertyFeature({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 14, color: Colors.grey),
        SizedBox(width: 4),
        Text(
          label,
          style: TextStyle(fontFamily: 'Nunito', color: Colors.grey, fontSize: 12),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
      ],
    );
  }
}
