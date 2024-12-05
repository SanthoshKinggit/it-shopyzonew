import 'package:flutter/material.dart';

import '../product/product_viewscreen.dart';

class MostPopularScreen extends StatefulWidget {
  @override
  _MostPopularScreenState createState() => _MostPopularScreenState();
}

class _MostPopularScreenState extends State<MostPopularScreen> {
  final List<Map<String, dynamic>> products = [
    {"name": "Snake Skin Bag", "price": "\$150.00", "imagePath": "assets/images/service/bag.png", "category": "Bags"},
    {"name": "Black Nike Shoes", "price": "\$80.00", "imagePath": "assets/images/service/shoe.png", "category": "Clothing"},
    {"name": "Black Nike Bag", "price": "\$200.00", "imagePath": "assets/images/service/purse.png", "category": "Shoes"},
    {"name": "Airtight Microphone", "price": "\$300.00", "imagePath": "assets/images/service/microphone.png", "category": "Electronics"},
     {"name": "Snake Skin Bag", "price": "\$150.00", "imagePath": "assets/images/service/bag1.png", "category": "Bags"},
    {"name": "Black Nike Shoes", "price": "\$80.00", "imagePath": "assets/images/service/shoe1.png", "category": "Clothing"},
    {"name": "Black Nike Bag", "price": "\$200.00", "imagePath": "assets/images/service/purse1.png", "category": "Shoes"},
    {"name": "Airtight Microphone", "price": "\$300.00", "imagePath": "assets/images/service/microphone.png", "category": "Electronics"},
  ];

  TextEditingController searchController = TextEditingController();
  bool isSearchMode = false;
  String _selectedCategory = "All";
  List<String> _categories = ["All", "Bags", "Clothing", "Shoes", "Electronics"];

  List<Map<String, dynamic>> get filteredProducts {
    // Filter products based on the search text and selected category
    return products.where((product) {
      final matchesCategory =
          _selectedCategory == "All" || product["category"] == _selectedCategory;
      final matchesSearch = searchController.text.isEmpty ||
          product["name"]
              .toLowerCase()
              .contains(searchController.text.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: InkWell(
          onTap: (){
            Navigator.pop(context);
          },
          
          child: Icon(Icons.arrow_back_ios,color: Colors.white,)),
         backgroundColor: Theme.of(context).primaryColor,
        title: isSearchMode
            ? TextField(
                controller: searchController,
                onChanged: (value) {
                  setState(() {});
                },
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  hintText: 'Search product...',
                  hintStyle: TextStyle(color: Colors.white),
                  border: InputBorder.none,
                ),
              )
            : Text("Most Popular", style: TextStyle(color: Colors.white,fontFamily: 'Nunito')),
     centerTitle: true,
        elevation: 0,
        actions: [
          InkWell(
            onTap: (){
                  setState(() {
                isSearchMode = !isSearchMode;
              });
            },
            
            child: ImageIcon(AssetImage("assets/images/service/searchicon.png"), color: Theme.of(context).primaryColor,)),
          // IconButton(
          //   icon: Icon(Icons.search, color: Colors.black),
          //   onPressed: () {
          //     setState(() {
          //       isSearchMode = !isSearchMode;
          //     });
          //   },
          // ),
        ],
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal, // Make the chips scrollable horizontally
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start, // Align chips to the start
              children: _categories.map((category) {
                bool isSelected = _selectedCategory == category; // Check if the category is selected
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0), // Add horizontal space between chips
                  child: ChoiceChip(
                    label: Text(
                      category,
                      style: TextStyle(
                        fontFamily: 'Nunito',
                        color: isSelected
                            ? Colors.white // White text when selected
                            : Theme.of(context).primaryColor, // Dark blue text when unselected
                      ),
                    ),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        _selectedCategory = category; // Update the selected category
                      });
                    },
                    backgroundColor: Colors.white, // Background for unselected chip
                    selectedColor: Theme.of(context).primaryColor, // Background for selected chip
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20), // Adjust border radius
                      side: BorderSide(
                        color: Colors.transparent, // Blue border for both selected and unselected chips
                      ),
                    ),
                    avatar: null, // Ensures no tick icon is displayed when selected
                  ),
                );
              }).toList(),
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(10),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Two items per row
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.65, // Adjust for desired item height
              ),
              itemCount: filteredProducts.length,
              itemBuilder: (context, index) {
                final product = filteredProducts[index];
                return InkWell(
onTap: (){

   Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProductViewScreen(
                  initialImageIndex: 2, // Index of the selected image
      imageList: [
       product["imagePath"],
    product["imagePath"],
      product["imagePath"]
      ],
                  // imagePath: widget.imagePath,
                  productname:product["name"],
                )),
              );
},

                  child: ProductCard(
                    name: product["name"],
                    price: product["price"],
                    imagePath: product["imagePath"],
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

class ProductCard extends StatefulWidget {
  final String name;
  final String price;
  final String imagePath;

  const ProductCard({
    required this.name,
    required this.price,
    required this.imagePath,
  });

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> with TickerProviderStateMixin {
  bool isLiked = false;

  late AnimationController _scaleController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _scaleController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.easeInOut),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Image container with like/unlike button
        Stack(
          children: [
            Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 247, 247, 247),
                borderRadius: BorderRadius.circular(16),
                image: DecorationImage(
                  image: AssetImage(widget.imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              top: 8,
              right: 8,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    isLiked = !isLiked;
                    if (isLiked) {
                      _scaleController.forward();
                    } else {
                      _scaleController.reverse();
                    }
                  });
                },
                child: AnimatedBuilder(
                  animation: _scaleAnimation,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _scaleAnimation.value,
                      child: CircleAvatar(
                        radius: 16,
                         backgroundColor: const Color.fromARGB(255, 214, 213, 213),
                        child: Icon(
                          isLiked ? Icons.favorite : Icons.favorite_border,
                          color: isLiked ? Colors.red : Colors.white,
                          size: 18,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.name,
              style: TextStyle(
                fontFamily: 'Nunito',
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Color.fromARGB(255, 1, 15, 39),
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 4),
             Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.star, size: 16, color: Color.fromARGB(255, 1, 15, 39)),
                    SizedBox(width: 4),
                    Text("4.5", style: TextStyle(fontSize: 14, color: Colors.grey,fontFamily: 'Nunito')),
                  ],
                ),
                VerticalDivider(
                  color: const Color.fromARGB(255, 148, 147, 147),
                  thickness: 1,
                  indent: 4,
                  endIndent: 4,
                ),
                AnimatedOpacity(
                  opacity: isLiked ? 1.0 : 0.8,
                  duration: Duration(milliseconds: 200),
                  child: Container(
                    width: 90,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        "Sold 2345",
                        style: TextStyle(fontSize: 14, color: Color.fromARGB(255, 1, 15, 39),fontFamily: 'Nunito'),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Text(
              widget.price,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: Color.fromARGB(255, 1, 15, 39),
                fontFamily: 'Nunito'
              ),
            ),
          ],
        ),
      ],
    );
  }
}
