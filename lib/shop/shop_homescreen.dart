import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import 'dart:async';

import '../drawer/drawer_screen.dart';
import '../product/product_viewscreen.dart';
import 'category_screen.dart';
import 'most_popularscreen.dart';
import 'notification_page.dart';
import 'special_offerspage.dart';
import 'wishlist_screen.dart';




class ShopHomeScreen extends StatefulWidget {
  ShopHomeScreen({Key? key}) : super(key: key);

  @override
  _ShopHomeScreenState createState() => _ShopHomeScreenState();
}

class _ShopHomeScreenState extends State<ShopHomeScreen> {
  final PageController _pageController = PageController();


   int _currentIndex = 0; // Set the initial index to 1 (Shop tab)

  // Handle tab navigation
  void _onItemTapped(int index) {
    setState(() {
      currentIndex = index;
      _pageController.jumpToPage(index); // Jump to the page corresponding to the tab
    });
  }
int currentIndex = 1; 

    final List<Map<String, dynamic>> products = [
   {"name": "Snake Skin Bag", "price": "\$150.00", "imagePath": "assets/images/service/bag.png", "category": "Bags"},
    {"name": "Black Nike Shoes", "price": "\$80.00", "imagePath": "assets/images/service/shoe.png", "category": "Clothing"},
    {"name": "Black Nike Bag", "price": "\$200.00", "imagePath": "assets/images/service/purse.png", "category": "Shoes"},
    {"name": "Airtight Microphone", "price": "\$300.00", "imagePath": "assets/images/service/microphone.png", "category": "Electronics"},
   
  ];


   String _selectedCategory = "All";
  List<String> _categories = ["All", "Bags", "Clothing", "Shoes", "Electronics"];
  TextEditingController searchController = TextEditingController();

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

  final List<String> _banners = [
    'assets/images/service/third.jpg',
    'assets/images/service/one.jpg',
    'assets/images/service/once.jpg',
    'assets/images/service/twice.jpg',
    'assets/images/service/three.jpg',
  ];




  late Timer _timer;
 



    final Map<String, List<String>> categoryItems = {
    "All": ["Item 1", "Item 2", "Item 3", "Item 4", "Item 5"],
    "Clothes": ["Shirt", "Pants", "T-shirt"],
    "Shoes": ["Sneakers", "Boots", "Sandals"],
    "Bags": ["Backpack", "Handbag", "Laptop Bag"],
    "Electronics": ["Laptop", "Mobile Phone", "Headphones"],
  };
  bool _isDarkMode = false;
  String _selectedLanguage = 'English';

  void _onThemeChanged(bool value) {
    setState(() {
      _isDarkMode = value;
    });
  }

  void _onLogout() {
    // Handle logout functionality
  }
  List<String> filteredItems = []; // Default to all items

  void filterItemsByCategory(String category) {
    setState(() {
      if (category == "All") {
        filteredItems = categoryItems["All"]!;
      } else {
        filteredItems = categoryItems[category] ?? [];
      }
    });
  }
  late List<int> shuffledIndexes;

