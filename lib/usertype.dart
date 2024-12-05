// Suggested code may be subject to a license. Learn more: ~LicenseLog:379606062.
// Suggested code may be subject to a license. Learn more: ~LicenseLog:1451730466.
// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, unused_field, use_build_context_synchronously, prefer_const_literals_to_create_immutables, prefer_const_constructors, prefer_const_constructors_in_immutables, sort_child_properties_last, unused_import, avoid_print, unused_element

import 'package:flutter/services.dart';
import 'package:myapp/homepage.dart';
import 'package:myapp/loginpage.dart';
import 'package:myapp/others/prime.dart';
import 'package:myapp/mainpages/splashscreen.dart';
import 'package:myapp/mainpages/step.dart';
import 'package:flutter/material.dart';

class UserTypeSelection extends StatefulWidget {
  const UserTypeSelection({super.key});

  @override
  _UserTypeSelectionState createState() => _UserTypeSelectionState();
}

class _UserTypeSelectionState extends State<UserTypeSelection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  int _selectedIndex = -1;

  final List<UserTypeItem> _userTypes = [
    UserTypeItem(
      title: 'Customer',
      icon: Icons.person,
      description: 'Browse and purchase products',
      backgroundColor: const Color(0xFF6FA3EF),
      iconColor: Colors.white,
      destination:  AttractiveRegistrationForm(),
      fontFamily: 'poppins',
      iconSize: 24,
    ),
    UserTypeItem(
      title: 'Vendor',
      icon: Icons.storefront,
      description: 'Sell products and manage',
      backgroundColor: const Color.fromRGBO(55, 224, 95, 1),
      iconColor: Colors.white,
      destination:  VendorRegistrationForm(),
      fontFamily: 'poppins',
      iconSize: 24,
    ),
    UserTypeItem(
      title: 'Franchise',
      icon: Icons.business_center,
      description: 'Manage and expand network',
      backgroundColor: const Color.fromARGB(255, 250, 195, 65),
      iconColor: Colors.white,
      destination:  FranchiseeRegistrationForm(),
      fontFamily: 'poppins',
      iconSize: 24,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _navigateToDestination(BuildContext context, int index) {
    setState(() {
      _selectedIndex = index;
    });

    Future.delayed(const Duration(milliseconds: 200), () {
      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              _userTypes[index].destination,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            var begin = const Offset(1.0, 0.0);
            var end = Offset.zero;
            var curve = Curves.easeInOut;
            var tween = Tween(begin: begin, end: end).chain(
              CurveTween(curve: curve),
            );

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
          transitionDuration: const Duration(milliseconds: 500),
        ),
      );
    });
  }

  Widget _buildUserTypeCard(int index) {
    final userType = _userTypes[index];
    final isSelected = _selectedIndex == index;

    return GestureDetector(
      onTap: () => _navigateToDestination(context, index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              userType.backgroundColor,
              userType.backgroundColor.withOpacity(0.7),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: userType.backgroundColor.withOpacity(0.5),
              blurRadius: isSelected ? 30 : 10,
              offset: const Offset(0, 10),
            ),
          ],
          border: isSelected
              ? Border.all(
                  color: Colors.white.withOpacity(0.8),
                  width: 3,
                )
              : Border.all(
                  color: Colors.transparent,
                ),
        ),
        child: Row(
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: isSelected ? 60 : 50,
              width: isSelected ? 60 : 50,
              decoration: BoxDecoration(
                color: userType.iconColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Icon(
                userType.icon,
                color: userType.iconColor,
                size: isSelected ? 32 : 28,
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userType.title,
                    style: TextStyle(
                      fontFamily: 'poppins',
                      fontSize: isSelected ? 20 : 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    userType.description,
                    style: TextStyle(
                      fontFamily: 'poppins',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.white.withOpacity(0.8),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Stack(
        children: [
          // Main Background Design
          Positioned.fill(
            child: Container(
              color: Color(0xFF1A1A2E), // Dark primary background
            ),
          ),

          // First circular container
          Positioned(
            top: -80,
            left: -80,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 97, 145, 217),
                shape: BoxShape.circle,
              ),
            ),
          ),

          // Second circular container
          Positioned(
            bottom: -100,
            right: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 55, 224, 199).withOpacity(0.8),
                shape: BoxShape.circle,
              ),
            ),
          ),

          // Decorative rectangle
          Positioned(
            top: 150,
            left: -50,
            child: Transform.rotate(
              angle: -0.5,
              child: Container(
                width: 150,
                height: 400,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 59, 78, 132),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),

          // Main Content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 140),

                Text(
                  'Choose Your Role',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 18),
                Text(
                  'Select one to proceed further',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                ),
                SizedBox(height: 18),

                Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  physics: const BouncingScrollPhysics(),
                  itemCount: _userTypes.length,
                  itemBuilder: (context, index) {
                    return _buildUserTypeCard(index);
                  },
                ),
              ),
              ],
            ),
          ),
        ],
      ),
            
              
           
    );
  }
}

