// ignore_for_file: unused_field, use_key_in_widget_constructors, library_private_types_in_public_api, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

import 'payment_methodsscreen.dart';


class AddPromoScreen extends StatefulWidget {
  @override
  _AddPromoScreenState createState() => _AddPromoScreenState();
}

class _AddPromoScreenState extends State<AddPromoScreen>
    with SingleTickerProviderStateMixin {
  int _selectedPromo = 0; // Selected promo index
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  final List<Map<String, dynamic>> _promos = [
    {
      "title": "Special 25% Off",
      "subtitle": "Use now: special promo",
      "icon": Icons.local_offer,
    },
    {
      "title": "Discount 30% Off",
      "subtitle": "Grab now: big discount",
      "icon": Icons.discount,
    },
    {
      "title": "Special 20% Off",
      "subtitle": "Limited time offer",
      "icon": Icons.card_giftcard,
    },
    {
      "title": "Discount 40% Off",
      "subtitle": "Don't miss out!",
      "icon": Icons.shopping_cart,
    },
  ];

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    // Delay and add promos to AnimatedList
    Future.delayed(Duration(milliseconds: 200), _loadPromos);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _loadPromos() {
    for (int i = 0; i < _promos.length; i++) {
      Future.delayed(Duration(milliseconds: i * 200), () {
        _listKey.currentState?.insertItem(i);
      });
    }
  }

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
        title: Text("Add Promo", style: TextStyle(
 fontFamily: 'Nunito',color: Colors.white, fontWeight: FontWeight.bold)),
       actions: [
         ImageIcon(AssetImage("assets/images/service/searchicon.png"),color: Colors.white,),
         SizedBox(width: 10,)
       ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Expanded(
              child: AnimatedList(
                key: _listKey,
                initialItemCount: 0,
                itemBuilder: (context, index, animation) {
                  return _buildAnimatedPromoOption(
                      index,
                      _promos[index]["title"]!,
                      _promos[index]["subtitle"]!,
                      _promos[index]["icon"]!,
                      animation);
                },
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PaymentMethodsScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(22)),
                minimumSize: Size(double.infinity, 50),
              ),
              child: Text("Apply", style: TextStyle(
 fontFamily: 'Nunito',color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimatedPromoOption(int index, String title, String subtitle,
      IconData icon, Animation<double> animation) {
    bool isSelected = _selectedPromo == index;

    return FadeTransition(
      opacity: animation,
      child: ScaleTransition(
        scale: animation,
        child: GestureDetector(
          onTap: () {
            setState(() {
              _selectedPromo = index;
              _animationController.reset();
              _animationController.forward();
            });
          },
          child: AnimatedContainer(
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            margin: const EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                  color:  Colors.transparent,
                  width: 2),
              boxShadow: isSelected
                  ? [
                      // BoxShadow(
                      //   color: Colors.grey.shade300,
                      //   blurRadius: 8,
                      //   spreadRadius: 2,
                      //   offset: Offset(0, 4),
                      // )
                    ]
                  : [],
            ),
            child: ListTile(
              leading: AnimatedSwitcher(
                duration: Duration(milliseconds: 300),
                transitionBuilder: (child, anim) => ScaleTransition(
                  scale: anim,
                  child: child,
                ),
                child: CircleAvatar(
                  key: ValueKey(isSelected), // Unique key for animation
                  backgroundColor: Theme.of(context).primaryColor,
                  child: Icon(icon,
                      size: isSelected ? 30 : 18,
                      color:  Colors.white
                        ),
                ),
              ),
              title: Text(
                title,
                style: TextStyle(
                  
 fontFamily: 'Nunito',
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,),
              ),
              subtitle: Text(
                subtitle,
                style: TextStyle(
 fontFamily: 'Nunito',color: Color.fromARGB(255, 196, 198, 201), fontSize: 13),
              ),
              trailing: Icon(
                isSelected
                    ? Icons.radio_button_checked
                    : Icons.radio_button_off,
                color: isSelected ? Theme.of(context).primaryColor : Colors.grey,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
