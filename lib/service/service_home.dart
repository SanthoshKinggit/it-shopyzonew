import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import '../drawer/drawer_screen.dart';
import 'restaurant_detailscreen.dart';
import 'restaurant_screen.dart';
import 'sub_categoryscreen.dart';
import 'trending_screen.dart';

class JustDialUI extends StatefulWidget {
  @override
  _JustDialUIState createState() => _JustDialUIState();
}

class _JustDialUIState extends State<JustDialUI> {
  final List<Map<String, dynamic>> categories = [
    {"icon": Icons.business, "label": "B2B", "color": Colors.red},
    {"icon": Icons.local_hospital, "label": "Doctors", "color": Colors.green},
    {"icon": Icons.flight, "label": "Travel", "color": Colors.blue},
    {"icon": Icons.brush, "label": "Beauty", "color": Colors.pink},
    {"icon": Icons.school, "label": "Education", "color": Colors.orange},
    {"icon": Icons.person, "label": "Consultants", "color": Colors.purple},
    {
      "icon": Icons.home_repair_service,
      "label": "Rent & Hire",
      "color": Colors.teal
    },
    {
      "icon": Icons.event,
      "label": "Wedding Requisites",
      "color": Colors.yellow
    },
    {
      "icon": Icons.design_services,
      "label": "Interiors Designers",
      "color": Colors.cyan
    },
    {"icon": Icons.home, "label": "Home Services", "color": Colors.indigo},
    {
      "icon": Icons.build,
      "label": "Repairs & Services",
      "color": Colors.lightGreen
    },
    {"icon": Icons.construction, "label": "Contractors", "color": Colors.amber},
    {
      "icon": Icons.account_balance,
      "label": "Loans",
      "color": Colors.deepOrange
    },
    {
      "icon": Icons.real_estate_agent,
      "label": "Real Estate",
      "color": Colors.blueGrey
    },
    {"icon": Icons.explore, "label": "jd Xperts", "color": Colors.deepPurple},
  ];

  final List<Map<String, String>> imageTextList = [
    {"image": 'assets/images/service/food.jpg', "text": 'Food'},
    {"image": 'assets/images/service/giftcard.jpg', "text": 'GiftCard'},
    {"image": 'assets/images/service/shopping.jpg', "text": 'Shopping'},
    {"image": 'assets/images/service/electrician.jpg', "text": 'Electrician'},
    {"image": 'assets/images/service/hospital.jpg', "text": 'Hospital'},
    {"image": 'assets/images/service/delivery.jpg', "text": 'Delivery'},
  ];

  final List image = [
    'assets/images/service/fit1.jpg',
    'assets/images/service/fit2.jpg',
    'assets/images/service/fit3.jpg',
    'assets/images/service/fit4.jpg',
    'assets/images/service/fit1.jpg',
    'assets/images/service/fit2.jpg',
    'assets/images/service/fit3.jpg',
    'assets/images/service/fit4.jpg',
  ];

  List<String> restaurantNames = [
    'Chickeno Restaurant',
    'Dragon Delights',
    '1947 Fine Indian Cuisine',
    'Golden Dragon',
  ];
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

  final PageController _pageController = PageController();
    void _onItemTapped(int index) {
    setState(() {
      currentIndex = index;
      _pageController.jumpToPage(index); // Jump to the page corresponding to the tab
    });
  }
int currentIndex = 4; 

 String selectedLanguage = 'English (US)';
   bool isDarkMode = false;
  List<String> filteredRestaurantNames = [];
    TextEditingController searchController = TextEditingController();
    List<String> filteredItems = [];

  @override
  void initState() {
    super.initState();
    filteredRestaurantNames =
        restaurantNames; // Initialize filtered list with all restaurants
  }

