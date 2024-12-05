import 'package:flutter/material.dart';

import 'product_detailscreen.dart';

class ShowAll extends StatefulWidget {
  @override
  _ShowAllState createState() => _ShowAllState();
}

class _ShowAllState extends State<ShowAll> {
  // Sample list of products (can be dynamic from your data source)
  final List<Map<String, dynamic>> allProducts = [
    {
      "name": "Hoodie Bleu Ciel",
      "price": "\$64.40",
      "image": "assets/images/service/hoodie2.jpg"
    },
    {
      "name": "Full Colored Hoodie",
      "price": "\$120.45",
      "image": "assets/images/service/hoodie1.jpg"
    },
    {
      "name": "Visionnaire Lavande",
      "price": "\$60.85",
      "image": "assets/images/service/hoodie2.jpg"
    },
    {
      "name": "Crewneck Sweatshirt",
      "price": "\$60.85",
      "image": "assets/images/service/hoodie1.jpg"
    },
  ];

  // List to store filtered products based on search input
  late List<Map<String, dynamic>> filteredProducts;

  // Controller to manage the search input
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initially, the filtered products are the same as all products
    filteredProducts = allProducts;
  }

  // Function to filter products based on the search query
  void _filterProducts(String query) {
    setState(() {
      filteredProducts = allProducts
          .where((product) =>
              product["name"].toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
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
        title: Text(
          "Men's Colledction",
          style: TextStyle(fontFamily: 'Nunito', fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Search bar to filter products
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search for products...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: (query) {
                _filterProducts(query);
              },
            ),
            SizedBox(height: 16),
            // Display filtered products
            Expanded(
              child: filteredProducts.isEmpty
                  ? Center(child: Text("No products found"))
                  : GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16.0,
                        mainAxisSpacing: 16.0,
                        childAspectRatio: 0.61,
                      ),
                      itemCount: filteredProducts.length,
                      itemBuilder: (context, index) {
                        final product = filteredProducts[index];
                        return InkWell(
                          onTap: (){
                               Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductDetailsPage()
                  ),);
                          },
                          child: Card(
                            elevation: 8,
                            shadowColor: Colors.black.withOpacity(0.2),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              children: [
                                // Stack for image and favorite icon
                                Stack(
                                  children: [
                                    // Image container with a smaller image
                                    ClipRRect(
                                      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                                      child: Container(
                                        height: MediaQuery.of(context).size.width * 0.45, // Make image size smaller
                                        width: double.infinity, // Ensure image stretches across the width
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(product["image"]!),
                                            fit: BoxFit.cover, // Ensure the image fits inside the container
                                          ),
                                          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                                        ),
                                      ),
                                    ),
                                    // Favorite icon positioned at top-right corner
                                    Positioned(
                                      top: 10,
                                      right: 10,
                                      child: InkWell(
                                        onTap: () {
                                          // Add your logic for the "Like" button here
                                          print('Liked!');
                                        },
                                        child: Container(
                                          padding: EdgeInsets.all(6),
                                          decoration: BoxDecoration(
                                            color: Colors.white.withOpacity(0.7),
                                            shape: BoxShape.circle,
                                          ),
                                          child: Icon(
                                            Icons.favorite_border,
                                            color: Colors.red,
                                            size: 20,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                // Product details below the image
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        product["name"]!,
                                        style: TextStyle(
                                          fontFamily: 'Nunito',
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black87,
                                        ),
                                        maxLines: 1, // Limit the number of lines for name
                                        overflow: TextOverflow.ellipsis, // Ensure text doesn't overflow
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        product["price"]!,
                                        style: TextStyle(
                                          fontFamily: 'Nunito',
                                          fontSize: 14,
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                    ],
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
      ),
    );
  }
}
