// ignore_for_file: prefer_const_constructors, camel_case_types

import 'package:flutter/material.dart';

class banking extends StatefulWidget {
  const banking({super.key});

  @override
  State<banking> createState() => _bankingState();
}

class _bankingState extends State<banking> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text(
          'Banking',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildCategorySection('   Bill', [
                ServiceItem(
                  icon: Icons.flash_on,
                  label: 'Electricity',
                  color: Colors.amber,
                  backgroundColor: const Color(0xFFFFF7E6),
                ),
                ServiceItem(
                  icon: Icons.wifi,
                  label: 'Internet',
                  color: Colors.blue,
                  backgroundColor: const Color(0xFFE6F3FF),
                ),
                ServiceItem(
                  icon: Icons.water_drop,
                  label: 'Water',
                  color: Colors.blue,
                  backgroundColor: const Color(0xFFE6F3FF),
                ),
                ServiceItem(
                  icon: Icons.account_balance_wallet,
                  label: 'E-Wallet',
                  color: Colors.purple,
                  backgroundColor: const Color(0xFFF3E6FF),
                ),
              ]),
              _buildCategorySection('  Entertainment', [
                ServiceItem(
                  icon: Icons.sports_esports,
                  label: 'Games',
                  color: Colors.red,
                  backgroundColor: const Color(0xFFFFE6E6),
                ),
                ServiceItem(
                  icon: Icons.tv,
                  label: 'Television',
                  color: Colors.blue,
                  backgroundColor: const Color(0xFFE6F3FF),
                ),
                ServiceItem(
                  icon: Icons.shopping_cart,
                  label: 'Merchant',
                  color: Colors.green,
                  backgroundColor: const Color(0xFFE6FFE6),
                ),
                ServiceItem(
                  icon: Icons.credit_card,
                  label: 'Install.',
                  color: Colors.orange,
                  backgroundColor: const Color(0xFFFFEEE6),
                ),
              ]),
              _buildCategorySection('  Insurance', [
                ServiceItem(
                  icon: Icons.favorite,
                  label: 'Health',
                  color: Colors.green,
                  backgroundColor: const Color(0xFFE6FFE6),
                ),
                ServiceItem(
                  icon: Icons.phone_android,
                  label: 'Mobile',
                  color: Colors.blue,
                  backgroundColor: const Color(0xFFE6F3FF),
                ),
                ServiceItem(
                  icon: Icons.motorcycle,
                  label: 'Motor',
                  color: Colors.purple,
                  backgroundColor: const Color(0xFFF3E6FF),
                ),
                ServiceItem(
                  icon: Icons.directions_car,
                  label: 'Car',
                  color: Colors.blue,
                  backgroundColor: const Color(0xFFE6F3FF),
                ),
              ]),
              _buildCategorySection('  Option', [
                ServiceItem(
                  icon: Icons.security,
                  label: 'Assurance',
                  color: Colors.green,
                  backgroundColor: const Color(0xFFE6FFE6),
                ),
                ServiceItem(
                  icon: Icons.shopping_bag,
                  label: 'Shopping',
                  color: Colors.orange,
                  backgroundColor: const Color(0xFFFFEEE6),
                ),
                ServiceItem(
                  icon: Icons.local_offer,
                  label: 'Deals',
                  color: Colors.red,
                  backgroundColor: const Color(0xFFFFE6E6),
                ),
                ServiceItem(
                  icon: Icons.trending_up,
                  label: 'Invest',
                  color: Colors.teal,
                  backgroundColor: const Color(0xFFE6FFFA),
                ),
              ]),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategorySection(String title, List<ServiceItem> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
        ),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 4,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
          children: items,
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}

class ServiceItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final Color backgroundColor;

  const ServiceItem({
    super.key,
    required this.icon,
    required this.label,
    required this.color,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Icon(
            icon,
            color: color,
            size: 24,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.black87,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class CategoryModel {
  final String title;
  final List<ServiceItem> items;

  CategoryModel({required this.title, required this.items});
}
