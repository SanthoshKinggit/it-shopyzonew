import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../product/cart_screen.dart';




class ProductDetailsPage extends StatefulWidget {
  @override
  _ProductDetailsPageState createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  final Map<String, dynamic> product = {
    "name": "Full Colored Hoodie",
    "price": 120.45,
    "description":
        "Visionary hoodie. Multicolored pastel panels and Visionary embroidery on the chest. Made in Portugal. 100% Cotton 300g.",
    "images": [
      "assets/images/service/hoodie1.jpg",
      "assets/images/service/hoodie2.jpg",
      "assets/images/service/hoodie1.jpg",
    ],
    "colors": [
      Colors.red,
      Colors.blue,
      Colors.green,
      Colors.yellow,
    ],
  };

  final List<String> sizes = ["XXS", "M", "L", "XL"];
  int quantity = 1;
  int selectedColorIndex = 0;
  int selectedSizeIndex = 1;

  @override
  Widget build(BuildContext context) {
    double totalPrice = product["price"] * quantity;

    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: (){
            Navigator.pop(context);
          },
          
          child: Icon(Icons.arrow_back_ios, color: Colors.white,)),
        title: Text(
          "Products",
          style: TextStyle(fontFamily: 'Nunito', fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Image Slider
                    CarouselSlider(
                      items: (product["images"] as List<String>)
                          .map(
                            (image) => ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.asset(
                                image,
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ),
                            ),
                          )
                          .toList(),
                      options: CarouselOptions(
                        height: 300,
                        autoPlay: true,
                        enlargeCenterPage: true,
                      ),
                    ),
                    SizedBox(height: 16),
                    // Product Name and Price
                    Text(
                      product["name"]!,
                      style: TextStyle(
                        fontFamily: 'Nunito',
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "\$${product["price"].toStringAsFixed(2)}",
                      style: TextStyle(
                        fontFamily: 'Nunito',
                        fontSize: 20,
                        color: Colors.grey[700],
                      ),
                    ),
                    SizedBox(height: 16),
                    // Description
                    Text(
                      "Description",
                      style: TextStyle(
                        fontFamily: 'Nunito',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      product["description"]!,
                      style: TextStyle(
                        fontFamily: 'Nunito',
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(height: 16),
                    // Size Options
                    Text(
                      "Size",
                      style: TextStyle(
                        fontFamily: 'Nunito',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: sizes
                          .asMap()
                          .entries
                          .map(
                            (entry) => Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: ChoiceChip(
                                label: Text(
                                  entry.value,
                                  style: TextStyle(fontFamily: 'Nunito'),
                                ),
                                selected: selectedSizeIndex == entry.key,
                                onSelected: (selected) {
                                  setState(() {
                                    selectedSizeIndex = entry.key;
                                  });
                                },
                                selectedColor: Colors.deepPurple[100],
                              ),
                            ),
                          )
                          .toList(),
                    ),
                    SizedBox(height: 16),
                    // Color Variants
                    Text(
                      "Color",
                      style: TextStyle(
                        fontFamily: 'Nunito',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: (product["colors"] as List<Color>)
                          .asMap()
                          .entries
                          .map(
                            (entry) => GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedColorIndex = entry.key;
                                });
                              },
                              child: Container(
                                margin: const EdgeInsets.symmetric(horizontal: 8),
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: entry.value,
                                  border: selectedColorIndex == entry.key
                                      ? Border.all(
                                          color: Colors.deepPurple,
                                          width: 2,
                                        )
                                      : null,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                    SizedBox(height: 16),
                    // Quantity Selector and Total Price
                    Text(
                      "Quantity",
                      style: TextStyle(
                        fontFamily: 'Nunito',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  if (quantity > 1) quantity--;
                                });
                              },
                              icon: Icon(Icons.remove_circle_outline),
                            ),
                            Text(
                              "$quantity",
                              style: TextStyle(
                                fontFamily: 'Nunito',
                                fontSize: 18,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  quantity++;
                                });
                              },
                              icon: Icon(Icons.add_circle_outline),
                            ),
                          ],
                        ),
                        Text(
                          "\$${totalPrice.toStringAsFixed(2)}",
                          style: TextStyle(
                            fontFamily: 'Nunito',
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      // Floating Action Button with "+" Icon
        floatingActionButton: Align(
        alignment: Alignment.centerRight,
        child: FloatingActionButton(
          onPressed: () {

              CartItem newItem = CartItem(
        imageUrl: "assets/images/service/hoodie1.jpg",  // Passing image URL based on the current index
        name:  product["name"]!,  // Passing product name
        size: 'M',  // Assuming size is M, can be dynamic based on your implementation
        price: 385.00,  // Price of the product
      );

                   Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CartScreen(
cartItems: [newItem]


                  
                )),
              );
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Added to cart!")),
            );
          },
          child: Icon(Icons.add, color: Colors.white,),
          backgroundColor: Theme.of(context).primaryColor,
        ),
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerRigh,
    );
  }
}
