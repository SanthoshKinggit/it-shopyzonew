import 'package:flutter/material.dart';

import '../product/product_viewscreen.dart';

class WishlistScreen extends StatefulWidget {
  @override
  _WishlistScreenState createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  final List<Map<String, dynamic>> wishlist = [
    {"name": "Snake Skin Bag", "price": "\$150.00", "imagePath": "assets/images/service/bag.png", "category": "Bags"},
    {"name": "Black Nike Shoes", "price": "\$80.00", "imagePath": "assets/images/service/shoe.png", "category": "Clothing"},
    {"name": "Black Nike Bag", "price": "\$200.00", "imagePath": "assets/images/service/purse.png", "category": "Shoes"},
    {"name": "Airtight Microphone", "price": "\$300.00", "imagePath": "assets/images/service/microphone.png", "category": "Electronics"},
  ];

  List<Map<String, dynamic>> filteredWishlist = [];
  TextEditingController searchController = TextEditingController();
  bool isSearchMode = false;
  String _selectedCategory = "All";
  List<String> _categories = ["All", "Bags", "Shoes", "Clothing", "Electronics"];
  List<String> recentSearches = [];
  String currentSearch = "";
  bool isLoading = false;  // For showing the loader

  @override
  void initState() {
    super.initState();
    filteredWishlist = wishlist;
  }

  void _filterWishlist() {
    setState(() {
      isLoading = true;  // Show loader
      currentSearch = searchController.text;

      filteredWishlist = wishlist.where((item) {
        final matchesCategory = _selectedCategory == "All" || item["category"] == _selectedCategory;
        final matchesSearch = searchController.text.isEmpty ||
            item["name"].toLowerCase().contains(searchController.text.toLowerCase());
        return matchesCategory && matchesSearch;
      }).toList();

      // Add to recent searches if not already present
      if (searchController.text.isNotEmpty && !recentSearches.contains(searchController.text)) {
        recentSearches.add(searchController.text);
      }

      isLoading = false;  // Hide loader
    });
  }

