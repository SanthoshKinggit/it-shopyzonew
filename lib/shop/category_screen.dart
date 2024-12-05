import 'package:flutter/material.dart';

import 'subcategory_screen.dart';

class ShoppingCategoriesScreen extends StatelessWidget {
 final List<Map<String, dynamic>> categories = [
    {
      "name": "Clothing",
      "image": "assets/images/service/cloth.jpg",
      "subcategories": ["Men's Wear", "Women's Wear", "Kids' Wear", "Winter Wear"]
    },
    {
      "name": "Electronics",
      "image": "assets/images/service/electrical.jpeg",
      "subcategories": ["Mobiles", "Laptops", "Cameras", "Accessories"]
    },
    {
      "name": "Shoes",
      "image": "assets/images/service/shoes.jpg",
      "subcategories": ["Men's Shoes", "Women's Shoes", "Sports Shoes", "Casual Shoes"]
    },
    {
      "name": "Bags",
      "image": "assets/images/service/bags.jpg",
      "subcategories": ["Backpacks", "Handbags", "Suitcases", "Laptop Bags"]
    },
    {
      "name": "Accessories",
      "image": "assets/images/service/access.jpg",
      "subcategories": ["Jewelry", "Watches", "Belts", "Hats"]
    },
    {
      "name": "Home Decor",
      "image": "assets/images/service/homedecor.jpg",
      "subcategories": ["Furniture", "Wall Art", "Lighting", "Vases"]
    },
    {
      "name": "Beauty",
      "image": "assets/images/service/beauty.jpg",
      "subcategories": ["Makeup", "Skincare", "Haircare", "Perfumes"]
    },
    {
      "name": "Sports",
      "image": "assets/images/service/sports.jpg",
      "subcategories": ["Cricket", "Football", "Badminton", "Cycling"]
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: (){
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios, color: Colors.white,)),
          
        title: Text(
          "Shop Categories",
          style: TextStyle(fontFamily: 'Nunito', fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
            childAspectRatio: 1,
          ),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final category = categories[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SubcategoryScreen(
                      // categoryName: category["name"]!,
                      // subcategories: category["subcategories"],
                    ),
                  ),
                );
              },
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Stack(
                    children: [
                      Image.asset(
                        category["image"]!,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                      Container(
                        color: Colors.black.withOpacity(0.4),
                        alignment: Alignment.center,
                        child: Text(
                          category["name"]!,
                          style: TextStyle(
                            fontFamily: 'Nunito',
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
