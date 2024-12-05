import 'package:flutter/material.dart';

import 'track_orderscreen.dart';
import 'transaction_historyscreen.dart'; // Import the track order screen

class MyorderScreen extends StatefulWidget {
  const MyorderScreen({super.key});

  @override
  State<MyorderScreen> createState() => _MyorderScreenState();
}

class _MyorderScreenState extends State<MyorderScreen> {
  int _selectedTab = 0;

  // Modified method to accept order data
void _showReviewBottomSheet(BuildContext context, Map<String, dynamic> order) {
  TextEditingController _reviewController = TextEditingController();
  double _rating = 0.0; // Track rating state

  showModalBottomSheet(
    context: context,
    isScrollControlled: true, // To allow custom height
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min, // Minimize the space
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Align(
              alignment: Alignment.center,
              
              child: Text('Leave a Review', style: TextStyle( fontFamily: 'Nunito',fontSize: 18, fontWeight: FontWeight.bold))),
            SizedBox(height: 10),

         Card(
                color: Colors.white,
                // margin: EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          image: DecorationImage(
                            image: AssetImage(order['image']!.toString()),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(order['title']!.toString(),
                                style: TextStyle( fontFamily: 'Nunito',fontWeight: FontWeight.bold, fontSize: 16)),
                            Row(
                              children: [
                                Text('Color: ${order['color']}', style: TextStyle( fontFamily: 'Nunito',color: Colors.grey, fontSize: 10)),
                                VerticalDivider(width: 10, color: Colors.grey),
                                Text('Size: ${order['size']}', style: TextStyle( fontFamily: 'Nunito',color: Colors.grey, fontSize: 10)),
                                VerticalDivider(width: 10, color: Colors.grey),
                                Text('Qty: ${order['quantity']}', style: TextStyle( fontFamily: 'Nunito',color: Colors.grey, fontSize: 10)),
                              ],
                            ),
                            SizedBox(height: 8),
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                              decoration: BoxDecoration(
                                color: Colors.green.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(order['status']!.toString(), style: TextStyle( fontFamily: 'Nunito',color: Colors.green, fontSize: 14)),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(order['price']!.toString(), style: TextStyle( fontFamily: 'Nunito',fontWeight: FontWeight.bold, fontSize: 16)),
                              
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            SizedBox(height: 20),

            // Star Rating

            Align(
              alignment: Alignment.center,
              child: Text('How is your Order?', style: TextStyle( fontFamily: 'Nunito',fontSize: 15))),
            Align(
              alignment: Alignment.center,
              
              child: Text('Please give your rating & also your review', style: TextStyle( fontFamily: 'Nunito',fontSize: 12, color: Colors.grey))),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.start,
              children: List.generate(5, (index) {
                return IconButton(
                  icon: Icon(
                    index < _rating ? Icons.star : Icons.star_border,
                    color: Colors.amber,
                  ),
                  onPressed: () {
                    setState(() {
                      _rating = index + 1.0; // Update the rating
                    });
                  },
                );
              }),
            ),
            SizedBox(height: 10),

            // Review Text Field
          
            TextField(
              controller: _reviewController,
              maxLines: 1,
              decoration: InputDecoration(
                hintText: 'Type your review here...',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
            SizedBox(height: 20),

            // Buttons
           Row(
  mainAxisAlignment: MainAxisAlignment.center, // Center the row content
  children: [
    // Cancel Button
    Expanded(
      child: ElevatedButton(
        onPressed: () {
          Navigator.pop(context); // Close the bottom sheet
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Review cancelled')),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.grey, // Button background color
        ),
        child: Text('Cancel', style: TextStyle( fontFamily: 'Nunito',color: Colors.white)),
      ),
    ),
    SizedBox(width: 10), // Gap between the buttons
    // Submit Button
    Expanded(
      child: ElevatedButton(
         style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
               
              ),
        onPressed: () {
          // Handle submit review action
          Navigator.pop(context); // Close the bottom sheet

          // Display success message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Review submitted successfully!')),
          );

          // Optionally, you can send the review data to an API here
          print('Review submitted: ${_reviewController.text}');
          print('Rating: $_rating');
        },
        child: Text('Submit Review', style: TextStyle( fontFamily: 'Nunito',color: Colors.white)),
      ),
    ),
  ],
),

          ],
        ),
      );
    },
  );
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
          child: Icon(Icons.arrow_back_ios, color: Colors.white)),
        backgroundColor: Theme.of(context).primaryColor,
        title: Text('My Orders', style: TextStyle( fontFamily: 'Nunito',color: Colors.white,fontWeight:FontWeight.bold),),
        actions: [
          ImageIcon(AssetImage("assets/images/service/searchicon.png"), size: 18, color: Colors.white),
          SizedBox(width: 10),
          InkWell(

            onTap: (){
               Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => TransactionHistoryscreen(),
                                      ),
                                    );
            },
            child: CircleAvatar(
              minRadius: 10,
              backgroundColor: Colors.white,
              child: Icon(Icons.more_vert, color: Color.fromARGB(255, 1, 15, 39), size: 11),
            ),
          ), SizedBox(width: 10),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () => setState(() => _selectedTab = 0),
                  child: Column(
                    children: [
                      Text(
                        'Ongoing',
                        style: TextStyle(
                          fontFamily: 'Nunito',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: _selectedTab == 0 ? Theme.of(context).primaryColor : Colors.grey,
                        ),
                      ),
                      if (_selectedTab == 0)
                        Container(
                          height: 2,
                          width: 60,
                          color: Colors.black,
                        ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () => setState(() => _selectedTab = 1),
                  child: Column(
                    children: [
                      Text(
                        'Completed',
                        style: TextStyle(
                          fontFamily: 'Nunito',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: _selectedTab == 1 ? Theme.of(context).primaryColor : Colors.grey,
                        ),
                      ),
                      if (_selectedTab == 1)
                        Container(
                          height: 2,
                          width: 80,
                          color: Colors.black,
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: _selectedTab == 0 ? OngoingOrders(showReviewBottomSheet: _showReviewBottomSheet) : CompletedOrders(showReviewBottomSheet: _showReviewBottomSheet),
          ),
        ],
      ),
    );
  }
}

