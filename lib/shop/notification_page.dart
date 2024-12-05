import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
      backgroundColor: Theme.of(context).primaryColor,
        leading: InkWell(
          onTap: (){
            Navigator.pop(context);
          },
          
          child: Icon(Icons.arrow_back_ios, color: Colors.white,)),
        title: Text(
          "Notification",
          style: TextStyle(color: Colors.white, fontFamily: 'Nunito',fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          NotificationSection(
            title: "Today",
            notifications: [
              {
                "title": "30% Special Discount!",
                "subtitle": "Special promotion only valid today.",
                "icon": Icons.local_offer,
              },
            ],
          ),
          NotificationSection(
            title: "Yesterday",
            notifications: [
              {
                "title": "Top Up E-Wallet Successful!",
                "subtitle": "Your e-wallet top-up is complete.",
                "icon": Icons.account_balance_wallet,
              },
              {
                "title": "New Services Available!",
                "subtitle": "Track your orders in real-time.",
                "icon": Icons.delivery_dining,
              },
            ],
          ),
          NotificationSection(
            title: "December 22, 2024",
            notifications: [
              {
                "title": "Credit Card Connected!",
                "subtitle": "Your credit card has been linked.",
                "icon": Icons.credit_card,
              },
              {
                "title": "Account Setup Successful!",
                "subtitle": "Your account has been created.",
                "icon": Icons.person_add,
              },
            ],
          ),
        ],
      ),
    );
  }
}

class NotificationSection extends StatelessWidget {
  final String title;
  final List<Map<String, dynamic>> notifications;

  const NotificationSection({
    required this.title,
    required this.notifications,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
             fontFamily: 'Nunito',
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 1, 15, 39),
          ),
        ),
        SizedBox(height: 10),
        ...notifications.map((notification) {
          return Container(
            margin: EdgeInsets.symmetric(vertical: 8),
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 4,
                  offset: Offset(0, 2), // Shadow position
                ),
              ],
            ),
            child: ListTile(
              leading: CircleAvatar(
                radius: 20,
                backgroundColor: Theme.of(context).primaryColor,
                child: Icon(notification["icon"], color: Colors.white),
              ),
              title: Text(
                notification["title"],
                style: TextStyle(
                   fontFamily: 'Nunito',
                  color: Color.fromARGB(255, 1, 15, 39),
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                notification["subtitle"],
                style: TextStyle(
                   fontFamily: 'Nunito',
                  color: Colors.grey,
                ),
              ),
            ),
          );
        }).toList(),
        SizedBox(height: 20),
      ],
    );
  }
}