  void _removeRecentSearch(String search) {
    setState(() {
      recentSearches.remove(search);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        leading: InkWell(
          onTap: (){
            Navigator.pop(context);
          },
          
          child: Icon(Icons.arrow_back_ios,color: Colors.white,)),
        title: isSearchMode
            ? Padding(
              padding: const EdgeInsets.only(top:8.0,bottom: 8.0),
              child: TextField(
                  controller: searchController,
                  onChanged: (value) {
                    _filterWishlist();
                  },
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    hintText: 'Search wishlist...',
                    hintStyle: TextStyle(color: Colors.black.withOpacity(0.5), fontFamily: 'Nunito',),
                  
                    filled: true,
                      contentPadding: const EdgeInsets.all(10),
                    fillColor:  Colors.white, // Light grey fill
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ), 
                  ),
                 
                ),
            )
            : Text("My Wishlist", style: TextStyle(color: Colors.white, fontFamily: 'Nunito',fontWeight:FontWeight.bold)),
      backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
        actions: [
          InkWell(
            onTap: () {
              setState(() {
                isSearchMode = !isSearchMode;
                if (!isSearchMode) {
                  searchController.clear();
                  _filterWishlist();
                }
              });
            },
            child:  ImageIcon(AssetImage("assets/images/service/searchicon.png",),color: Colors.white,),
          ),
          SizedBox(width: 10,)
        ],
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          // Recent Searches Section
        if (recentSearches.isNotEmpty)
  Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Recent", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black, fontFamily: 'Nunito',)),
            GestureDetector(
              onTap: () {
                setState(() {
                  recentSearches.clear();
                });
              },
              child: Text("Clear All", style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black, fontSize: 12, fontFamily: 'Nunito',)),
            ),
          ],
        ),
        // SingleChildScrollView for horizontal scrolling
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: recentSearches.map((search) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Chip(
                  label: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(search, style: TextStyle( fontFamily: 'Nunito',),),
                      SizedBox(width: 8),
                      GestureDetector(
                        onTap: () => _removeRecentSearch(search),
                        child: Icon(Icons.close, size: 16, color: Colors.grey),
                      ),
                    ],
                  ),
                  backgroundColor: Colors.grey[200],
                ),
              );
            }).toList(),
          ),
        ),
      ],
    ),
  ),
               
          // Choice Chips for filtering (Only visible when not searching)
          if (!isSearchMode)
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: _categories.map((category) {
                  bool isSelected = _selectedCategory == category;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: ChoiceChip(
                      label: Text(
                        category,
                        style: TextStyle(
                           fontFamily: 'Nunito',
                          color: isSelected ? Colors.white : Theme.of(context).primaryColor,
                        ),
                      ),
                      selected: isSelected,
                      onSelected: (selected) {
                        setState(() {
                          _selectedCategory = category;
                          _filterWishlist();
                        });
                      },
                      backgroundColor: Colors.white,
                      selectedColor: Theme.of(context).primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(
                          color: Colors.transparent,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          // Loader
          if (isLoading)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(child: CircularProgressIndicator()),
            ),
          // Search Result Count
          if (!isLoading && currentSearch.isNotEmpty)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                  Text(
                  filteredWishlist.isEmpty
                      ? "Results for '$currentSearch'"
                      : "Results for '$currentSearch'",
                  style: TextStyle( fontFamily: 'Nunito',fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
                ),
                Text(
filteredWishlist.isEmpty

 ? " 0 found"
                      : "${filteredWishlist.length} found",
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold,  color: Colors.black),

                )
              ],
            ),
          // Wishlist items
          Expanded(
            child: filteredWishlist.isEmpty && !isLoading
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                     ImageIcon(AssetImage("assets/images/service/noitem.png"), color: Theme.of(context).primaryColor,size: 200,),
                      SizedBox(height: 16),
                      Text("Not Found", style: TextStyle( fontFamily: 'Nunito',fontSize: 18, color: Colors.black, fontWeight: FontWeight.w800),),
                      Text("Sorry, the keyboard you entered cannot be\nfound.please check again or search with\nanother keyword", style: TextStyle( fontFamily: 'Nunito',color: Colors.grey, fontSize: 12)),
                    ],
                  )
                : GridView.builder(
                    padding: EdgeInsets.all(16),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 0.65,
                    ),
                    itemCount: filteredWishlist.length,
                    itemBuilder: (context, index) {
                      final product = filteredWishlist[index];
                      return InkWell(onTap: (){
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
                  productname:product["name"]
                )),
              );
                        
                      },
                        child: WishlistProductCard(
                          name: product["name"],
                          price: product["price"],
                          imagePath: product["imagePath"],
                          onRemove: () {
                            setState(() {
                              wishlist.remove(product);
                              _filterWishlist();
                            });
                          },
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

class WishlistProductCard extends StatelessWidget {
  final String name;
  final String price;
  final String imagePath;
  final VoidCallback onRemove;

  const WishlistProductCard({
    required this.name,
    required this.price,
    required this.imagePath,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Stack(
          children: [
            Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 247, 247, 247),
                borderRadius: BorderRadius.circular(16),
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              top: 8,
              right: 8,
              child: GestureDetector(
                onTap: onRemove,
                child: CircleAvatar(
                  radius: 16,
                 backgroundColor: const Color.fromARGB(255, 214, 213, 213),
                  child: Icon(Icons.favorite, size: 16, color: Colors.red),
                ),
              ),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: TextStyle( fontFamily: 'Nunito',
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
                    Text("4.5", style: TextStyle( fontFamily: 'Nunito',fontSize: 14, color: Colors.grey)),
                  ],
                ),
                VerticalDivider(
                  color: const Color.fromARGB(255, 148, 147, 147),
                  thickness: 1,
                  indent: 4,
                  endIndent: 4,
                ),
               Container(
                    width: 90,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        "Sold 2345",
                        style: TextStyle( fontFamily: 'Nunito',fontSize: 14, color: Color.fromARGB(255, 1, 15, 39)),
                      ),
                    ),
                  ),
              
              ],
            ),
            Text(
              price,
              style: TextStyle( fontFamily: 'Nunito',
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: Color.fromARGB(255, 1, 15, 39),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