  void filterRestaurants(String query) {
    setState(() {
      filteredRestaurantNames = restaurantNames
          .where((name) => name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

// void _showLogoutDialog() {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('Logout'),
//         content: const Text('Are you sure you want to logout?'),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('Cancel'),
//           ),
//           TextButton(
//             onPressed: () {
//               // Implement logout logic here
//               Navigator.push(context,
//                   MaterialPageRoute(builder: (context) => Homepage0()));
//             },
//             child: const Text(
//               'Logout',
//               style: TextStyle(
//                 color: Colors.red,
//                 fontFamily: 'Nunito',
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }


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
                trailing: selectedLanguage == 'English (US)'
                    ? const Icon(
                        Icons.check,
                        // color: primary,
                      )
                    : null,
                onTap: () {
                  setState(() {
                    selectedLanguage = 'English (US)';
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
                trailing: selectedLanguage == 'Spanish'
                    ? const Icon(
                        Icons.check,
                        // color: primary,
                      )
                    : null,
                onTap: () {
                  setState(() {
                    selectedLanguage = 'Spanish';
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

 Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    String? value,
    required Function() onTap,
    Color? titleColor,
    Widget? trailing,
    bool showArrow = false,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: Colors.grey[600],
        size: 24,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: titleColor ?? Colors.black87,
          fontSize: 16,
          fontFamily: 'Nunito',
        ),
      ),
      trailing: trailing ??
          (showArrow
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (value != null)
                      Text(
                        value,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontFamily: 'Nunito',
                          fontSize: 14,
                        ),
                      ),
                    if (value != null) const SizedBox(width: 8),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.grey[400],
                      size: 16,
                    ),
                  ],
                )
              : null),
      onTap: () {
        // Close drawer before navigation
        Navigator.pop(context);
        onTap();
      },
    );
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(5.0),
          child: CircleAvatar(
            backgroundImage: AssetImage('assets/images/service/profile.jpg'),
          ),
        ),
        centerTitle: true,
        title: Text(
          'ShopyZo',
          style: TextStyle(
             fontFamily: 'Nunito',
            color: Theme.of(context).primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          
          SizedBox(width: 10),
          InkWell(
            onTap: (){
              //  Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => NotificationPage()),
              // );
            },
            child: Icon(Icons.notifications, color: Theme.of(context).primaryColor,)),
          SizedBox(width: 10),
        ],
      ),
      body: SingleChildScrollView(
        // Make the entire body scrollable
        child: Column(
          children: [
            // Banner Carousel Section
            // Container(
            //   height: 200,
            //   child: PageView.builder(
            //     itemCount: 3, // You can change this based on your banner items
            //     itemBuilder: (context, index) {
            //       return ClipRRect(
            //         borderRadius: BorderRadius.circular(10.0),
            //         child: Image.asset(
            //           'assets/images/service/service.png', // Add banners as assets
            //           fit: BoxFit.cover,
            //         ),
            //       );
            //     },
            //   ),
            // ),

            // Search Bar
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                 controller: searchController,
              onChanged: (query) {
                setState(() {
                  // Trigger filtering based on search input
                });
              },
               
                decoration: InputDecoration(
                  hintText: 'Packers and Movers',
                  hintStyle:
                      TextStyle(
 fontFamily: 'Nunito',
color: Theme.of(context).iconTheme.color),
                  prefixIcon: ImageIcon(
                    AssetImage("assets/images/service/searchicon.png"),
                    size: 20,
                    color: Theme.of(context).iconTheme.color,
                  ),
                  suffixIcon:
                      Icon(Icons.mic, color: Theme.of(context).iconTheme.color),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(
                        color: const Color.fromARGB(255, 245, 241, 235),
                        width: 1.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: BorderSide(
                        color: const Color.fromARGB(255, 241, 213, 204),
                        width: 1),
                  ),
                ),
                style: TextStyle(
 fontFamily: 'Nunito',
color: Colors.black),
              ),
            ),
             if (searchController.text.isNotEmpty) ...[
              // Hide other content and show "No items found" if there are no matching items
              filteredItems.isEmpty
                  ? Center(child: Text("No items found"))
                  :Center(child: Text("No items found"))
                  //  Column(
                  //     children: filteredItems.map((item) => ListTile(title: Text(item))).toList(),
                  //   ),
            ] else ...[

            // Category Grid Section with Better Styling
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  // Determine how many categories can fit based on screen width
                  int columns = (constraints.maxWidth / 100)
                      .floor(); // Divide by a fixed number (e.g., 100 for padding/width)

                  // Minimum 2 items per row, maximum 4 items per row
                  columns = columns < 4 ? 5 : (columns > 5 ? 5 : columns);

                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SubCategoryscreen()),
                      );
                    },
                    child: GridView.builder(
                      shrinkWrap:
                          true, // Makes the GridView take only the necessary space
                      physics:
                          NeverScrollableScrollPhysics(), // Disable scrolling of GridView
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount:
                            columns, // Number of columns based on screen size
                        crossAxisSpacing: 16.0,
                        mainAxisSpacing: 16.0,
                        childAspectRatio:
                            0.6, // Adjust item aspect ratio (height/width ratio)
                      ),
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        var category = categories[index];
                        return buildIconCard(
                          category["icon"],
                          category["label"],
                          category["color"],
                        );
                      },
                    ),
                  );
                },
              ),
            ),

            // Horizontal Scrollable Service List Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                scrollDirection:
                    Axis.horizontal, // Set scroll direction to horizontal
                child: Row(
                  children: imageTextList.map((item) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: buildImageWithText(item["image"]!, item["text"]!),
                    );
                  }).toList(),
                ),
              ),
            ),

            // Trending Services Section
            Container(
              color: Colors.white,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: InkWell(
                  onTap: (){
 Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ServiceTrendScreenState()),
        );

                  },
                  child: Text(
                    'Trending Services',
                    style: TextStyle(
                   fontFamily: 'Nunito',
                  fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                  childAspectRatio: 1.5,
                ),
                itemCount: imageTextList.length,
                itemBuilder: (context, index) {
                  var item = imageTextList[index];
                  return buildImage(item["image"]!, item["text"]!);
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Health & Fitness',
                  style: TextStyle(
 fontFamily: 'Nunito',
fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: GridView.builder(
            shrinkWrap: true,  // Makes sure it occupies only as much space as required
            physics: NeverScrollableScrollPhysics(),  // Disables internal scrolling of GridView
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,  // Number of items per row
              crossAxisSpacing: 8.0,  // Horizontal space between items
              mainAxisSpacing: 8.0,  // Vertical space between items
              childAspectRatio: 1,  // Aspect ratio of grid items (1:1 makes square items)
            ),
            itemCount: image.length,  // Length of the image list
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),  // Shadow position
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset(
                    image[index],  // Image path from the list
                    fit: BoxFit.cover,  // Ensures the image covers the container
                  ),
                ),
              );
            },
          ),
        ),


            SizedBox(height: 16.0),

  Padding(
  padding: const EdgeInsets.all(14.0),
  child: Container(
    height: 200,
    child: PageView.builder(
      itemCount: 3, // Number of banners
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0), // Add gap between containers
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Stack(
              fit: StackFit.expand,
              children: [
                // Banner image
                Image.asset(
                  'assets/images/service/service.png', // Banner image
                  fit: BoxFit.cover,
                ),
                
                // Apply the fading effect to the side banners
                if (index != 0) // This ensures the first item doesn't have the overlay
                  Positioned.fill(
                    child: Container(
                      color: Colors.black.withOpacity(0.2), // Fading effect for side banners
                    ),
                  ),
              ],
            ),
          ),
        );
      },
      onPageChanged: (int index) {
        // You can add logic here if you want to perform actions on page change
      },
    ),
  ),
),




            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Near by Shops',
                      style: TextStyle(
                     fontFamily: 'Nunito',
                    fontSize: 20, fontWeight: FontWeight.bold),
                    ),

                    InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RestaurantSearchUI()),
              );
            },
            child: Text("See All", style: TextStyle(
              
              
              color: Theme.of(context).primaryColor,),
                ),
          ),
                  ],
                ),
              ),
            ),
            // Restaurant List Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14.0),
              child: Column(
                children: filteredRestaurantNames.map((restaurant) {
                  return buildRestaurantCard(
                    context,
                    restaurant,
                    '4.0',
                    '201 Ratings',
                    'Nandini Layout, Bangalore',
                    'Open until 11:00 PM',
                    ['Fresh food', 'Quick bites'],
                    'assets/images/service/chinese1.jpeg', // Replace with your image URL
                  );
                }).toList(),
              ),
            ),
          ],]
        ),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   items: [
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.home),
      //       label: 'Home',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.search),
      //       label: 'Search',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.account_circle),
      //       label: 'Profile',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.shopping_cart),
      //       label: 'Cart',
      //     ),
      //   ],
      // ),

     
    );
  }

  Widget buildImageWithText(String imagePath, String label) {
    return Container(
      width: 150, // Width of the image container
      child: Stack(
        children: [
          // Image as the background
          ClipRRect(
            borderRadius:
                BorderRadius.circular(10.0), // Rounded corners for image
            child: Image.asset(
              imagePath,
              width: 150,
              height: 200,
              fit: BoxFit.cover, // Cover the container area
            ),
          ),
          // Text with blur effect at the bottom
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(
                    10.0), // Same rounded corners for text container
                bottomRight: Radius.circular(10.0),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(
                    sigmaX: 10.0, sigmaY: 10.0), // Apply blur effect
                child: Container(
                  height: 40,
                  color: Colors.black
                      .withOpacity(0.3), // Semi-transparent background for text
                  padding: EdgeInsets.symmetric(vertical: 5.0),
                  child: Text(
                    label,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      
 fontFamily: 'Nunito',

                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget buildImage(String imageUrl, String text) {
  return Stack(
    alignment: Alignment.center, // Align text at the center of the image
    children: [
      // Image
      Container(
        height: 150,
        width: 200,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(imageUrl),
            fit: BoxFit.cover, // Cover the container with the image
          ),
        ),
      ),
      // Centered Text
      Text(
        text,
        style: TextStyle(
          
 fontFamily: 'Nunito',

          fontSize: 16.0,
          fontWeight: FontWeight.bold,
          color: Colors.white, // Text color for visibility
          shadows: [
            Shadow(
              blurRadius: 4.0,
              color: Colors.black
                  .withOpacity(0.7), // Shadow for better readability
              offset: Offset(1.0, 1.0),
            ),
          ],
        ),
        textAlign: TextAlign.center,
      ),
    ],
  );
}

Widget buildIconCard(IconData icon, String label, Color color) {
  return Container(
    width: 100, // Set a fixed width for horizontal layout
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          radius: 25, // Adjust radius for better appearance
          backgroundColor: color.withOpacity(0.2),
          child: Icon(icon, size: 20, color: color),
        ),
        SizedBox(height: 8),
        SizedBox(
          width: 80, // Width to ensure text doesn't overflow
          child: Text(
            label,
            textAlign: TextAlign.center,
            maxLines: 2, // Limit to 2 lines
            overflow: TextOverflow.ellipsis, // Add ellipsis if text overflows
            style: TextStyle(
 fontFamily: 'Nunito',
fontSize: 12),
          ),
        ),
      ],
    ),
  );
}

Widget buildRestaurantCard(
  BuildContext context,
  String name,
  String rating,
  String reviews,
  String location,
  String timing,
  List<String> tags,
  String imageUrl,
) {
  return InkWell(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => RestaurantDetailPage(
            name: name,
            location: location,
            rating: rating,
            timing: timing,
            tags: tags,
            imageUrl: imageUrl,
          ),
        ),
      );
    },
    child: Card(
      color: Colors.white,
      elevation: 5.0, // Slightly higher elevation for a better card shadow
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)), // Rounded corners
      child: Stack(
        children: [
          // Row with content (Image, Name, Rating, Location, etc.)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image on the left
              ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: Image.asset(
                  imageUrl,
                  height: 120, // Full height of the card
                  width: 120,  // Fixed width
                  fit: BoxFit.cover,
                ),
              ),
              
              // Content on the right
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Restaurant name
                      Text(
                        name,
                        style: TextStyle(
                          fontFamily: 'Nunito',
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis, // Truncate if the text is too long
                      ),
                      
                      // Rating and reviews
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.green, size: 18.0),
                          SizedBox(width: 4.0),
                          Text(
                            rating,
                            style: TextStyle(
                              fontFamily: 'Nunito',
                              color: Colors.green,
                              fontSize: 14.0,
                            ),
                          ),
                          SizedBox(width: 8.0),
                          Text(
                            reviews,
                            style: TextStyle(fontSize: 12.0, color: Colors.grey),
                          ),
                        ],
                      ),
                      SizedBox(height: 2.0),
          
                      // Location and timing
                      Text(
                        location,
                        style: TextStyle(
                          fontFamily: 'Nunito',
                          fontSize: 12.0,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(height: 2.0),
                      Text(
                        timing,
                        style: TextStyle(
                          fontFamily: 'Nunito',
                          fontSize: 12.0,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          
          // Call button at the bottom-right corner
          Positioned(
            bottom: 10.0, // Distance from the bottom edge
            right: 10.0, // Distance from the right edge
            child: GestureDetector(
              onTap: () {
                // Add phone number or calling functionality here
                print('Call button pressed');
              },
              child: CircleAvatar(
                radius: 20.0, // Size of the circle
                backgroundColor: Theme.of(context).primaryColor,
                child: Icon(
                  Icons.call,
                  color: Colors.white,
                  size: 24.0, // Size of the call icon
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}