class OngoingOrders extends StatelessWidget {
  final void Function(BuildContext, Map<String, dynamic>) showReviewBottomSheet;

  OngoingOrders({required this.showReviewBottomSheet});

  @override
  Widget build(BuildContext context) {
    final orders = [
      {
        'title': 'Suga Leather Shoes',
        'price': '\$375.00',
        'status': 'In Delivery',
        'image': 'assets/images/service/shoe.png',
        'color': 'Red',
        'size': '42',
        'quantity': 1,
      },
      {
        'title': 'Werolla Cardigans',
        'price': '\$385.00',
        'status': 'In Delivery',
        'image': 'assets/images/service/shoe1.png',
        'color': 'Blue',
        'size': 'M',
        'quantity': 2,
      },
    ];

    return orders.isEmpty
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.folder_open, size: 60, color: Colors.grey),
                SizedBox(height: 10),
                Text('You don’t have an order yet', style: TextStyle( fontFamily: 'Nunito',fontSize: 18, color: Colors.black)),
                Text('You don’t have ongoing orders at this time', style: TextStyle( fontFamily: 'Nunito',
                fontSize: 14, color: Colors.grey)),
              ],
            ),
          )
        : ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final order = orders[index];
              return Card(
                color: Colors.white,
                margin: EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          image: DecorationImage(
                            image: AssetImage(order['image']!.toString()),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(order['title']!.toString(),
                                style: TextStyle( fontFamily: 'Nunito',fontWeight: FontWeight.bold, fontSize: 16)),
                            Row(
                              children: [
                                Text('Color: ${order['color']}', style: TextStyle( fontFamily: 'Nunito',color: Colors.grey, fontSize: 10)),
                                VerticalDivider(width: 10, color: Colors.grey),
                                Text('Size: ${order['size']}', style: TextStyle( fontFamily: 'Nunito',color: Colors.grey, fontSize: 10)),
                                VerticalDivider(width: 10, color: Colors.grey),
                                Text('Qty: ${order['quantity']}', style: TextStyle( fontFamily: 'Nunito',color: Colors.grey, fontSize: 10)),
                              ],
                            ),
                            SizedBox(height: 8),
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                              decoration: BoxDecoration(
                                color: Colors.orange.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(order['status']!.toString(), style: TextStyle( fontFamily: 'Nunito',color: Colors.orange, fontSize: 14)),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(order['price']!.toString(), style: TextStyle( fontFamily: 'Nunito',fontWeight: FontWeight.bold, fontSize: 16)),
                                ElevatedButton(
                                   style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
              
              ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => TrackOrderScreen(),
                                      ),
                                    );
                                  },
                                  child: Text('Track Order', style: TextStyle( fontFamily: 'Nunito',color: Colors.white)),
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
            },
          );
  }
}

