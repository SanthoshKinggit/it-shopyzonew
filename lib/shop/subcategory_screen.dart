import 'package:flutter/material.dart';

import 'new_inscreen.dart';
import 'product_detailscreen.dart';
import 'show_allscreen.dart';


class SubcategoryScreen extends StatelessWidget {
  final List<Map<String, String>> subcategories = [
    {"name": "Men", "image": "assets/images/service/men.jpg"},
    {"name": "Kids", "image": "assets/images/service/kids.jpg"},
    {"name": "Girls", "image": "assets/images/service/girls.jpg"},
    {"name": "Women", "image": "assets/images/service/women.jpg"},
    {"name": "Party", "image": "assets/images/service/party.jpg"},
  ];

  final List<Map<String, dynamic>> products = [
    {
      "name": "Hoodie Rose",
      "price": "\$60.00",
      "image": "assets/images/service/hoodie2.jpg"
    },
    {
      "name": "Visionnaire Bleu",
      "price": "\$46.32",
      "image": "assets/images/service/hoodie1.jpg"
    },
    {
      "name": "Full Colored Hoodie",
      "price": "\$120.45",
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
        leading:InkWell(
          onTap: (){
            Navigator.pop(context);
          },
          
          child: Icon(Icons.arrow_back_ios, color: Colors.white,)),
        title: Text(
          "Collections",
          style: TextStyle(fontFamily: 'Nunito', fontWeight: FontWeight.bold,color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor:Theme.of(context).primaryColor,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 15,),
          // Subcategory Horizontal Scroll
          SizedBox(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: subcategories.length,
              itemBuilder: (context, index) {
                final subcategory = subcategories[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: (){
                           Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ShowAll()
                  ),);
                        },
                        child: CircleAvatar(
                          radius: 35,
                          backgroundImage: AssetImage(subcategory["image"]!),
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        subcategory["name"]!,
                        style: TextStyle(
                          fontFamily: 'Nunito',
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          // Product List
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "New In",
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                 InkWell(
                  onTap: (){
                   Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NewInPage()
                  ),
                );
                  },
                   child: Text(
                    "See All",
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontFamily: 'Nunito',
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                                   ),
                 ),
              ],
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                childAspectRatio: 0.75,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
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
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(15),
                            ),
                            child: Image.asset(
                              product["image"]!,
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product["name"]!,
                                style: TextStyle(
                                  fontFamily: 'Nunito',
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
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
    );
  }
}
