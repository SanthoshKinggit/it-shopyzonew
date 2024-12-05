import 'package:flutter/material.dart';

import 'restaurant_detailscreen.dart';
import 'shop_detail.dart';

class RestaurantSearchUI extends StatefulWidget {
  @override
  _RestaurantSearchUIState createState() => _RestaurantSearchUIState();
}

class _RestaurantSearchUIState extends State<RestaurantSearchUI> {
  TextEditingController searchController = TextEditingController();
  List<String> restaurantNames = [
    'Chickeno Restaurant',
    'Dragon Delights',
    '1947 Fine Indian Cuisine',
    'Golden Dragon',
  ];
  List<String> filteredRestaurantNames = [];

  @override
  void initState() {
    super.initState();
    filteredRestaurantNames = restaurantNames;
  }

  void filterRestaurants(String query) {
    setState(() {
      filteredRestaurantNames = restaurantNames
          .where((name) => name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: InkWell(
          onTap: (){
            Navigator.pop(context);
          },
          
          child: Icon(Icons.arrow_back_ios, color: const Color.fromARGB(255, 197, 197, 197))),
        title: Text("ShopyZo", style: TextStyle(fontFamily: 'Nunito',color: 
Theme.of(context).primaryColor,fontWeight: FontWeight.w800),),
        actions: [
          Icon(Icons.notifications, color: Theme.of(context).primaryColor),
          SizedBox(width: 10),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10),
              child: TextField(
                controller: searchController,
                onChanged: filterRestaurants,
                decoration: InputDecoration(
                  hintText: 'Search for a restaurant',
                  hintStyle: TextStyle(fontFamily: 'Nunito',color:  Theme.of(context).scaffoldBackgroundColor,),
                  prefixIcon: ImageIcon(
                    AssetImage("assets/images/service/searchicon.png"),
                    color: Theme.of(context).scaffoldBackgroundColor,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none, // Removes the border line
                  ),
                  filled: true,
                  fillColor: Colors.white, // Background color
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
            // Banner Section
            InkWell(

              onTap: (){
                Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>  RestaurantDetailsPage())); 
              },
              child: Container(
                height: 120,
                margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                padding: EdgeInsets.only(left: 12.0, right: 12.0),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(218, 169, 30, 233),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Stack(
                  clipBehavior: Clip.none, // Allow the image to go outside the container bounds
                  children: [
                    // Image banner at the top of the container
                    Positioned(
                      top: -20, // Move the image above the container
                      left: 20,
                      right: -22,
                      bottom: 0,
                      child: SizedBox(
                        height: 30, // Height of the image banner
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0), // Same border radius as container
                          child: Image.asset(
                            "assets/images/service/chefad.png",
                            fit: BoxFit.cover,
                            height: double.maxFinite,
                            width: 30.0, // Reduce the width
                          ),
                        ),
                      ),
                    ),
                    // Row with text and button inside the container
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: 10),
                            Text(
                              '1947 Fine Indian Cuisine',
                              style: TextStyle(
                                fontFamily: 'Nunito',
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Malleshwaram, Bangalore',
                              style: TextStyle(fontFamily: 'Nunito',color: Colors.white),
                            ),
                            SizedBox(height: 10),
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(Icons.call, color: Colors.orange, size: 20),
                                  Text(
                                    'Call',
                                    style: TextStyle(fontFamily: 'Nunito',color: Colors.orange),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            // Filter Section
  Padding(
  padding: const EdgeInsets.symmetric(horizontal: 16.0),
  child: SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(
      children: [
        Container(
           padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
           decoration: BoxDecoration(
        color:  Colors.white, // Background color
        border: Border.all(
          color: Colors.grey[400]!, // Border color
        ),
        borderRadius: BorderRadius.circular(10.0),), // Rounded corners
          child: ImageIcon(AssetImage("assets/images/service/filtericon.png"))),
        SizedBox(width: 8.0), // Space between items
        buildFilterButton('Chinese', true),
        SizedBox(width: 8.0),
        buildFilterButton('Sort by', false),
        SizedBox(width: 8.0),
        buildFilterButton('Price', false),
        SizedBox(width: 8.0),
        buildFilterButton('Top Rated', false),
        SizedBox(width: 8.0),
        buildFilterButton('Others', false), // Add more filters if needed
      ],
    ),
  ),
),


            SizedBox(height: 16.0),
            // Restaurant List Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: filteredRestaurantNames.map((restaurant) {
                  return buildRestaurantCard(
                    context,
                    restaurant,
                    '4.0',
                    '201 Ratings',
                    'Nandini Layout, Bangalore',
                    'Open until 11:00 PM',
                    ['Fresh food', 'Quick bites'],
                    'assets/images/service/chinese1.jpeg', // Replace with your image URL
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildFilterButton(String label, bool isSelected) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0), // Adjust padding
      decoration: BoxDecoration(
        color: isSelected ? 
Theme.of(context).primaryColor : Colors.white, // Background color
        border: Border.all(
          color: isSelected ? Colors.transparent : Colors.white, // Border color
        ),
        borderRadius: BorderRadius.circular(20.0), // Rounded corners
        boxShadow: isSelected
            ? [
                BoxShadow(
                  color: const Color.fromARGB(255, 195, 0, 255).withOpacity(0.3),
                  offset: Offset(0, 2), // Slight shadow below
                  blurRadius: 4,
                ),
              ]
            : [],
      ),
      child: Row(
        children: [
          if (isSelected) Icon(Icons.check, size: 16, color: Colors.white), // Optional icon
          if (isSelected) SizedBox(width: 6), // Spacing between icon and text
          Text(
            label,
            style: TextStyle(fontFamily: 'Nunito',
              color: isSelected ? Colors.white : Colors.black, // Text color
              fontSize: 14.0, // Text size
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

Widget buildRestaurantCard(
  BuildContext context,
  String name,
  String rating,
  String reviews,
  String location,
  String timing,
  List<String> tags,
  String imageUrl,
) {
  return InkWell(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => RestaurantDetailPage(
            name: name,
            location: location,
            rating: rating,
            timing: timing,
            tags: tags,
            imageUrl: imageUrl,
          ),
        ),
      );
    },
    child: Card(
      color: Colors.white,
      elevation: 5.0, // Slightly higher elevation for a better card shadow
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)), // Rounded corners
      child: Stack(
        children: [
          // Row with content (Image, Name, Rating, Location, etc.)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image on the left
              ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: Image.asset(
                  imageUrl,
                  height: 120, // Full height of the card
                  width: 120,  // Fixed width
                  fit: BoxFit.cover,
                ),
              ),
              
              // Content on the right
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Restaurant name
                      Text(
                        name,
                        style: TextStyle(
                          fontFamily: 'Nunito',
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis, // Truncate if the text is too long
                      ),
                      
                      // Rating and reviews
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.green, size: 18.0),
                          SizedBox(width: 4.0),
                          Text(
                            rating,
                            style: TextStyle(
                              fontFamily: 'Nunito',
                              color: Colors.green,
                              fontSize: 14.0,
                            ),
                          ),
                          SizedBox(width: 8.0),
                          Text(
                            reviews,
                            style: TextStyle(fontSize: 12.0, color: Colors.grey),
                          ),
                        ],
                      ),
                      SizedBox(height: 2.0),
          
                      // Location and timing
                      Text(
                        location,
                        style: TextStyle(
                          fontFamily: 'Nunito',
                          fontSize: 12.0,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(height: 2.0),
                      Text(
                        timing,
                        style: TextStyle(
                          fontFamily: 'Nunito',
                          fontSize: 12.0,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          
          // Call button at the bottom-right corner
          Positioned(
            bottom: 10.0, // Distance from the bottom edge
            right: 10.0, // Distance from the right edge
            child: GestureDetector(
              onTap: () {
                // Add phone number or calling functionality here
                print('Call button pressed');
              },
              child: CircleAvatar(
                radius: 20.0, // Size of the circle
                backgroundColor: Theme.of(context).primaryColor,
                child: Icon(
                  Icons.call,
                  color: Colors.white,
                  size: 24.0, // Size of the call icon
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}}
