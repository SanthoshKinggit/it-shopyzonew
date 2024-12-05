// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';





class HelpCenter extends StatefulWidget {
  const HelpCenter({super.key});

  @override
  State<HelpCenter> createState() => _HelpCenterState();
}

class _HelpCenterState extends State<HelpCenter> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String selectedCategory = ""; // Track selected category

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
          //  Navigator.push(
          //       context,
          //       MaterialPageRoute(builder: (context) =>0HomePage()),
          //     );
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          "Help Center",
          style: TextStyle(color: Colors.white),
        ),
        bottom: TabBar(
          labelStyle: TextStyle(color: Colors.white),
          indicatorColor: Colors.white,
          indicatorSize: TabBarIndicatorSize.tab,
          indicatorWeight: 3.0,
          controller: _tabController,
          tabs: [
            Tab(text: "FAQ"),
            Tab(text: "Contact Us"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildFAQTab(),
          _buildContactUsTab(),
        ],
      ),
    );
  }

  Widget _buildFAQTab() {
    final faqCategories = ["General", "Account", "Service", "Payment"];
    final faqData = {
      "General": [
        {"question": "What is Evira?", "answer": "Lorem Ipsum is simply dummy text of the printing and typesetting industry..."},
        {"question": "How to create an account?", "answer": "Lorem Ipsum is simply dummy text of the printing and typesetting industry..."}
      ],
      "Account": [
        {"question": "How to reset my password?", "answer": "Lorem Ipsum is simply dummy text of the printing and typesetting industry..."},
        {"question": "How do I update my profile?", "answer": "Lorem Ipsum is simply dummy text of the printing and typesetting industry..."}
      ],
      "Service": [
        {"question": "What products do you offer?", "answer": "Lorem Ipsum is simply dummy text of the printing and typesetting industry..."},
        {"question": "How do I track my order?", "answer": "Lorem Ipsum is simply dummy text of the printing and typesetting industry..."}
      ],
      "Payment": [
        {"question": "What payment methods do you accept?", "answer": "Lorem Ipsum is simply dummy text of the printing and typesetting industry..."},
        {"question": "Is the payment process secure?", "answer": "Lorem Ipsum is simply dummy text of the printing and typesetting industry..."}
      ],
    };

    return Column(
      children: [
        // Category Chips
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: faqCategories.map((category) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: ChoiceChip(
                  label: Text(
                    category,
                    style: TextStyle(color: Color.fromARGB(255, 215, 192, 241)),
                  ),
                  selected: selectedCategory == category,
                  selectedColor: Theme.of(context).primaryColor,
                  onSelected: (selected) {
                    setState(() {
                      selectedCategory = selected ? category : "";
                    });
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.all(14),
            itemCount: faqCategories.length,
            itemBuilder: (context, index) {
              final category = faqCategories[index];
              final questions = faqData[category]!;
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Category title
                    Text(
                      category,
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    // Questions and answers
                   ListView.builder(
  shrinkWrap: true,
  physics: NeverScrollableScrollPhysics(),
  itemCount: questions.length,
  itemBuilder: (context, subIndex) {
    final faq = questions[subIndex];
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 4.0,
              spreadRadius: 1.0,
            ),
          ],
        ),
        child: Theme(
          data: Theme.of(context).copyWith(
            dividerColor: Colors.transparent, // Remove horizontal lines
          ),
          child: ExpansionTile(
            title: Text(
              faq["question"]!,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            tilePadding: EdgeInsets.zero, // Adjust padding for cleaner look
            childrenPadding: EdgeInsets.zero, // Remove inner padding
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(faq["answer"]!),
              ),
            ],
          ),
        ),
      ),
    );
  },
),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildContactUsTab() {
    final contactOptions = [
      {"icon": Icons.phone, "title": "Customer Service"},
      {"icon": FontAwesomeIcons.whatsapp, "title": "WhatsApp"},
      {"icon": Icons.web, "title": "Website"},
      {"icon": Icons.facebook, "title": "Facebook"},
      {"icon": FontAwesomeIcons.twitter, "title": "Twitter"},
      {"icon": FontAwesomeIcons.instagram, "title": "Instagram"},
    ];

    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: contactOptions.length,
      itemBuilder: (context, index) {
        final option = contactOptions[index];
        return ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.grey.shade200,
            child: Icon(option["icon"] as IconData?, color: Colors.black),
          ),
          title: Text(option["title"]!.toString()),
          onTap: () {
            // Handle contact action
          },
        );
      },
    );
  }
}
