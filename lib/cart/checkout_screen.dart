// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

import 'choose_shipscreen.dart';
import 'shipping_address.dart';


class CheckoutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
           backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
               backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
        leading: InkWell(onTap :(){
          Navigator.pop(context);
        },child: Icon(Icons.arrow_back_ios, color: Colors.white)),
        title: Text("Checkout", style: TextStyle(color: Colors.white,  fontFamily: 'Nunito',)),
        
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Shipping Address", style: TextStyle( fontFamily: 'Nunito',fontSize: 18, fontWeight: FontWeight.bold,color: Color.fromARGB(255, 1, 15, 39))),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  CircleAvatar(
                    backgroundColor:  
Theme.of(context).primaryColor,
                    
                    child: Icon(Icons.location_on, color: const Color.fromARGB(255, 235, 231, 231),)),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Home", style: TextStyle( fontFamily: 'Nunito',fontWeight: FontWeight.bold,color: Color.fromARGB(255, 1, 15, 39))),
                      SizedBox(height: 5),
                      Text("5848 Surbrook Park PC 5479", style: TextStyle( fontFamily: 'Nunito',color: Colors.grey)),
                    ],
                  ),
                  InkWell(onTap :(){
  Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ShippingAddressScreen()),
              );


                  }, child: Icon(Icons.edit, color: Colors.black)),
                ],
              ),
            ),
            SizedBox(height: 20),
            Text("Order List", style: TextStyle( fontFamily: 'Nunito',fontSize: 18, fontWeight: FontWeight.bold,color: Color.fromARGB(255, 1, 15, 39))),
            SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: [
                  _buildOrderItem("Werolla Cardigans", "\$385.00"),
                  _buildOrderItem("Suga Leather Shoes", "\$275.00"),
                  _buildOrderItem("Vinia Headphone", "\$360.00"),
                ],
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {

      Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ChooseShippingScreen()),
              );

              },
              style: ElevatedButton.styleFrom(
                backgroundColor: 
Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                minimumSize: Size(double.infinity, 50),
              ),
              child: Text("Continue to Payment", style: TextStyle( fontFamily: 'Nunito',color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderItem(String title, String price) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all( 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Image.asset("assets/images/service/shoe1.png"),
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: TextStyle( fontFamily: 'Nunito',fontWeight: FontWeight.bold,color: Color.fromARGB(255, 1, 15, 39))),
                     Text(price, style: TextStyle(  fontFamily: 'Nunito',fontSize: 16,color: Color.fromARGB(255, 1, 15, 39))),
                 
                  ],
                ),
              ],
            ),
        
     
     SizedBox(
      height: 25,
      width: 25,
       child: CircleAvatar(
        
        backgroundColor: Color.fromARGB(255, 219, 219, 219),
        child: Icon(Icons.more_vert,color: Color.fromARGB(255, 1, 15, 39),size: 12,)),
     )
     
          ],
        ),
      ),
    );
  }
}
