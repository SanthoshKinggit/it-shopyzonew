// ignore_for_file: unused_field, prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myapp/homepage.dart';

import '../mainpages/qrcode.dart';
import '../mainpages/qrscan.dart';
import '../mainpages/step.dart';
import '../others/banking.dart';
import '../others/prime.dart';

class PaymentHistoryScreen extends StatefulWidget {
  const PaymentHistoryScreen({super.key});

  @override
  State<PaymentHistoryScreen> createState() => _PaymentHistoryScreenState();
}

class _PaymentHistoryScreenState extends State<PaymentHistoryScreen> {
  int selectedTabIndex = 0;
  late PageController _pageController;

  DateTime? _selectedDate;

  void _onItemTapped(int index) {
    switch (index) {
      case 0:
        Navigator.push(context, MaterialPageRoute(builder: (context)=> PaymentApp()));
        setState(() {});
        break;
      case 1:
        setState(() {});
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => QRScannerPage()),
        );
        setState(() {});

        break;
      case 3:
        if (index == 3) {
          print('object');
        } else if (index == 0) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Qrcode()));
        } else if (index == 1) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => const Qrcode()));
        } else if (index == 2) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const QRScannerPage()));
        } else if (index == 3) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const banking()));
        } else {
          print('object');
        }
        setState(() {});
        break;
      case 4:
        if (index == 4) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => PaymentHistoryScreen()));
        } else {
          print('object');
        }

        break;
    }
  }

  final List<String> tabs = ['Transaction','Earnings', 'Purchase', 'Referal'];

  final List<PaymentItem> paymentItems = [
    PaymentItem(
      icon: 'M',
      name: "McDonald's Orders",
      dateTime: 'Dec 24, 2024 | 10:25 PM',
      amount: -25,
      backgroundColor: Colors.red,
      isCompanyIcon: true,
    ),
    PaymentItem(
      icon: 'A',
      name: 'Airbnb Royalty',
      dateTime: 'Dec 24, 2024 | 09:37 AM',
      amount: 225,
      backgroundColor: Colors.orange,
      isCompanyIcon: true,
    ),
    PaymentItem(
      icon: 'N',
      name: 'Netflix Subscription',
      dateTime: 'Dec 24, 2024 | 09:30 AM',
      amount: -15,
      backgroundColor: Colors.redAccent,
      isCompanyIcon: true,
    ),
    PaymentItem(
      icon: 'H',
      name: 'Hannah Burress',
      dateTime: 'Dec 23, 2024 | 08:45 AM',
      amount: 60,
      backgroundColor: Colors.teal,
      isCompanyIcon: true,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: selectedTabIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _openCalendar(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.blue,
        title: const Text(
          'Total Transaction History',
          style: TextStyle(
              color: Color.fromARGB(255, 255, 255, 255),
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Color.fromARGB(255, 255, 255, 255)),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list, color: Color.fromARGB(255, 255, 255, 255)),
            onPressed: () => _openCalendar(context),
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          _buildTabs(),
          const SizedBox(height: 20),
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  selectedTabIndex = index;
                });
              },
              children: [
                _buildTransactionView(),
                _buildEarningsView(),
                _buildPurchaseView(),
                _buildReferalView(),
              ],
            ),
          ),
        ],
      ),

      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
            bottomLeft: Radius.circular(30.0),
            bottomRight: Radius.circular(30.0)),
        child: BottomNavigationBar(
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          selectedItemColor: primary,
          unselectedItemColor: Colors.grey,
          currentIndex: 4,
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed,
          elevation: 10,
          selectedLabelStyle: const TextStyle(
            fontFamily: 'Nunito',
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
          unselectedLabelStyle: const TextStyle(
            fontFamily: 'Nunito',
            fontSize: 11,
          ),
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.account_balance), label: 'Account'),
            BottomNavigationBarItem(icon: Icon(Icons.shop), label: 'Shop'),
            BottomNavigationBarItem(
              icon: Column(
                children: [
                  CircleAvatar(
                      backgroundColor: primary,
                      child: Icon(
                        Icons.qr_code_scanner,
                        color: Colors.white,

                      )),
                ],
              ),
              label: 'Scan',
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.home_repair_service), label: 'Services'),
            BottomNavigationBarItem(
                icon: Icon(Icons.history), label: 'History'),
          ],
        ),
      ),
    );
  }

  Widget _buildTabs() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: tabs.asMap().entries.map((entry) {
          final isSelected = entry.key == selectedTabIndex;
          return GestureDetector(
            onTap: () {
              // Update selected tab index and page
              _pageController.animateToPage(
                entry.key,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? Colors.blue : Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: isSelected
                    ? null
                    : Border.all(color: Colors.grey[300]!, width: 1),
              ),
              child: Text(
                entry.value,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.grey[700],
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildTransactionView() {

    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: paymentItems.length,
      separatorBuilder: (context, index) => const SizedBox(height: 10),
      itemBuilder: (context, index) {
        final item = paymentItems[index];
        return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 5,
              ),
            ],
          ),
          child: Row(
            children: [
              _buildIcon(item),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item.dateTime,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                '${item.amount < 0 ? '-' : ''}₹${item.amount.abs()}',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: item.amount < 0 ? Colors.red : Colors.green,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildIcon(PaymentItem item) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: item.backgroundColor,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          item.icon,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  // Placeholder views for other tabs
  Widget _buildEarningsView() {
    final currencyFormatter = NumberFormat.currency(
        locale: 'en_IN',
        symbol: '₹',
        decimalDigits: 2
    );

    // Sample earnings data
    final List<EarningEntry> earnings = [
      EarningEntry(
          title: 'Friend Invited',
          date: '15 Nov 2023',
          amount: 500.50
      ),
      EarningEntry(
          title: 'Bonus',
          date: '30 Nov 2023',
          amount: 700.00
      ),
      EarningEntry(
          title: 'Commission',
          date: '05 Dec 2023',
          amount: 1200.75
      ),
      EarningEntry(
          title: 'Friend Invited',
          date: '15 Nov 2023',
          amount: 500.50
      ),
      EarningEntry(
          title: 'Bonus',
          date: '30 Nov 2023',
          amount: 700.00
      ),
      EarningEntry(
          title: 'Commission',
          date: '05 Dec 2023',
          amount: 1200.75
      ),
      EarningEntry(
          title: 'Friend Invited',
          date: '15 Nov 2023',
          amount: 500.50
      ),
      EarningEntry(
          title: 'Bonus',
          date: '30 Nov 2023',
          amount: 700.00
      ),
      EarningEntry(
          title: 'Commission',
          date: '05 Dec 2023',
          amount: 1200.75
      ),
    ];
    return Scaffold(
backgroundColor: Colors.lightGreen,
      body: SingleChildScrollView(
        child:Container(
          width: double.infinity,
          margin: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.lightGreen,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: earnings.length,
                itemBuilder: (context, index) {
                  final earning = earnings[index];
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.deepPurple.withOpacity(0.2),
                        width: 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.purple.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 3,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: ListTile(
                      title: Text(
                        earning.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      subtitle: Text(
                        earning.date,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 12,
                        ),
                      ),
                      trailing: Text(
                        currencyFormatter.format(earning.amount),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: earning.amount >= 0 ? Colors.green[700] : Colors.red[700],
                          fontSize: 16,
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 16), // Add some bottom padding
            ],
          ),
        ),
    )
    );

  }

// Placeholder views for other tabs
  Widget _buildPurchaseView() {
    final currencyFormatter = NumberFormat.currency(
        locale: 'en_IN',
        symbol: '₹',
        decimalDigits: 2
    );

    // Sample earnings data
    final List<EarningEntry> earnings = [
      EarningEntry(
          title: 'You Purchase Watch',
          date: '15 Nov 2023',
          amount: 5000.50
      ),
      EarningEntry(
          title: 'Skin Care Product',
          date: '30 Nov 2023',
          amount: 700.00
      ),
      EarningEntry(
          title: 'Rice',
          date: '05 Dec 2023',
          amount: 1200.75
      ),
      EarningEntry(
          title: 'You Purchase Watch',
          date: '15 Nov 2023',
          amount: 5000.50
      ),
      EarningEntry(
          title: 'Skin Care Product',
          date: '30 Nov 2023',
          amount: 700.00
      ),
      EarningEntry(
          title: 'Rice',
          date: '05 Dec 2023',
          amount: 1200.75
      ),
      EarningEntry(
          title: 'You Purchase Watch',
          date: '15 Nov 2023',
          amount: 5000.50
      ),
      EarningEntry(
          title: 'Skin Care Product',
          date: '30 Nov 2023',
          amount: 700.00
      ),
      EarningEntry(
          title: 'Rice',
          date: '05 Dec 2023',
          amount: 1200.75
      ),
    ];
    return Scaffold(
        backgroundColor: Colors.deepPurpleAccent,

      body: SingleChildScrollView(
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.deepPurpleAccent,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: earnings.length,
              itemBuilder: (context, index) {
                final earning = earnings[index];
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.deepPurple.withOpacity(0.2),
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.purple.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 3,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: ListTile(
                    title: Text(
                      earning.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    subtitle: Text(
                      earning.date,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12,
                      ),
                    ),
                    trailing: Text(
                      currencyFormatter.format(earning.amount),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: earning.amount >= 0 ? Colors.green[700] : Colors.red[700],
                        fontSize: 16,
                      ),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 16), // Add some bottom padding
          ],
        ),
      ),
    )
    );

  }

  Widget _buildReferalView() {
    final currencyFormatter = NumberFormat.currency(
        locale: 'en_IN',
        symbol: '₹',
        decimalDigits: 2
    );

    // Sample earnings data
    final List<EarningEntry> earnings = [
      EarningEntry(
          title: 'Ramesh Your Friend is Refered',
          date: '15 Jan 2024',
          amount: 100.50
      ),
      EarningEntry(
          title: 'Hema Your Friend is Refered',
          date: '30 Nov 2024',
          amount: 100.00
      ),
      EarningEntry(
          title: 'Amen Your Friend is Refered',
          date: '05 Oct 2024',
          amount: 100.75
      ),
      EarningEntry(
          title: 'Joe Your Friend is Refered',
          date: '15 Jan 2024',
          amount: 100.50
      ),
      EarningEntry(
          title: 'Madesh Your Friend is Refered',
          date: '30 Nov 2024',
          amount: 100.00
      ),
      EarningEntry(
          title: 'Fazil Your Friend is Refered',
          date: '05 Oct 2024',
          amount: 100.75
      ),
      EarningEntry(
          title: 'Ramesh Your Friend is Refered',
          date: '15 Jan 2024',
          amount: 100.50
      ),
      EarningEntry(
          title: 'Ramen Your Friend is Refered',
          date: '30 Nov 2024',
          amount: 100.00
      ),
      EarningEntry(
          title: 'Sunder Your Friend is Refered',
          date: '05 Oct 2024',
          amount: 100.75
      ),
    ];
    return Scaffold(
backgroundColor: Colors.deepOrangeAccent,
      body: SingleChildScrollView(
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.deepOrangeAccent,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: earnings.length,
              itemBuilder: (context, index) {
                final earning = earnings[index];
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.deepPurple.withOpacity(0.2),
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.purple.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 3,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: ListTile(
                    title: Text(
                      earning.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    subtitle: Text(
                      earning.date,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12,
                      ),
                    ),
                    trailing: Text(
                      currencyFormatter.format(earning.amount),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: earning.amount >= 0 ? Colors.green[700] : Colors.red[700],
                        fontSize: 16,
                      ),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 16), // Add some bottom padding
          ],
        ),
      ),
      )
    );

  }
}

class PaymentItem {
  final String icon;
  final String name;
  final String dateTime;
  final double amount;
  final Color backgroundColor;
  final bool isCompanyIcon;

  PaymentItem({
    required this.icon,
    required this.name,
    required this.dateTime,
    required this.amount,
    required this.backgroundColor,
    required this.isCompanyIcon,
  });
}