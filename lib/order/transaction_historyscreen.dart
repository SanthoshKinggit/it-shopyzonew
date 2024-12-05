import 'package:flutter/material.dart';

import 'e_receiptscreen.dart';

class TransactionHistoryscreen extends StatefulWidget {
  const TransactionHistoryscreen({super.key});

  @override
  State<TransactionHistoryscreen> createState() => _TransactionHistoryscreenState();
}

class _TransactionHistoryscreenState extends State<TransactionHistoryscreen> {final List<Map<String, dynamic>> transactions = [
    {
      "image": "assets/images/service/shoe.png",
      "productName": "Suga Leather Shoes",
      "price": "₹500",
      "date": "24 Nov 2024",
      "type": "Top up"
    },
    {
      "image": "assets/images/service/shoe1.png",
      "productName": "Werolla Cardigans",
      "price": "₹1200",
      "date": "22 Nov 2024",
      "type": "Orders"
    },
    {
      "image": "assets/images/service/microphone.png",
      "productName": "Suga Leather Shoes",
      "price": "₹800",
      "date": "20 Nov 2024",
      "type": "Top up"
    },

     {
      "image": "assets/images/service/shoe.png",
      "productName": "Suga Leather Shoes",
      "price": "₹500",
      "date": "24 Nov 2024",
      "type": "Top up"
    },
    {
      "image": "assets/images/service/shoe1.png",
      "productName": "Werolla Cardigans",
      "price": "₹1200",
      "date": "22 Nov 2024",
      "type": "Orders"
    },
    {
      "image": "assets/images/service/microphone.png",
      "productName": "Suga Leather Shoes",
      "price": "₹800",
      "date": "20 Nov 2024",
      "type": "Top up"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
 backgroundColor: Colors.white,

      appBar: AppBar(
  leading: InkWell(
    onTap: (){
      Navigator.pop(context);
    },
    
    
    child: Icon(Icons.arrow_back_ios, color: Colors.white)),
        title: Text("Transaction History", style: TextStyle( fontFamily: 'Nunito',fontWeight: FontWeight.bold, color: Colors.white),),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
         actions: [
          ImageIcon(AssetImage("assets/images/service/searchicon.png"), size: 20, color:Colors.white),
          SizedBox(width: 10,)]
    
     
      ),
      body: ListView.builder(
        itemCount: transactions.length,
        padding: const EdgeInsets.all(8.0),
        itemBuilder: (context, index) {
          final transaction = transactions[index];
          return InkWell( onTap: (){
             Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => EReceiptScreen(),
                                      ),
                                    );
          },
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Circular Product Image
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage(transaction["image"]),
                    backgroundColor: Colors.grey.shade200,
                  ),
                  SizedBox(width: 12),
                  // Product Info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Product Name and Price
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              transaction["productName"],
                              style: TextStyle(
                                 fontFamily: 'Nunito',
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              transaction["price"],
                              style: TextStyle(
                                fontFamily: 'Nunito',
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 4),
                        // Purchase Date and Transaction Type
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              transaction["date"],
                              style: TextStyle(
                                 fontFamily: 'Nunito',
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                            // Transaction Type with Icon
                           Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              
                Row(
                  children: [
                    // Arrow inside the container
                   
                   // Space between arrow and text
                    // Text outside the container
                    Text(
            transaction["type"],
            style: TextStyle(
               fontFamily: 'Nunito',
              fontSize: 12,
                     
            ),
                    ), SizedBox(width: 6), 
                     Container(
            padding: EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: transaction["type"] == "Top up"
                  ? Colors.blue.shade100
                  : Colors.red.shade100,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              transaction["type"] == "Top up"
                  ? Icons.arrow_upward
                  : Icons.arrow_downward,
              size: 14,
              color: transaction["type"] == "Top up"
                  ? Colors.blue
                  : Colors.red,
            ),
                    ),
                  ],
                ),
              ],
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
      ),
    );
  }
}