class UserTypeItem {
  final String title;
  final IconData icon;
  final String description;
  final Color backgroundColor;
  final Color iconColor;
  final Widget destination;
  final String fontFamily;
  final double iconSize;

  UserTypeItem({
    required this.title,
    required this.icon,
    required this.description,
    required this.backgroundColor,
    required this.iconColor,
    required this.destination,
    required this.fontFamily,
    required this.iconSize,
  });
}

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final TextInputType keyboardType;
  final TextInputFormatter? inputFormatter;
  final String Function(String?) validator;
  final int? maxLines;

  const CustomTextField({
    required this.controller,
    required this.label,
    required this.icon,
    this.keyboardType = TextInputType.text,
    this.inputFormatter,
    required this.validator,
    this.maxLines = 1,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: const OutlineInputBorder(),
      ),
      keyboardType: keyboardType,
      inputFormatters: inputFormatter != null ? [inputFormatter!] : [],
      validator: validator,
      maxLines: maxLines,
    );
  }
}

class AttractiveRegistrationForm extends StatefulWidget {
  @override
  _AttractiveRegistrationFormState createState() =>
      _AttractiveRegistrationFormState();
}

class _AttractiveRegistrationFormState extends State<AttractiveRegistrationForm>
    with SingleTickerProviderStateMixin {
  // Tab Controller
  late TabController _tabController;

  // Form Key
  final _formKey = GlobalKey<FormState>();

  // Tab Configuration
  final List<Map<String, dynamic>> _tabs = [
    {
      'icon': Icons.person,
      'label': 'Personal',
      'fields': [
        {
          'controller': TextEditingController(),
          'label': 'Full Name',
          'icon': Icons.person,
          'validator': (value) => value == null || value.isEmpty
              ? 'Please enter your full name'
              : null,
        },
        {
          'controller': TextEditingController(),
          'label': 'Email Address',
          'icon': Icons.email,
          'validator': (value) => value == null || value.isEmpty
              ? 'Please enter email address'
              : null,
        },
        {
          'controller': TextEditingController(),
          'label': 'Phone Number',
          'icon': Icons.phone,
          'validator': (value) => value == null || value.isEmpty
              ? 'Please enter phone number'
              : null,
        },
      ]
    },
    {
      'icon': Icons.contact_mail,
      'label': 'Contact',
      'fields': [
        {
          'controller': TextEditingController(),
          'label': 'Full Address',
          'icon': Icons.location_on,
          'validator': (value) =>
              value == null || value.isEmpty ? 'Please enter address' : null,
        },
        {
          'controller': TextEditingController(),
          'label': 'City',
          'icon': Icons.location_city,
          'validator': (value) =>
              value == null || value.isEmpty ? 'Please enter city' : null,
        },
        {
          'controller': TextEditingController(),
          'label': 'State',
          'icon': Icons.map,
          'validator': (value) =>
              value == null || value.isEmpty ? 'Please enter state' : null,
        },
      ]
    },
    {
      'icon': Icons.details,
      'label': 'Additional',
      'fields': [
        {
          'type': 'dropdown',
          'label': 'Education Level',
          'icon': Icons.school,
          'items': [
            'High School',
            'Graduate',
            'Post Graduate',
            'Professional Degree'
          ],
          'value': null,
          'validator': (value) =>
              value == null ? 'Please select education level' : null,
        },
        {
          'type': 'dropdown',
          'label': 'Income Range',
          'icon': Icons.money,
          'items': [
            'Below 2,00,000',
            '2,00,000 - 5,00,000',
            '5,00,000 - 10,00,000',
            'Above 10,00,000'
          ],
          'value': null,
          'validator': (value) =>
              value == null ? 'Please select income range' : null,
        },
      ]
    }
  ];

  // Dropdown values
  String? _educationLevel;
  String? _incomeRange;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    // Dispose all controllers
    for (var tab in _tabs) {
      for (var field in tab['fields']) {
        if (field['controller'] != null) {
          field['controller'].dispose();
        }
      }
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.90,
            height: MediaQuery.of(context).size.height * 0.90,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 5,
                  blurRadius: 15,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              children: [
                // App Bar
                Container(
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  decoration: BoxDecoration(
                    color: Color(0xFF4A6CF7),
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Registration Form',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.close, color: Colors.white),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      // Vertical Navigation
                      Container(
                        width: 80,
                        color: Colors.grey[100],
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(_tabs.length, (index) {
                            return GestureDetector(
                              onTap: () {
                                _tabController.animateTo(index);
                              },
                              child: AnimatedContainer(
                                duration: Duration(milliseconds: 300),
                                width: 60,
                                height: 60,
                                margin: EdgeInsets.symmetric(vertical: 10),
                                decoration: BoxDecoration(
                                  color: _tabController.index == index
                                      ? Colors.white
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: _tabController.index == index
                                      ? [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.3),
                                            spreadRadius: 1,
                                            blurRadius: 5,
                                          )
                                        ]
                                      : [],
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      _tabs[index]['icon'],
                                      color: _tabController.index == index
                                          ? Color(0xFF4A6CF7)
                                          : Colors.grey,
                                    ),
                                    Text(
                                      _tabs[index]['label'],
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: _tabController.index == index
                                            ? Color(0xFF4A6CF7)
                                            : Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                        ),
                      ),

                      // Form Content
                      Expanded(
                        child: Form(
                          key: _formKey,
                          child: TabBarView(
                            controller: _tabController,
                            children: _tabs.map((tab) {
                              return SingleChildScrollView(
                                padding: EdgeInsets.all(20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${tab['label']} Information',
                                      style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF4A6CF7),
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                    ...tab['fields'].map<Widget>((field) {
                                      if (field['type'] == 'dropdown') {
                                        return Padding(
                                          padding: EdgeInsets.only(bottom: 15),
                                          child:
                                              DropdownButtonFormField<String>(
                                            decoration: InputDecoration(
                                              labelText: field['label'],
                                              prefixIcon: Icon(field['icon'],
                                                  color: Color(0xFF4A6CF7)),
                                              filled: true,
                                              fillColor: Colors.grey[100],
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                borderSide: BorderSide.none,
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                borderSide: BorderSide(
                                                  color: Color(0xFF4A6CF7),
                                                  width: 2,
                                                ),
                                              ),
                                            ),
                                            items: field['items']
                                                .map<DropdownMenuItem<String>>(
                                                    (String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(value),
                                              );
                                            }).toList(),
                                            onChanged: (String? newValue) {
                                              setState(() {
                                                if (field['label'] ==
                                                    'Education Level') {
                                                  _educationLevel = newValue;
                                                } else {
                                                  _incomeRange = newValue;
                                                }
                                              });
                                            },
                                            validator: field['validator'],
                                          ),
                                        );
                                      }
                                      return Padding(
                                        padding: EdgeInsets.only(bottom: 15),
                                        child: TextFormField(
                                          controller: field['controller'],
                                          decoration: InputDecoration(
                                            labelText: field['label'],
                                            prefixIcon: Icon(field['icon'],
                                                color: Color(0xFF4A6CF7)),
                                            filled: true,
                                            fillColor: Colors.grey[100],
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              borderSide: BorderSide.none,
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              borderSide: BorderSide(
                                                color: Color(0xFF4A6CF7),
                                                width: 2,
                                              ),
                                            ),
                                          ),
                                          validator: field['validator'],
                                        ),
                                      );
                                    }).toList(),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Submit Button
                Padding(
                  padding: EdgeInsets.all(20),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Collect form data
                        final formData = {
                          'Name': _tabs[0]['fields'][0]['controller'].text,
                          'Email': _tabs[0]['fields'][1]['controller'].text,
                          'Phone': _tabs[0]['fields'][2]['controller'].text,
                          'Address': _tabs[1]['fields'][0]['controller'].text,
                          'City': _tabs[1]['fields'][1]['controller'].text,
                          'State': _tabs[1]['fields'][2]['controller'].text,
                          'Education': _educationLevel,
                          'Income Range': _incomeRange,
                        };

                        // Handle form submission
                        print(formData);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Registration Submitted')),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF4A6CF7),
                      minimumSize: Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: Text(
                      'Submit Registration',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class VendorRegistrationForm extends StatefulWidget {
  @override
  _VendorRegistrationFormState createState() => _VendorRegistrationFormState();
}

class _VendorRegistrationFormState extends State<VendorRegistrationForm>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _formKey = GlobalKey<FormState>();

  // Tab Configuration
  final List<Map<String, dynamic>> _tabs = [
    {
      'icon': Icons.business,
      'label': 'Business',
      'fields': [
        {
          'controller': TextEditingController(),
          'label': 'Business Name',
          'icon': Icons.business_center,
          'validator': (value) => value == null || value.isEmpty
              ? 'Please enter business name'
              : null,
        },
        {
          'controller': TextEditingController(),
          'label': 'GST Number',
          'icon': Icons.receipt_long,
          'validator': (value) =>
              value == null || value.isEmpty ? 'Please enter GST number' : null,
        },
        {
          'controller': TextEditingController(),
          'label': 'PAN Number',
          'icon': Icons.credit_card,
          'validator': (value) =>
              value == null || value.isEmpty ? 'Please enter PAN number' : null,
        },
      ]
    },
    {
      'icon': Icons.contact_mail,
      'label': 'Contact',
      'fields': [
        {
          'controller': TextEditingController(),
          'label': 'Email Address',
          'icon': Icons.email,
          'validator': (value) =>
              value == null || value.isEmpty ? 'Please enter email' : null,
        },
        {
          'controller': TextEditingController(),
          'label': 'Phone Number',
          'icon': Icons.phone,
          'validator': (value) => value == null || value.isEmpty
              ? 'Please enter phone number'
              : null,
        },
        {
          'controller': TextEditingController(),
          'label': 'Address',
          'icon': Icons.location_on,
          'validator': (value) =>
              value == null || value.isEmpty ? 'Please enter address' : null,
        },
      ]
    },
    {
      'icon': Icons.details,
      'label': 'Details',
      'fields': [
        {
          'controller': TextEditingController(),
          'label': 'City',
          'icon': Icons.location_city,
          'validator': (value) =>
              value == null || value.isEmpty ? 'Please enter city' : null,
        },
        {
          'controller': TextEditingController(),
          'label': 'State',
          'icon': Icons.map,
          'validator': (value) =>
              value == null || value.isEmpty ? 'Please enter state' : null,
        },
        {
          'controller': TextEditingController(),
          'label': 'Pin Code',
          'icon': Icons.pin_drop,
          'validator': (value) =>
              value == null || value.isEmpty ? 'Please enter pin code' : null,
        },
      ]
    }
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    // Dispose all controllers
    for (var tab in _tabs) {
      for (var field in tab['fields']) {
        field['controller'].dispose();
      }
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.90,
            height: MediaQuery.of(context).size.height * 0.90,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 5,
                  blurRadius: 15,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              children: [
                // App Bar
                Container(
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 58, 182, 87),
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Vendor Registration',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.close, color: Colors.white),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      // Vertical Navigation
                      Container(
                        width: 80,
                        color: Colors.grey[100],
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(_tabs.length, (index) {
                            return GestureDetector(
                              onTap: () {
                                _tabController.animateTo(index);
                              },
                              child: AnimatedContainer(
                                duration: Duration(milliseconds: 300),
                                width: 60,
                                height: 60,
                                margin: EdgeInsets.symmetric(vertical: 10),
                                decoration: BoxDecoration(
                                  color: _tabController.index == index
                                      ? Colors.white
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: _tabController.index == index
                                      ? [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.3),
                                            spreadRadius: 1,
                                            blurRadius: 5,
                                          )
                                        ]
                                      : [],
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      _tabs[index]['icon'],
                                      color: _tabController.index == index
                                          ? Color.fromARGB(255, 58, 182, 87)
                                          : Colors.grey,
                                    ),
                                    Text(
                                      _tabs[index]['label'],
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: _tabController.index == index
                                            ? Color.fromARGB(255, 58, 182, 87)
                                            : Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                        ),
                      ),

                      // Form Content
                      Expanded(
                        child: Form(
                          key: _formKey,
                          child: TabBarView(
                            controller: _tabController,
                            children: _tabs.map((tab) {
                              return SingleChildScrollView(
                                padding: EdgeInsets.all(20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${tab['label']} Information',
                                      style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(255, 58, 182, 87),
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                    ...tab['fields'].map<Widget>((field) {
                                      return Padding(
                                        padding: EdgeInsets.only(bottom: 15),
                                        child: TextFormField(
                                          controller: field['controller'],
                                          decoration: InputDecoration(
                                            labelText: field['label'],
                                            prefixIcon: Icon(field['icon'],
                                                color: Color.fromARGB(
                                                    255, 58, 182, 87)),
                                            filled: true,
                                            fillColor: Colors.grey[100],
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              borderSide: BorderSide.none,
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              borderSide: BorderSide(
                                                color: Color.fromARGB(
                                                    255, 58, 182, 87),
                                                width: 2,
                                              ),
                                            ),
                                          ),
                                          validator: field['validator'],
                                        ),
                                      );
                                    }).toList(),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Submit Button
                Padding(
                  padding: EdgeInsets.all(20),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Handle form submission
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Registration Submitted')),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 58, 182, 87),
                      minimumSize: Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: Text(
                      'Submit Registration',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FranchiseeRegistrationForm extends StatefulWidget {
  @override
  _FranchiseeRegistrationFormState createState() =>
      _FranchiseeRegistrationFormState();
}

class _FranchiseeRegistrationFormState extends State<FranchiseeRegistrationForm>
    with SingleTickerProviderStateMixin {
  // Tab Controller
  late TabController _tabController;

  // Form Key
  final _formKey = GlobalKey<FormState>();

  // Tab Configuration
  final List<Map<String, dynamic>> _tabs = [
    {
      'icon': Icons.person,
      'label': 'Personal',
      'fields': [
        {
          'controller': TextEditingController(),
          'label': 'Franchisee Name',
          'icon': Icons.person,
          'validator': (value) => value == null || value.isEmpty
              ? 'Please enter your franchisee name'
              : null,
        },
        {
          'controller': TextEditingController(),
          'label': 'Email Address',
          'icon': Icons.email,
          'validator': (value) => value == null || value.isEmpty
              ? 'Please enter email address'
              : null,
        },
        {
          'controller': TextEditingController(),
          'label': 'Phone Number',
          'icon': Icons.phone,
          'validator': (value) => value == null || value.isEmpty
              ? 'Please enter phone number'
              : null,
        },
      ]
    },
    {
      'icon': Icons.business,
      'label': 'Business',
      'fields': [
        {
          'controller': TextEditingController(),
          'label': 'Business Name',
          'icon': Icons.business,
          'validator': (value) => value == null || value.isEmpty
              ? 'Please enter your business name'
              : null,
        },
        {
          'controller': TextEditingController(),
          'label': 'Business Address',
          'icon': Icons.location_on,
          'validator': (value) => value == null || value.isEmpty
              ? 'Please enter your business address'
              : null,
        },
      ]
    },
    {
      'icon': Icons.payment,
      'label': 'Tax Details',
      'fields': [
        {
          'controller': TextEditingController(),
          'label': 'Tax ID',
          'icon': Icons.payment,
          'validator': (value) => value == null || value.isEmpty
              ? 'Please enter your tax ID'
              : null,
        },
      ]
    }
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    // Dispose all controllers
    for (var tab in _tabs) {
      for (var field in tab['fields']) {
        if (field['controller'] != null) {
          field['controller'].dispose();
        }
      }
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.90,
            height: MediaQuery.of(context).size.height * 0.90,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 5,
                  blurRadius: 15,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              children: [
                // App Bar
                Container(
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 255, 181, 8),
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Franchisee Registration',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.close, color: Colors.white),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      // Vertical Navigation
                      Container(
                        width: 80,
                        color: Colors.grey[100],
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(_tabs.length, (index) {
                            return GestureDetector(
                              onTap: () {
                                _tabController.animateTo(index);
                              },
                              child: AnimatedContainer(
                                duration: Duration(milliseconds: 300),
                                width: 60,
                                height: 60,
                                margin: EdgeInsets.symmetric(vertical: 10),
                                decoration: BoxDecoration(
                                  color: _tabController.index == index
                                      ? Colors.white
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: _tabController.index == index
                                      ? [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.3),
                                            spreadRadius: 1,
                                            blurRadius: 5,
                                          )
                                        ]
                                      : [],
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      _tabs[index]['icon'],
                                      color: _tabController.index == index
                                         ? const Color.fromARGB(255, 255, 181, 8)
                                          : Colors.grey,
                                    ),
                                    Text(
                                      _tabs[index]['label'],
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: _tabController.index == index
                                            ? const Color.fromARGB(255, 255, 181, 8)
                                            : Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                        ),
                      ),

                      // Form Content
                      Expanded(
                        child: Form(
                          key: _formKey,
                          child: TabBarView(
                            controller: _tabController,
                            children: _tabs.map((tab) {
                              return SingleChildScrollView(
                                padding: EdgeInsets.all(20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${tab['label']} Information',
                                      style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                        color: const Color.fromARGB(255, 255, 181, 8),
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                    ...tab['fields'].map<Widget>((field) {
                                      return Padding(
                                        padding: EdgeInsets.only(bottom: 15),
                                        child: TextFormField(
                                          controller: field['controller'],
                                          decoration: InputDecoration(
                                            labelText: field['label'],
                                            prefixIcon: Icon(field['icon'],
                                                color: const Color.fromARGB(255, 255, 181, 8),),
                                            filled: true,
                                            fillColor: Colors.grey[100],
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              borderSide: BorderSide.none,
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              borderSide: BorderSide(
                                                color: const Color.fromARGB(255, 255, 181, 8),
                                                width: 2,
                                              ),
                                            ),
                                          ),
                                          validator: field['validator'],
                                        ),
                                      );
                                    }).toList(),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Submit Button
                Padding(
                  padding: EdgeInsets.all(20),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Collect form data
                        final formData = {
                          'Franchisee Name':
                              _tabs[0]['fields'][0]['controller'].text,
                          'Email': _tabs[0]['fields'][1]['controller'].text,
                          'Phone': _tabs[0]['fields'][2]['controller'].text,
                          'Business Name':
                              _tabs[1]['fields'][0]['controller'].text,
                          'Business Address':
                              _tabs[1]['fields'][1]['controller'].text,
                          'Tax ID': _tabs[2]['fields'][0]['controller'].text,
                        };

                        // Handle form submission
                        print(formData);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Registration Submitted')),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 255, 181, 8),
                      minimumSize: Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: Text(
                      'Submit Registration',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