  @override
  void initState() {
    super.initState();

    shuffledIndexes = List<int>.generate(categories.length, (index) => index);
    shuffledIndexes.shuffle(Random());

    // Initialize the timer to automatically switch pages
    _timer = Timer.periodic(Duration(seconds: 3), (Timer timer) {
      if (_currentIndex < _banners.length - 1) {
        _currentIndex++;
      } else {
        _currentIndex = 0;
      }

      _pageController.animateToPage(
        _currentIndex,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }



 void _showLanguageBottomSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Select Language',
                style: TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              ListTile(
                title: const Text(
                  'English (US)',
                  style: TextStyle(
                    fontFamily: 'Nunito',
                  ),
                ),
                trailing: _selectedLanguage == 'English (US)'
                    ? const Icon(
                        Icons.check,
                        // color: primary,
                      )
                    : null,
                onTap: () {
                  setState(() {
                    _selectedLanguage = 'English (US)';
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text(
                  'Spanish',
                  style: TextStyle(
                    fontFamily: 'Nunito',
                  ),
                ),
                trailing: _selectedLanguage == 'Spanish'
                    ? const Icon(
                        Icons.check,
                        // color: primary,
                      )
                    : null,
                onTap: () {
                  setState(() {
                    _selectedLanguage = 'Spanish';
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              // Implement logout logic here
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => Homepage0()));
            },
            child: const Text(
              'Logout',
              style: TextStyle(
                color: Colors.red,
                fontFamily: 'Nunito',
              ),
            ),
          ),
        ],
      ),
    );
  }
  
 Widget _buildAnimatedItem(int index) {
    // Get the shuffled index for the current item
    int shuffledIndex = shuffledIndexes[index];
    
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 800),
      child: Container(
        key: ValueKey<int>(shuffledIndex),  // Unique key for each item to trigger animation
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                // Trigger swap when clicked
                setState(() {
                  shuffledIndexes.shuffle(Random());
                });
              },
              child: CircleAvatar(
                radius: 30,
                backgroundColor: const Color.fromARGB(255, 255, 252, 254), // Light grey
                child: Icon(
                  categories[shuffledIndex]['icon'],
                  size: 28,
                  color:Theme.of(context).primaryColor,
                ),
              ),
            ),
            SizedBox(height: 5),
            Text(
              categories[shuffledIndex]['name'],
              style: TextStyle(fontSize: 12, color: Colors.black,fontFamily: 'Nunito'),
            ),
          ],
        ),
      ),
    );
  }



  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
  drawer: CustomDrawer(
    selectedLanguage: _selectedLanguage,
    isDarkMode: _isDarkMode,
    onThemeChanged: _onThemeChanged,
    onLogout: _onLogout,
  ),
  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
  appBar: PreferredSize(
    preferredSize: Size.fromHeight(55), // Adjust height as needed
    child: AppBar(
      elevation: 0,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.black,
              const Color.fromARGB(255, 77, 76, 76),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.6, 1.0], // Adjust stops to control the distribution
          ),
        ),
      ),
      automaticallyImplyLeading: false,
    
      title: Container(
        height: 100,
        width: 100,
        child: Image.asset("assets/images/service/logo.png"),
      ),
      actions: [
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NotificationPage()),
            );
          },
          child: ImageIcon(
            AssetImage("assets/images/service/notification.png"),
           color: Color(0xFFCEA2FD),// Icon color for gradient contrast
          ),
        ),
        IconButton(
          icon: Icon(
            Icons.favorite,
            color: Color(0xFFCEA2FD),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => WishlistScreen()),
            );
            print("Favorite clicked");
          },
        ),
        Builder(
          builder: (context) => GestureDetector(
            onTap: () {
              Scaffold.of(context).openDrawer(); // Open the drawer on click
            },
            child: Container(
  width: 35, // Adjust as needed to ensure border visibility
  height: 35, // Same as width to keep it circular
  decoration: BoxDecoration(
    shape: BoxShape.circle,
    gradient: LinearGradient(
      colors: [Color(0xFFFFD700), // Bright gold
          Color(0xFFFFE135), // Light gold
          Color(0xFFC5A000), // Dark gold
          Color(0xFFFFD700), // Bright gold again to mimic shine
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        stops: [0.0, 0.3, 0.7, 1.0], // 
    ),
    border: Border.all(
      color: Colors.transparent, // Ensures the border color blends with the gradient
      width: 1, // Adjust width as needed
    ),
  ),
  child: CircleAvatar(
    backgroundImage: AssetImage('assets/images/service/profile.jpg'),
    radius: 15, // Adjust to fit inside the container and leave space for the border
  ),
)

          ),
        ),
      ],
    ),
  ),



      
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search bar
              TextField(
       controller: searchController,
              onChanged: (query) { 
                setState(() {
                  // Trigger filtering based on search input
                });
              },
                
                decoration: InputDecoration(
                  hintText: 'Search',
                  hintStyle: TextStyle(color: Theme.of(context).primaryColor,fontFamily: 'Nunito'),
                  suffixIcon: ImageIcon(AssetImage("assets/images/service/filtericon.png"), size: 3,color: Theme.of(context).primaryColor,),
                  prefixIcon: ImageIcon(AssetImage("assets/images/service/searchicon.png"), size: 3,color: Theme.of(context).primaryColor,),
                  // prefixIcon: Icon(Icons.search, color: const Color(0xFF8E8E8E)), // Icon in grey
                  filled: true,
                  fillColor:  Colors.white, // Light grey fill
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 20),
               if (searchController.text.isNotEmpty) ...[
              // Hide other content and show "No items found" if there are no matching items
              filteredItems.isEmpty
                  ? Center(child: Text("No items found"))
                  :Center(child: Text("No items found"))
                  //  Column(
                  //     children: filteredItems.map((item) => ListTile(title: Text(item))).toList(),
                  //   ),
            ] else ...[
              // Special Offers
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Special Offers",
                    style: TextStyle(fontFamily: 'Nunito',fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  TextButton(
                    onPressed: () {
      
         Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>SpecialOffersScreen()),
              );
      
                    },
                    child: Text(
                      "See All",
                      style: TextStyle(color: Theme.of(context).primaryColor,fontFamily: 'Nunito'), // Blue
                    ),
                  ),
                ],
              ),
              Container(
                height: 200,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: _banners.length,
                  itemBuilder: (context, index) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        _banners[index],
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                  onPageChanged: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                ),
              ),
              // SizedBox(height: 20),
              // Categories Grid
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Text(
              //       "Categories",
              //       style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
              //     ),
              //    TextButton(
              //       onPressed: () {},
              //       child: Text(
              //         "See All",
              //         style: TextStyle(color: Colors.black), // Blue
              //       ),
              //     ),
              //   ],
              // ),
              SizedBox(height: 10),  Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Category",
                    style: TextStyle(fontFamily: 'Nunito',fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  TextButton(
                    onPressed: () {
      
         Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>ShoppingCategoriesScreen()),
              );
      
                    },
                    child: Text(
                      "See All",
                      style: TextStyle(color: Theme.of(context).primaryColor,fontFamily: 'Nunito'), // Blue
                    ),
                  ),
                ],
              ),
               SizedBox(height: 10),
              GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 0.8,
        ),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return _buildAnimatedItem(index);
        },
      ),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Most Popular",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black,fontFamily: 'Nunito'),
                  ),
                    TextButton(
                    onPressed: () {
      
        Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MostPopularScreen()),
              );
      
                    },
                    child: Text(
                      "See All",
                      style: TextStyle(color: Theme.of(context).primaryColor,fontFamily: 'Nunito'), // Blue
                    ),
                  ),
                ],
              ),
                
              SizedBox(height: 10),
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
      
            GridView.builder(
        shrinkWrap: true, // Ensures GridView takes only as much space as needed
        physics: NeverScrollableScrollPhysics(), // Disable internal scrolling
        padding: EdgeInsets.all(8),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Two items per row
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.6, // Adjust for desired item height
        ),
        itemCount: filteredProducts.length,
        itemBuilder: (context, index) {
          final product = filteredProducts[index];
          return ProductCard(
            name: product["name"],
            price: product["price"],
            imagePath: product["imagePath"],
          );
        },
      ),
      SizedBox(height: 50,)
      
      
               ]   ],
          ),
        ),
      ),

     
    );
  }
}

