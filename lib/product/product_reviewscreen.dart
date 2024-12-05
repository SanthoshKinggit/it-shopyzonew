// ignore_for_file: unused_field, use_key_in_widget_constructors, library_private_types_in_public_api, prefer_const_constructors

import 'package:flutter/material.dart';

class ReviewScreen extends StatefulWidget {
  @override
  _ReviewScreenState createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> with TickerProviderStateMixin {
  // List of reviews with individual like status and count
  List<Review> reviews = [
    Review(userName: "Darlene Robertson", reviewText: "The seller is very fast in sending the packet! I just bought it and it arrived in just 1 day! 🌟🌟", likeCount: 100),
    Review(userName: "John Doe", reviewText: "Great product, fast delivery! Will buy again.", likeCount: 50),
    Review(userName: "Jane Smith", reviewText: "Not satisfied with the quality. Expected better.", likeCount: 30),
    Review(userName: "Alice Johnson", reviewText: "Awesome experience! Highly recommend this seller.", likeCount: 120),
    Review(userName: "Bob Lee", reviewText: "Good product but delivery was delayed.", likeCount: 40),
  ];

  List<Review> filteredReviews = [];
  bool isSearchVisible = false;
  TextEditingController searchController = TextEditingController();

  late AnimationController _scaleController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    filteredReviews = List.from(reviews);
    _scaleController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(CurvedAnimation(
      parent: _scaleController,
      curve: Curves.elasticOut,
    ));
  }

  @override
  void dispose() {
    _scaleController.dispose();
    searchController.dispose();
    super.dispose();
  }

  void _searchReviews() {
    setState(() {
      filteredReviews = reviews.where((review) {
        return review.userName.toLowerCase().contains(searchController.text.toLowerCase());
      }).toList();

      if (filteredReviews.isEmpty) {
        filteredReviews.add(Review(userName: "No results found", reviewText: "", likeCount: 0));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
        title: Text(
          "4.8 (4,974 reviews)",
          style: TextStyle( fontFamily: 'Nunito',color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [

InkWell(
  onTap: (){
 setState(() {
                isSearchVisible = !isSearchVisible;
                if (!isSearchVisible) {
                  searchController.clear();
                  _searchReviews(); // Clear search and reset results when closing search
                }
              });
  },
  
  child: ImageIcon(AssetImage("assets/images/service/searchicon.png"),color: Colors.white,)),

        
          SizedBox(width: 16),
        ],
        leading: InkWell(onTap:(){

Navigator.pop(context);

        },child: Icon(Icons.arrow_back_ios, color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Search Text Field (visible only when isSearchVisible is true)
            if (isSearchVisible)
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: TextField(
  controller: searchController,
  onChanged: (_) => _searchReviews(),
  style: TextStyle(
     fontFamily: 'Nunito',
    color: Colors.black, // Change the text color as per your requirement
  ),
  decoration: InputDecoration(
    labelText: "Search by username",
    prefixIcon: Icon(Icons.search),
    border: OutlineInputBorder(),
  ),
)

              ),
            // Filter Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildFilterButton("⭐ All", isActive: true),
                _buildFilterButton("⭐ 5"),
                _buildFilterButton("⭐ 4"),
                _buildFilterButton("⭐ 3"),
              ],
            ),
            SizedBox(height: 16),
            // Reviews List
            Expanded(
              child: ListView.builder(
                itemCount: filteredReviews.length,
                itemBuilder: (context, index) {
                  return _buildReviewCard(filteredReviews[index], index);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterButton(String text, {bool isActive = false}) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: isActive ? Theme.of(context).primaryColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onPressed: () {},
      child: Text(
        text,
        style: TextStyle( fontFamily: 'Nunito',color: isActive ? Colors.white : Theme.of(context).primaryColor,),
      ),
    );
  }

  Widget _buildReviewCard(Review review, int index) {
    if (review.userName == "No results found") {
      return Center(child: Text("No results found", style: TextStyle( fontFamily: 'Nunito',fontSize: 18, color: const Color.fromARGB(255, 95, 95, 95))));
    }
    return Card(
      color: Theme.of(context).scaffoldBackgroundColor,
      margin: EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Row(
          children: [
           
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                       CircleAvatar(
              radius: 24,
              backgroundImage: AssetImage("assets/images/service/profile.jpg"),
            ),
            SizedBox(width: 10,),
                      Text(
                        review.userName,
                        style: TextStyle( fontFamily: 'Nunito',fontWeight: FontWeight.bold, color: Color.fromARGB(255, 1, 15, 39)),
                      ),
                      Spacer(),
                     Container(
  decoration: BoxDecoration(
    border: Border.all(
      color: Colors.transparent,// Set your desired border color here
      width: 1, // Set the border width
    ),
    borderRadius: BorderRadius.circular(12), // Set the radius for rounded corners
  ),
  child: Padding(
    padding: const EdgeInsets.only(left:8.0,right: 8.0,top: 2,bottom: 2),
    child: Row(
      children: [
        Icon(Icons.star, color: Theme.of(context).primaryColor, size: 16),
        SizedBox(width: 4),
        Text(
          "5",
          style: TextStyle( fontFamily: 'Nunito',fontSize: 14, color: Color.fromARGB(255, 1, 15, 39)),
        ),
      ],
    ),
  ),

),SizedBox(width: 5,)

                    ],
                  ),
                  SizedBox(height: 4),
                  Text(
                    review.reviewText,
                    style: TextStyle( fontFamily: 'Nunito',fontSize: 14, color: Color.fromARGB(255, 1, 15, 39)),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      // Favorite Icon with Like functionality
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            review.isLiked = !review.isLiked;
                            if (review.isLiked) {
                              _scaleController.forward();
                              review.likeCount++;
                            } else {
                              _scaleController.reverse();
                              review.likeCount--;
                            }
                          });
                        },
                        child: Icon(
                          review.isLiked ? Icons.favorite : Icons.favorite_border,
                          color: review.isLiked ? const Color.fromARGB(255, 245, 0, 82) : Colors.black, // Change color based on isLiked
                          size: 24,
                        ),
                      ),
                      SizedBox(width: 8), // Space between icon and like count
                      // Like Count
                      Text(
                        review.likeCount.toString(),
                        style: TextStyle( fontFamily: 'Nunito',
                          fontSize: 14,
                          color: Color.fromARGB(255, 1, 15, 39),
                        ),
                      ),
                    SizedBox(width: 8,),
                      Text(
                        "2 days ago",
                        style: TextStyle( fontFamily: 'Nunito',fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Review {
  final String userName;
  final String reviewText;
  bool isLiked;
  int likeCount;

  Review({
    required this.userName,
    required this.reviewText,
    this.isLiked = false,
    this.likeCount = 0,
  });
}
