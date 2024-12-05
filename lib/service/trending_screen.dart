import 'package:flutter/material.dart';

import 'property_detailscreen.dart';
class ServiceTrendScreenState extends StatefulWidget {
  const ServiceTrendScreenState({super.key});

  @override
  State<ServiceTrendScreenState> createState() => ServiceTrendScreenStateState();
}

class ServiceTrendScreenStateState extends State<ServiceTrendScreenState> {
   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: (){
            Navigator.pop(context);
          },
          
          child: Icon(Icons.arrow_back_ios, color: Colors.white)),
        title: Text(
          'Trending',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Trending Header
            Text(
              'Trending Shops, Restaurants & Hotels',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 16),

            // Trending List of Items
            Expanded(
              child: ListView.builder(
                itemCount: 6, // Number of items (shop, restaurant, hotel)
                itemBuilder: (context, index) {
                  return InkWell(
onTap: (){
    Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>PropertyDetailsScreen())); 
},

                    child: TrendingCard(
                      title: index.isEven ? 'Shop ${index + 1}' : 'Restaurant ${index + 1}',
                      category: index.isEven ? 'Shop' : 'Restaurant',
                      imageUrl: 'assets/images/service/restaurant.jpg', // Replace with your image URL
                      description: 'This is a description of the ${index.isEven ? "shop" : "restaurant"}.',
                      rating: 4.5, // Add rating point here
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TrendingCard extends StatelessWidget {
  final String title;
  final String category;
  final String imageUrl;
  final String description;
  final double rating;

  TrendingCard({
    required this.title,
    required this.category,
    required this.imageUrl,
    required this.description,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12.0),
              topRight: Radius.circular(12.0),
            ),
            child: Image.asset(
              imageUrl,
              width: double.infinity,
              height: 120,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 8),
                // Category
                Text(
                  category,
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 8),
                // Description
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 8),
                // Rating
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: Colors.orange,
                      size: 18.0,
                    ),
                    SizedBox(width: 4),
                    Text(
                      rating.toString(),
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.orange,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                // Icon for added appeal
                Align(
                  alignment: Alignment.centerRight,
                  child: Icon(
                    Icons.star_border,
                    color: Colors.deepOrange,
                    size: 28.0,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}