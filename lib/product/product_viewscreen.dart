import 'package:flutter/material.dart';

import 'cart_screen.dart';
import 'product_reviewscreen.dart';


class ProductViewScreen extends StatefulWidget {
  final String productname;
  final int initialImageIndex; // Accept initial index
  final List<String> imageList; // Accept the image list

  ProductViewScreen({
    required this.productname,
    required this.initialImageIndex,
    required this.imageList,
  });

  @override
  _ProductViewScreenState createState() => _ProductViewScreenState();
}

class _ProductViewScreenState extends State<ProductViewScreen>
    with SingleTickerProviderStateMixin {
  late PageController _pageController;
  late int _currentImageIndex;
  int _quantity = 1; // Initialize quantity
  bool isLiked = false;

  late AnimationController _scaleController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.initialImageIndex);
    _currentImageIndex = widget.initialImageIndex;

    // Initialize the animation controller
    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    // Define the scale animation
    _scaleAnimation =
        Tween<double>(begin: 1.0, end: 1.2).animate(_scaleController)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _scaleController.reverse(); // Reverse back to normal scale
            }
          });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
  
 backgroundColor: Colors.white,
      appBar: AppBar(

  backgroundColor: Colors.white,
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios, color: Theme.of(context).primaryColor,),
        ),
        actions: [],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image Slider
                  Center(child: _buildImageSlider()),
                  SizedBox(height: 16),
                  // Product Title
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.productname,
                        style: TextStyle(
                           fontFamily: 'Nunito',
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 1, 15, 39),
                        ),
                      ),
                      SizedBox(width: 8), // Add some spacing between the text and the icon
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isLiked = !isLiked;
                          });

                          // Trigger the scale animation
                          if (isLiked) {
                            _scaleController.forward();
                          }
                        },
                        child: ScaleTransition(
                          scale: _scaleAnimation,
                          child: Icon(
                            isLiked ? Icons.favorite : Icons.favorite_border,
                            color: isLiked ? Colors.red : Colors.black, // Change white to black
                            size: 24, // Increase size for better visibility
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  // Product Rating
                  Row(
                    children: [

                      Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 236, 235, 235),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        "34567 sold",
        style: TextStyle(
           fontFamily: 'Nunito',
          fontSize: 14,
          color: Color.fromARGB(255, 1, 15, 39),
        ),
      ),
    ),   SizedBox(width: 4),
                      Icon(Icons.star, color: Theme.of(context).primaryColor, size: 20),
                      SizedBox(width: 4),
                      InkWell(onTap: (){

                          Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ReviewScreen()),
              );
                      },
                        child: Text(
                          "4.8 (4,974 reviews)",
                          style: TextStyle(
                             fontFamily: 'Nunito',
                            fontSize: 14,
                            color: Color.fromARGB(255, 1, 15, 39),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  // Product Description
                  Text(
                    "Description",
                    style: TextStyle(
                       fontFamily: 'Nunito',
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Color.fromARGB(255, 1, 15, 39),
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                    style: TextStyle( fontFamily: 'Nunito',color: Colors.grey, fontSize: 14),
                  ),
                  SizedBox(height: 16),
                  // Quantity Selector
                  Row(
                    children: [
                      Text(
                        "Quantity",
                        style: TextStyle( fontFamily: 'Nunito',
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Color.fromARGB(255, 1, 15, 39),
                        ),
                      ),
                      SizedBox(width: 8),
                      _buildQuantitySelector(),
                    ],
                  ),
                  SizedBox(height: 8),
                  SizedBox(height: 16),
                  // Total Price
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Total price",
                        style: TextStyle( fontFamily: 'Nunito',color: Colors.grey),
                      ),
                      Text(
                        "\$${(430.00 * _quantity).toStringAsFixed(2)}", // Calculate total price
                        style: TextStyle( fontFamily: 'Nunito',
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: Color.fromARGB(255, 1, 15, 39),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // Floating Action Button
          Positioned(
            right: 6,
            bottom: 162,
            child: FloatingActionButton(
              onPressed: () {
                CartItem newItem = CartItem(
        imageUrl: widget.imageList[_currentImageIndex],  // Passing image URL based on the current index
        name: widget.productname,  // Passing product name
        size: 'M',  // Assuming size is M, can be dynamic based on your implementation
        price: 385.00,  // Price of the product
      );

                   Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CartScreen(
cartItems: [newItem]


                  
                )),
              );
                print("Floating button clicked");
              },
              backgroundColor: Theme.of(context).primaryColor,
              child: Icon(Icons.add, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }


 
  // Quantity Selector Widget
  Widget _buildQuantitySelector() {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 236, 235, 235),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(Icons.remove, color: Color.fromARGB(255, 1, 15, 39)),
            onPressed: () {
              if (_quantity > 1) {
                setState(() {
                  _quantity--;
                });
              }
            },
          ),
          Text(
            "$_quantity",
            style: TextStyle( fontFamily: 'Nunito',
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 1, 15, 39),
            ),
          ),
          IconButton(
            icon: Icon(Icons.add, color: Color.fromARGB(255, 1, 15, 39)),
            onPressed: () {
              setState(() {
                _quantity++;
              });
            },
          ),
        ],
      ),
    );
  }

  // Image Slider Widget
  Widget _buildImageSlider() {
    return Column(
      children: [
        SizedBox(
          height: 200,
          child: PageView.builder(
            controller: _pageController,
            itemCount: widget.imageList.length,
            onPageChanged: (index) {
              setState(() {
                _currentImageIndex = index;
              });
            },
            itemBuilder: (context, index) {
              return Image.asset(
                widget.imageList[index],
                fit: BoxFit.cover,
              );
            },
          ),
        ),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            widget.imageList.length,
            (index) => Container(
              margin: EdgeInsets.symmetric(horizontal: 4),
              width: _currentImageIndex == index ? 12 : 8,
              height: 8,
              decoration: BoxDecoration(
                color: _currentImageIndex == index
                    ? Theme.of(context).primaryColor
                    : Colors.grey[400],
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
