// ignore_for_file: unused_import, use_key_in_widget_constructors, library_private_types_in_public_api, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:myapp/cart/payment_methodsscreen.dart';

import 'add_promoscreen.dart';


// Choose Shipping Screen
class ChooseShippingScreen extends StatefulWidget {
  @override
  _ChooseShippingScreenState createState() => _ChooseShippingScreenState();
}

class _ChooseShippingScreenState extends State<ChooseShippingScreen> {
  int _selectedOption = 0; // Selected shipping option index

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
        centerTitle: true,
        title: Text("Choose Shipping", style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildShippingOption(0, "Economy", "Estimated Arrival: Dec 20-23", 10, Icons.local_shipping),
            _buildShippingOption(1, "Regular", "Estimated Arrival: Dec 19-22", 15, Icons.local_taxi),
            _buildShippingOption(2, "Cargo", "Estimated Arrival: Dec 18-21", 20, Icons.airport_shuttle),
            _buildShippingOption(3, "Express", "Estimated Arrival: Dec 17-20", 30, Icons.directions_car),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PaymentMethodsScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
                minimumSize: Size(double.infinity, 50),
              ),
              child: Text("Apply", style: TextStyle( fontFamily: 'Nunito',color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShippingOption(int index, String title, String subtitle, int price, IconData icon) {
    bool isSelected = _selectedOption == index;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedOption = index;
          });
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.transparent),
          ),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Theme.of(context).primaryColor,
              child: Icon(icon, color: Colors.grey.shade300),
            ),
            title: Text(
              title,
              style: TextStyle( fontFamily: 'Nunito',fontWeight: FontWeight.bold, color: Color.fromARGB(255, 1, 15, 39)),
            ),
            subtitle: Text(
              subtitle,
              style: TextStyle( fontFamily: 'Nunito',color: Color.fromARGB(255, 167, 169, 173), fontSize: 12),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "\$$price",
                  style: TextStyle( fontFamily: 'Nunito',fontWeight: FontWeight.bold, color: Color.fromARGB(255, 1, 15, 39), fontSize: 15),
                ),
                SizedBox(width: 8),
                Icon(
                  isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
                  color: isSelected ? Theme.of(context).primaryColor : Colors.grey,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
