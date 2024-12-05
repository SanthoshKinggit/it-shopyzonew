import 'package:flutter/material.dart';

class EReceiptScreen extends StatefulWidget {
  @override
  _EReceiptScreenState createState() => _EReceiptScreenState();
}

class _EReceiptScreenState extends State<EReceiptScreen> {
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
        title: const Text('E-Receipt', style: TextStyle( fontFamily: 'Nunito',color: Colors.white,fontWeight: FontWeight.bold)),
       
       backgroundColor: Theme.of(context).primaryColor,
        elevation: 1,
        actions: [
          PopupMenuButton<String>(
            icon: Icon(Icons.more_vert, color: Colors.white),
            onSelected: (value) {
              // Handle menu actions
              if (value == 'share') {
                print("Share E-Receipt");
              } else if (value == 'download') {
                print("Download E-Receipt");
              } else if (value == 'print') {
                print("Print E-Receipt");
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'share',
                child: Row(
                  children: [
                    Icon(Icons.share, size: 18),
                    SizedBox(width: 8),
                    Text('Share E-Receipt', style: TextStyle(fontFamily: 'Nunito',),),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'download',
                child: Row(
                  children: [
                    Icon(Icons.download, size: 18),
                    SizedBox(width: 8),
                    Text('Download E-Receipt', style: TextStyle(fontFamily: 'Nunito',),),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'print',
                child: Row(
                  children: [
                    Icon(Icons.print, size: 18),
                    SizedBox(width: 8),
                    Text('Print', style: TextStyle(fontFamily: 'Nunito',),),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
      body: SingleChildScrollView( // Wrap the entire body in SingleChildScrollView
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Barcode
            Center(
              child: Column(
                children: [
                  Container(
                    height: 60,
                    width: double.infinity,
                    child: Image.asset('assets/images/service/barcode.png',), // Replace with your barcode asset
                  ),
                  Text('273628     837279', style: TextStyle(fontSize: 14)),
                ],
              ),
            ),
            SizedBox(height: 20),

            // Product Details
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    CircleAvatar(
                
                      child:Image.asset('assets/images/service/shoe1.png'), 
                    ),
                   
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Suga Leather Shoes',
                                style: TextStyle(fontFamily: 'Nunito',fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              Text('Color: Black', style: TextStyle(fontFamily: 'Nunito',fontSize: 14, color: Colors.grey)),
                             
                            ],
                          ),
                          SizedBox(height: 4),
                          Row(
                            children: [
                              Text('Qty: 1', style: TextStyle(fontFamily: 'Nunito',fontSize: 14, color: Colors.grey)),
                              Spacer(),
                              
                              Text('Size: 40', style: TextStyle(fontFamily: 'Nunito',fontSize: 14, color: Colors.grey)),
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

            // Amount Details
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  _buildRow('Amount', '\$375.00'),
                  Divider(),
                  _buildRow('Promo', '-\$112.50'),
                  Divider(),
                  _buildRow('Total', '\$262.50', isBold: true),
                ],
              ),
            ),
            SizedBox(height: 20),

            // Payment Details
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildRow('Payment Methods', 'My E-Wallet'),
                  SizedBox(height: 12),
                  _buildRow('Date', 'Dec 15, 2024 | 10:00:27 AM'),
                  SizedBox(height: 12),
                  _buildRow('Transaction ID', 'SK7263727399'),
                  SizedBox(height: 12),
                  _buildRow('Status', 'Paid', isStatus: true),
                ],
              ),
            ),
            SizedBox(height: 20),

            // Category Dropdown
            Container(

               decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Category", style: TextStyle(fontFamily: 'Nunito',),),
                    DropdownButton<String>(
                      value: 'Orders',
                      items: ['Orders', 'Topups']
                          .map((category) => DropdownMenuItem(
                                value: category,
                                child: Text(category),
                              ))
                          .toList(),
                      onChanged: (value) {
                        // Handle dropdown selection
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRow(String label, String value, {bool isBold = false, bool isStatus = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(fontFamily: 'Nunito',fontSize: 14, color: Colors.grey.shade600),
        ),

isStatus ? Container(
  decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(8),),
child: Padding(
  padding: const EdgeInsets.only(left: 8.0, right: 8.0,top: 5,bottom: 5.0),
  child: Text(value,  style: TextStyle(fontFamily: 'Nunito',
              fontSize: 14,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              color: Colors.white,
            ),),
),
):

        Text(
          value,
          style: TextStyle(fontFamily: 'Nunito',
            fontSize: 14,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            color:  Colors.black,
          ),
        ),
      ],
    );
  }
}
