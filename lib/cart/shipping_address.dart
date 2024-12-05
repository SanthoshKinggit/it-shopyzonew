// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, unnecessary_to_list_in_spreads, avoid_print

import 'package:flutter/material.dart';

class ShippingAddressScreen extends StatefulWidget {
  @override
  _ShippingAddressScreenState createState() => _ShippingAddressScreenState();
}

class _ShippingAddressScreenState extends State<ShippingAddressScreen> {
  int selectedAddressIndex = 0;

  final List<Map<String, String>> addresses = [
    {"title": "Home", "address": "5848 Surbrook Park PC 5479"},
    {"title": "Office", "address": "599 Meadow Valley PC 3037"},
    {"title": "Apartment", "address": "2580 Clyde Gallagher PC 6252"},
    {"title": "Parent's House", "address": "5829 Lake Blvd PC 4247"},
  ];

  // Controllers for the address form
  final TextEditingController titleController = TextEditingController();
  final TextEditingController streetController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();
  final TextEditingController nearPlaceController = TextEditingController();

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
          child: const Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
        title: const Text("Shipping Address", style: TextStyle(fontFamily: 'Nunito', color: Colors.white)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...addresses.asMap().entries.map((entry) {
                int index = entry.key;
                Map<String, String> address = entry.value;
                return _buildAddressOption(index, address["title"]!, address["address"]!);
              }).toList(),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _showAddAddressDialog(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 214, 216, 218),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(22),
                  ),
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: Text("Add new address", style: TextStyle(fontFamily: 'Nunito', color: Theme.of(context).primaryColor)),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  print("Selected Address Index: $selectedAddressIndex");
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(22),
                  ),
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text("Apply", style: TextStyle(fontFamily: 'Nunito', color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAddressOption(int index, String title, String address) {
    bool isSelected = index == selectedAddressIndex;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedAddressIndex = index;
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          decoration: BoxDecoration(
            color: isSelected ? Theme.of(context).primaryColor : Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: isSelected ? Theme.of(context).primaryColor : Colors.transparent,
            ),
            boxShadow: isSelected
                ? [const BoxShadow(color: Colors.black, blurRadius: 4, offset: Offset(0, 2))]
                : [],
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                CircleAvatar(
                    backgroundColor: isSelected ? const Color.fromARGB(255, 212, 204, 204) : Theme.of(context).primaryColor,
                    child: Icon(Icons.location_on, color: isSelected ? Theme.of(context).primaryColor : const Color.fromARGB(255, 212, 204, 204))),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.bold,
                          color: isSelected ? Colors.white : Theme.of(context).primaryColor,
                        ),
                      ),
                      Text(
                        address,
                        style: TextStyle(fontFamily: 'Nunito', color: isSelected ? Colors.white : Colors.grey.shade700),
                      ),
                    ],
                  ),
                ),
                Icon(
                  isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
                  color: isSelected ? const Color.fromARGB(255, 180, 176, 176) : Theme.of(context).primaryColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showAddAddressDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Add New Address"),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(labelText: "Address Title (e.g., Home, Office)"),
                ),
                TextField(
                  controller: streetController,
                  decoration: const InputDecoration(labelText: "Street"),
                ),
                TextField(
                  controller: cityController,
                  decoration: const InputDecoration(labelText: "City"),
                ),
                TextField(
                  controller: stateController,
                  decoration: const InputDecoration(labelText: "State"),
                ),
                TextField(
                  controller: pincodeController,
                  decoration: const InputDecoration(labelText: "Pincode"),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: nearPlaceController,
                  decoration: const InputDecoration(labelText: "Nearby Place"),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                _addNewAddress();
                Navigator.pop(context);
              },
              child: const Text("Submit"),
            ),
          ],
        );
      },
    );
  }

  void _addNewAddress() {
    if (titleController.text.isNotEmpty &&
        streetController.text.isNotEmpty &&
        cityController.text.isNotEmpty &&
        stateController.text.isNotEmpty &&
        pincodeController.text.isNotEmpty &&
        nearPlaceController.text.isNotEmpty) {
      setState(() {
        addresses.add({
          "title": titleController.text,
          "address": "${streetController.text}, ${cityController.text}, ${stateController.text}, ${pincodeController.text}, ${nearPlaceController.text}"
        });
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Address added successfully!")));
      titleController.clear();
      streetController.clear();
      cityController.clear();
      stateController.clear();
      pincodeController.clear();
      nearPlaceController.clear();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please fill all fields.")));
    }
  }
}