class CompletedOrders extends StatelessWidget {
  final void Function(BuildContext, Map<String, dynamic>) showReviewBottomSheet;

  CompletedOrders({required this.showReviewBottomSheet});

  @override
  Widget build(BuildContext context) {
    final completedOrders = [
      {
        'title': 'Suga Leather Shoes',
        'price': '\$375.00',
        'status': 'Completed',
        'image': 'assets/images/service/shoe.png',
        'color': 'Red',
        'size': '42',
        'quantity': 1,
      },
      {
        'title': 'Werolla Cardigans',
        'price': '\$385.00',
        'status': 'Completed',
        'image': 'assets/images/service/shoe1.png',
        'color': 'Blue',
        'size': 'M',
        'quantity': 2,
      },
    ];

    return completedOrders.isEmpty
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.folder_open, size: 60, color: Colors.grey),
                SizedBox(height: 10),
                Text('No completed orders', style: TextStyle( fontFamily: 'Nunito',fontSize: 18, color: Colors.black)),
              ],
            ),
          )
        : ListView.builder(
            itemCount: completedOrders.length,
            itemBuilder: (context, index) {
              final order = completedOrders[index];
              return Card(
                color: Colors.white,
                margin: EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          image: DecorationImage(
                            image: AssetImage(order['image']!.toString()),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(order['title']!.toString(),
                                style: TextStyle( fontFamily: 'Nunito',fontWeight: FontWeight.bold, fontSize: 16)),
                            Row(
                              children: [
                                Text('Color: ${order['color']}', style: TextStyle( fontFamily: 'Nunito',color: Colors.grey, fontSize: 10)),
                                VerticalDivider(width: 10, color: Colors.grey),
                                Text('Size: ${order['size']}', style: TextStyle( fontFamily: 'Nunito',color: Colors.grey, fontSize: 10)),
                                VerticalDivider(width: 10, color: Colors.grey),
                                Text('Qty: ${order['quantity']}', style: TextStyle( fontFamily: 'Nunito',color: Colors.grey, fontSize: 10)),
                              ],
                            ),
                            SizedBox(height: 8),
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                              decoration: BoxDecoration(
                                color: Colors.green.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(order['status']!.toString(), style: TextStyle( fontFamily: 'Nunito',color: Colors.green, fontSize: 14)),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(order['price']!.toString(), style: TextStyle( fontFamily: 'Nunito',fontWeight: FontWeight.bold, fontSize: 16)),
                                ElevatedButton(
                                   style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                
              ),
                                  onPressed: () {
                                    // Show review bottom sheet on completed orders
                                    showReviewBottomSheet(context, order);
                                  },
                                  child: Text('Leave Review', style: TextStyle( fontFamily: 'Nunito',color: Colors.white)),
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
            },
          );
  }
}