// Categories data
final List<Map<String, dynamic>> categories = [
  {"icon": Icons.checkroom, "name": "Clothes"},
  {"icon": Icons.shopping_bag, "name": "Bags"},
  {"icon": Icons.electrical_services, "name": "Electronic"},
  {"icon": Icons.watch, "name": "Watches"},
  {"icon": Icons.sports_tennis, "name": "Shoes"},
  {"icon": Icons.kitchen, "name": "Kitchen"},
  {"icon": Icons.diamond, "name": "Jewelry"},
  {"icon": Icons.toys, "name": "Toys"},
];



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
            InkWell(
              onTap: (){

                   Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProductViewScreen(
                  initialImageIndex: 2, // Index of the selected image
      imageList: [
        widget.imagePath,
      widget.imagePath,
       widget.imagePath
      ],
                  // imagePath: widget.imagePath,
                  productname:widget.name
                )),
              );

              },
              child: Container(
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                  color:  Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: AssetImage(widget.imagePath),
                    fit: BoxFit.cover,
                  ),
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
       
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
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
        ),
        SizedBox(height: 4),
         Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
             Icon(Icons.star, size: 16, color: Colors.yellow),
            
             Text("4.5", style: TextStyle(fontSize: 14, color: Colors.grey,fontFamily: 'Nunito')),

              VerticalDivider(
           color:  Colors.white,
           thickness: 2,
           indent: 4,
           endIndent: 4,
         ),
                  
         Container(
             width: 75,
             height: 30,
             decoration: BoxDecoration(
               color: Colors.white,
               borderRadius: BorderRadius.circular(8),
             ),
             child: Center(
               child: Text(
                 "Sold 2345",
                 style: TextStyle(fontSize: 14, color: Color.fromARGB(255, 1, 15, 39),fontFamily: 'Nunito'),
               ),
             ),
           ),
           ],
         ),
        
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            widget.price,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
             color: const Color.fromARGB(255, 134, 17, 56),
             fontFamily: 'Nunito'
            ),
          ),
        ),
      ],
    );
  }
}

