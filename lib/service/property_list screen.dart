import 'package:flutter/material.dart';

import 'property_detailscreen.dart';


class PropertyListingScreen extends StatefulWidget {
  @override
  _PropertyListingScreenState createState() => _PropertyListingScreenState();
}

class _PropertyListingScreenState extends State<PropertyListingScreen> {
  // List of properties with hotel names
  final List<Property> properties = [
    Property(name: 'Cozy Restaurant & Hotel', price: '\$2,900 / Mo', location: 'New York, Happy Meth Street 29'),
    Property(name: 'Luxury Restaurant & Hotel', price: '\$4,500 / Mo', location: 'Los Angeles, Sunset Blvd 30'),
    Property(name: 'Ocean View Hotel', price: '\$3,200 / Mo', location: 'Miami, Ocean Drive 10'),
    Property(name: 'Mountain Resort', price: '\$5,000 / Mo', location: 'Colorado, Mountain Peak 5'),
    Property(name: 'Urban City Hotel', price: '\$3,800 / Mo', location: 'Chicago, Downtown 12'),
  ];

  List<Property> filteredProperties = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredProperties = properties; // Initially show all properties
    searchController.addListener(_filterProperties); // Listen for text changes
  }

  // Filter properties based on search input
  void _filterProperties() {
    String query = searchController.text.toLowerCase();
    setState(() {
      filteredProperties = properties
          .where((property) =>
              property.name.toLowerCase().contains(query)) // Filter by hotel name
          .toList();
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Column(
        children: [
          // Header with Product Image
          Stack(
            children: [
              Container(
                height: 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                  image: DecorationImage(
                    image: AssetImage("assets/images/service/restaurant.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

            Positioned(
      top: 30, // Adjust the vertical position
      left: 20, // Adjust the horizontal position
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: CircleAvatar(
          backgroundColor: Colors.transparent, // Add a background for better visibility
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            size: 25, // Adjust the size of the icon
          ),
        ),
      ),
    ),
              Positioned(
                bottom: 20,
                left: 20,
                right: 20,
                child: Material(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(30),
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search, color: Colors.grey),
                      hintText: 'Search by hotel name...',
                      hintStyle: TextStyle(fontFamily: 'Nunito',),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.filter_list, color: Colors.grey),
                        onPressed: _filterProperties, // Trigger filter when clicked
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          // List of Filtered Properties with Image on the Right
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 20),
              itemCount: filteredProperties.length,
              itemBuilder: (context, index) {
                final property = filteredProperties[index];
                return InkWell(
                  onTap: (){
  Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>PropertyDetailsScreen())); 

                  },
                  child: Card(
                    margin: EdgeInsets.only(bottom: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Property Details
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  property.price,
                                  style: TextStyle(
                                    fontFamily: 'Nunito',
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  property.name, // Hotel Name
                                  style: TextStyle(
                                    fontFamily: 'Nunito',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  property.location,
                                  style: TextStyle(
                                    fontFamily: 'Nunito',
                                    color: Colors.grey,
                                    fontSize: 14,
                                  ),
                                ),
                                SizedBox(height: 12),
                                // Horizontal scrollable features
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: [
                                      PropertyFeature(icon: Icons.bed, label: '2 Beds'),
                                      SizedBox(width: 8),
                                      PropertyFeature(icon: Icons.bathtub, label: '2 Bath'),
                                      SizedBox(width: 8),
                                      PropertyFeature(icon: Icons.square_foot, label: '39 sqft'),
                                      SizedBox(width: 8),
                                      PropertyFeature(icon: Icons.kitchen, label: '1 Kitchen'),
                                      SizedBox(width: 8),
                                      PropertyFeature(icon: Icons.tv, label: '1 TV'),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // Image on the Right
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(15),
                            bottomRight: Radius.circular(15),
                          ),
                          child: Container(
                            height: 150, // Matches the card height
                            width: 120,
                            child: Image.asset(
                              "assets/images/service/restaurant.jpg", // Replace with product image
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Property {
  final String name;
  final String price;
  final String location;

  Property({required this.name, required this.price, required this.location});
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
          style: TextStyle(fontFamily: 'Nunito',color: Colors.grey, fontSize: 12),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
      ],
    );
  }
}




///
