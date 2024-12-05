// ignore_for_file: use_super_parameters, prefer_const_constructors, sized_box_for_whitespace, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:myapp/homepage.dart';
import 'package:myapp/others/prime.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

// border: OutlineInputBorder(
// borderRadius: BorderRadius.circular(20),
// borderSide: BorderSide.none,
// ),
class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Text(
          'Edit Profile',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontFamily: fonts,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              _buildTextField('Andrew Ainley', 'Full Name'),
              _buildTextField('Andrew', 'Username'),
              _buildDateField('02/27/1995'),
              _buildTextField('andrew_ainsley@yourdomain.com', 'Email',
                  suffixIcon:
                      Icon(Icons.lock_outline, color: Colors.grey, size: 20)),
              _buildDropdownField('United States', 'Country'),
              _buildPhoneField('+91 627 378 399'),
              _buildTextField('253 New Avenue, New York', 'Address'),
              const SizedBox(height: 24),
              _buildUpdateButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String value, String label, {Widget? suffixIcon}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextField(
        controller: TextEditingController(text: value),
        style: TextStyle(
          fontSize: 16,
          color: Colors.black87,
        ),
        decoration: InputDecoration(
          hintStyle: TextStyle(
            color: Colors.grey[400],
            fontFamily: 'Nunito',
          ),

          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: const Color.fromARGB(255, 255, 255, 255),
          // errorText: validator(controller.text) ? null : _getErrorText(hintText),
        ),
      ),
    );
  }

  Widget _buildDateField(String value) {
    return _buildTextField(
      value,
      'Date of Birth',
      suffixIcon:
          Icon(Icons.calendar_today_outlined, color: Colors.grey, size: 20),
    );
  }

  Widget _buildDropdownField(String value, String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: TextEditingController(text: value),
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
              decoration: InputDecoration(
                hintStyle: TextStyle(
                  color: Colors.grey[400],
                  fontFamily: 'Nunito',
                ),

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: const Color.fromARGB(255, 255, 255, 255),
                // errorText: validator(controller.text) ? null : _getErrorText(hintText),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPhoneField(String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 26,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage('https://via.placeholder.com/40x26'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: TextEditingController(text: value),
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
              decoration: InputDecoration(
                hintStyle: TextStyle(
                  color: Colors.grey[400],
                  fontFamily: 'Nunito',
                ),

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: const Color.fromARGB(255, 255, 255, 255),
                // errorText: validator(controller.text) ? null : _getErrorText(hintText),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUpdateButton() {
    return Container(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => PaymentApp()));
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text('Profile Updated'),
                action: SnackBarAction(
                  label: 'Undo',
                  onPressed: () {
                    // Perform the Undo action
                  },
                ),
                duration: Duration(seconds: 3),
                backgroundColor: primary),
          );
        },
        child: Text(
          'Update',
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}
