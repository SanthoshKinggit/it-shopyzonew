// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors_in_immutables, prefer_const_literals_to_create_immutables, prefer_const_constructors, deprecated_member_use

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  final String selectedLanguage;
  final bool isDarkMode;
  final ValueChanged<bool> onThemeChanged;
  final VoidCallback onLogout;

  CustomDrawer({
    required this.selectedLanguage,
    required this.isDarkMode,
    required this.onThemeChanged,
    required this.onLogout,
  });

  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    String? value,
    required Function() onTap,
    Color? titleColor,
    Widget? trailing,
    bool showArrow = false,
  }) {
    return ListTile(
    leading: ShaderMask(
  shaderCallback: (bounds) => LinearGradient(
    colors: [Color(0xFF743089), Color(0xFFA865B5)], // Gradient colors
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    stops: [0.0, 1.0], // Adjust stops to control where the colors change
  ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
  child: Icon(
    icon,
    color: Colors.white, // Set a lighter color to contrast the gradient
    size: 24,
  ),
),


      title: Text(
        title,
        style: TextStyle(
          color: titleColor ??   Color(0xFFCEA2FD),
          fontSize: 16,
          fontFamily: 'Nunito',
        ),
      ),
      trailing: trailing ??
          (showArrow
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (value != null)
                      ShaderMask(
  shaderCallback: (bounds) => LinearGradient(
    colors: [Color(0xFF743089), Color(0xFFA865B5)], // Gradient colors
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    stops: [0.0, 1.0], // Adjust stops for color transition
  ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
  child: Text(
    value,
    style: TextStyle(
      fontFamily: 'Nunito',
      fontSize: 14,
      fontWeight: FontWeight.normal, // Adjust as needed
      color: Colors.white, // Use white or any other color as base for visibility
    ),
  ),
),

                    if (value != null) const SizedBox(width: 8),
                     ShaderMask(
    shaderCallback: (bounds) => LinearGradient(
      colors: [Color(0xFF743089), Color(0xFFA865B5)], // Gradient colors
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      stops: [0.0, 1.0], // Adjust stops to control where the colors change
    ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
    child: Icon(
      Icons.arrow_forward_ios,
      color: Colors.white, // Use a lighter color as a base for the gradient
      size: 16,
    ),
  ),


                  ],
                )
              : null),
      onTap: () {
        // Close drawer before navigation
        // Navigator.pop(context);
        onTap();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
    
      child: Container(
decoration: BoxDecoration(
      gradient: LinearGradient(
  colors: [
    Colors.black, // Left side color
    const Color.fromARGB(255, 77, 76, 76), // Center color (dark grey)
    Colors.black, // Right side color
  ],
    begin: Alignment.centerLeft, // Start from the left
  end: Alignment.centerRight,
  stops: [0.3, 0.5, 1.4], // Adjust stops to create the center effect
),
    ),

        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            // Custom Drawer Header
            DrawerHeader(
              decoration: BoxDecoration(
    gradient: LinearGradient(
    colors: [
             Colors.black, // Left side color
    const Color.fromARGB(255, 77, 76, 76), // Center color (dark grey)
    Colors.black, // Right side color
  ],
    begin: Alignment.centerLeft, // Start from the left
  end: Alignment.centerRight,
  stops: [0.3, 0.5, 1.4], // Adjust stops to create the center effect

    ),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.1),
        blurRadius: 10,
        spreadRadius: 1,
      ),
    ],
  ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                     Container(
          width: 75,
          height: 75,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
         colors: [
          Color(0xFFFFD700), // Bright gold
          Color(0xFFFFE135), // Light gold
          Color(0xFFC5A000), // Dark gold
          Color(0xFFFFD700), // Bright gold again to mimic shine
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        stops: [0.0, 0.3, 0.7, 1.0], // 
            ),
            boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 10,
          spreadRadius: 1,
        ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(3.0), // Space for the gradient border
            child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.black, // Black background inside the circle
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: Image.asset(
            'assets/images/service/finallogo.png',
            height: 50,
            fit: BoxFit.cover,
          ),
        ),
            ),
          ),
        ),
        
                      // Positioned(
                      //   bottom: 0,
                      //   right: 0,
                      //   child: InkWell(
                      //     onTap: () {
                      //       // Navigate to Edit Profile Screen
                      //     },
                      //     child: Container(
                      //       padding: const EdgeInsets.all(4),
                      //       decoration: BoxDecoration(
                      //         shape: BoxShape.circle,
                      //         border: Border.all(
                      //           color: Colors.white,
                      //           width: 2,
                      //         ),
                      //       ),
                      //       child: const Icon(
                      //         Icons.edit,
                      //         size: 14,
                      //         color: Colors.white,
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                  // const SizedBox(height: 10),
             ShaderMask(
            shaderCallback: (bounds) {
              return LinearGradient(
                colors: [  Color.fromARGB(255, 226, 2, 181),Color.fromARGB(255, 191, 86, 240),],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height));
            },
            child: Text(
              'Andrew Ainsley',
              style: TextStyle(
                fontSize: 20, // Adjust the font size as needed
                fontWeight: FontWeight.w600,
                fontFamily: 'Nunito',
                color: Colors.white, // The color here will not be visible; the gradient will take over
              ),
            ),
       

                  ),
                  Text(
                    '**** 8957 4774',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFFCEA2FD),
                      fontFamily: 'Nunito',
                    ),
                  ),
                ],
              ),
            ),
        
            // Drawer Menu Items
            _buildDrawerItem(
              icon: Icons.person_outline,
              title: 'Edit Profile',
              onTap: () {
                // Navigate to Edit Profile Screen
              },
              showArrow: true,
            ),
            _buildDrawerItem(
              icon: Icons.card_membership,
              title: 'Membership',
              onTap: () {
                // Navigate to Membership Screen
              },
              showArrow: true,
            ),
            _buildDrawerItem(
              icon: Icons.language_outlined,
              title: 'Language',
              value: selectedLanguage,
              onTap: () {
                // Show Language Bottom Sheet
              },
              showArrow: true,
            ),
            _buildDrawerItem(
              icon: Icons.security_outlined,
              title: 'Security',
              onTap: () {},
              showArrow: true,
            ),
        _buildDrawerItem(
  icon: CupertinoIcons.moon,
  title: 'Dark Theme',
  trailing: Padding(
    padding: EdgeInsets.all(2), // Adjust padding for the outline thickness
    child: Transform.scale(
      scale: 0.7, // Adjust scale to reduce the size of the switch
      child: Switch(
        value: isDarkMode,
        onChanged: onThemeChanged,
        activeColor: Color(0xFF743089),
         // Color of the switch thumb when on
        inactiveThumbColor: Color(0xFFA865B5),
     
     trackColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.selected)) {
              return Colors.black; // Track color when switch is active
            }
            return Color.fromARGB(255, 223, 202, 245); // Track color when switch is inactive
          },
        ),
        trackOutlineColor: MaterialStateProperty.all(Color(0xFF743089)), // Outline color for the track
        trackOutlineWidth: MaterialStateProperty.all(2.0), // Thickness of the outline
        focusColor: Color.fromARGB(255, 226, 2, 181), // Color when focused
        hoverColor: Color.fromARGB(255, 226, 2, 181), // Color when hovered
        thumbColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.selected)) {
              return Color(0xFF743089); // Active thumb color
            }
            return Color(0xFFA865B5); // Inactive thumb color
          },
        ),
      ),
    ),
  ),
  onTap: () {
    // Add your tap logic here if needed
  },
),


         _buildDrawerItem(
              icon: Icons.privacy_tip_outlined,
              title: 'Privacy Policy',
              onTap: () {},
              showArrow: true,
            ),
            _buildDrawerItem(
              icon: Icons.help_outline,
              title: 'Help & Support',
              onTap: () {},
              showArrow: true,
            ),
            _buildDrawerItem(
              icon: Icons.contact_support_outlined,
              title: 'Contact Us',
              onTap: () {},
              showArrow: true,
            ),
            _buildDrawerItem(
              icon: Icons.logout,
              title: 'Logout',
              titleColor: Colors.red,
              onTap: onLogout,
            ),
          ],
        ),
      ),
    );
  }
}
