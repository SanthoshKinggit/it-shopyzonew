import 'package:flutter/material.dart';

class TrackOrderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Colors.white,
      appBar: AppBar(

        title: Text('Track Order', style: TextStyle( fontFamily: 'Nunito',color: Colors.white)),
      backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      blurRadius: 6,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                   Container(
                    width: 80,height: 80,
                    color: Theme.of(context).primaryColor,
                     child: Image.asset("assets/images/service/shoe.png"),
                   ),
                    SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Suga Leather Shoes',
                          style: TextStyle( fontFamily: 'Nunito',fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Color | Size 40 | Qty = 1',
                          style: TextStyle( fontFamily: 'Nunito',color: Colors.grey),
                        ),
                        SizedBox(height: 8),
                        Text(
                          '\$375.00',
                          style: TextStyle( fontFamily: 'Nunito',fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildStatusIcon(Icons.storefront, "Order Received", true),
                  _buildStatusIcon(Icons.local_shipping, "In Transit", true),
                  _buildStatusIcon(Icons.inventory, "Out for Delivery", false),
                  _buildStatusIcon(Icons.check_circle, "Delivered", false),
                ],
              ),
              SizedBox(height: 16),
              Center(
                child: Text(
                  'Packet In Delivery',
                  style: TextStyle( fontFamily: 'Nunito',fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 24),
              Container(

                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      blurRadius: 6,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left:18.0,top: 18.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Order Status Details',
                        style: TextStyle( fontFamily: 'Nunito',fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                  
                       SizedBox(height: 16),
                                _buildTimelineTile(
                  context,
                  title: 'Order In Transit - Dec 17',
                  address: '32 Manchester Ave. Ringgold, GA 30736',
                  time: '15:20 PM',
                  isCompleted: true,
                                ),
                                _buildTimelineTile(
                  context,
                  title: 'Order at Customs Port - Dec 16',
                  address: '4 Evergreen Street Lake Zurich, IL 60047',
                  time: '14:40 PM',
                  isCompleted: true,
                                ),
                                _buildTimelineTile(
                  context,
                  title: 'Orders are Shipped - Dec 15',
                  address: '977 Hillcrest Street Wheeling, WV 26003',
                  time: '13:35 PM',
                  isCompleted: true,
                                ),
                                _buildTimelineTile(
                  context,
                  title: 'Order is in Packing - Dec 15',
                  address: '891 Glen Ridge St. Gainesville, FL 20155',
                  time: '11:00 AM',
                  isCompleted: true,
                                ),
                                _buildTimelineTile(
                  context,
                  title: 'Verified Payments - Dec 15',
                  address: '55 Summershore Dr. Apopka, FL 32703',
                  time: '10:30 AM',
                  isCompleted: true,
                                ),
                    ],
                  ),
                ),
              ),
             
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusIcon(IconData icon, String label, bool isCompleted) {
    return Column(
      children: [
        Icon(
          icon,
          color: isCompleted ? Color(0xFF724B9E): Colors.grey,
        ),
        Container(
          height: 5,
          width: 50,
          color: isCompleted ? Color(0xFF724B9E): Colors.grey,
        ),
        SizedBox(height: 8),
        Text(
          label,
          style: TextStyle( fontFamily: 'Nunito',
            color: isCompleted ? Colors.purple : Colors.grey,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildTimelineTile(
    BuildContext context, {
    required String title,
    required String address,
    required String time,
    required bool isCompleted,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(
            Icons.circle,
            color: isCompleted ? Colors.green : Colors.grey,
            size: 12,
          ),
          SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle( fontFamily: 'Nunito',fontWeight: FontWeight.bold),
                ),
                Text(address, style: TextStyle( fontFamily: 'Nunito',color: Colors.grey)),
                Text(time, style: TextStyle( fontFamily: 'Nunito',color: Colors.grey)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
