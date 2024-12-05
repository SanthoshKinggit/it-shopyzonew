import 'package:flutter/material.dart';

import 'product_detailscreen.dart';


class NewInPage extends StatelessWidget {
  final List<Map<String, dynamic>> newProducts = [
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
          "New In",
          style: TextStyle(fontFamily: 'Nunito', fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 5.0,
            mainAxisSpacing: 5.0,
            childAspectRatio: 0.75,
          ),
          itemCount: newProducts.length,
          itemBuilder: (context, index) {
            final product = newProducts[index];
            return InkWell(
              onTap: (){
                  Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductDetailsPage()
                  ),
                );
              },
              child: Card(
                elevation: 5,
                shadowColor: Colors.black.withOpacity(0.2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
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
                            height: MediaQuery.of(context).size.width * 0.35, // Make image size smaller
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
    );
  }
}
