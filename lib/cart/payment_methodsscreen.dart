// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';

import 'enter_pinscreen.dart';


class PaymentMethodsScreen extends StatefulWidget {
  @override
  _PaymentMethodsScreenState createState() => _PaymentMethodsScreenState();
}

class _PaymentMethodsScreenState extends State<PaymentMethodsScreen> {
  String _selectedPaymentMethod = "My Wallet";

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
        title: Text(
          "Payment Methods",
          style: TextStyle( fontFamily: 'Nunito',color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildPaymentOption(
              title: "My Wallet",
              subtitle: "Balance: \$39.99",
              icon: Icons.account_balance_wallet,
            
            ),
            _buildPaymentOption(
              title: "PayPal",
              subtitle: "",
              icon: Icons.payment,
             
            ),
            _buildPaymentOption(
              title: "Google Pay",
              subtitle: "",
              icon: Icons.g_mobiledata,
            
              iconColor: Colors.blue,
            ),
            _buildPaymentOption(
              title: "Apple Pay",
              subtitle: "",
              icon: Icons.apple,
             
            ),
            _buildPaymentOption(
              title: "MasterCard - 4679",
              subtitle: "",
              icon: Icons.credit_card,
            
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {

   Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const EnterPinscreen(),
                          ),
                        );

                // Confirm payment action
                print("Selected Payment Method: $_selectedPaymentMethod");
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                minimumSize: Size(double.infinity, 50),
              ),
              child: Text("Confirm Payment", style: TextStyle( fontFamily: 'Nunito',color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentOption({
  required String title,
  required String subtitle,
  required IconData icon,
  Color? iconColor,
}) {
  bool isSelected = _selectedPaymentMethod == title;
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isSelected ? Theme.of(context).primaryColor : Colors.transparent,
        ),
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: iconColor ?? Theme.of(context).primaryColor,
        ),
        title: Text(
          title,
          style: TextStyle(
             fontFamily: 'Nunito',
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 1, 15, 39),
          ),
        ),
        subtitle: subtitle.isNotEmpty ? Text(subtitle) : null,
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
              color: isSelected ? Theme.of(context).primaryColor : Colors.grey,
            ),
            SizedBox(width: 10),
            // Text(
            //   isSelected ? "\$39.99" : "", // Replace with the correct price if needed
            //   style: TextStyle(
            //     fontWeight: FontWeight.bold,
            //     color: Colors.grey.shade800,
            //   ),
            // ),
          ],
        ),
        onTap: () {
          setState(() {
            _selectedPaymentMethod = title;
          });
        },
      ),
    ),
  );
}

}
