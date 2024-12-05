
// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ReferralEarningsScreen extends StatefulWidget {
  @override
  State<ReferralEarningsScreen> createState() => _ReferralEarningsScreenState();
}

class _ReferralEarningsScreenState extends State<ReferralEarningsScreen> {
  final List<Map<String, dynamic>> referralEarnings = [
    {
      'referredUser': 'John Doe',
      'date': '2024-01-15',
      'earnings': 1250.50
    },
    {
      'referredUser': 'Jane Smith',
      'date': '2024-02-20',
      'earnings': 1675.75
    },
    {
      'referredUser': 'Tony',
      'date': '2024-02-10',
      'earnings': 120.50
    },
    {
      'referredUser': ' Smith',
      'date': '2024-01-20',
      'earnings': 175.75
    },
  ];

  @override
  Widget build(BuildContext context) {
    // Calculate total earnings
    double totalEarnings = referralEarnings.fold(
        0, (previous, current) => previous + current['earnings']);

    return Scaffold(
      backgroundColor: Colors.green[50],
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios,color: Colors.white,),),
        title: Text(
          'Referral Earnings',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.green[700],
        elevation: 0,
      ),
      body: Column(
        children: [
          // Total Earnings Container
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            margin: EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.green[700]!, Colors.green[600]!],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.green.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              children: [
                Text(
                  'Total Referral Earnings',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  '₹${NumberFormat('#,##,##0.00').format(totalEarnings)}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          // Earnings List
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16),
              itemCount: referralEarnings.length,
              itemBuilder: (context, index) {
                final earning = referralEarnings[index];
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.green.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 3,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 16,
                    ),
                    title: Text(
                      earning['referredUser'],
                      style: TextStyle(
                        color: Colors.green[800],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      earning['date'],
                      style: TextStyle(
                        color: Colors.green[700],
                      ),
                    ),
                    trailing: Text(
                      '₹${NumberFormat('#,##,##0.00').format(earning['earnings'])}',
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    leading: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.green[100],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        Icons.people_outline,
                        color: Colors.green[800],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}


class TotalEarningsScreen extends StatelessWidget {
  // Sample earnings data
  final Map<String, double> earningBreakdown = {
    'Purchase Earnings': 5250.50,
    'Referral Earnings': 3625.75,
    'Bonus Earnings': 1875.25,
    'Cashback': 1250.00,
  };

  @override
  Widget build(BuildContext context) {
    // Calculate total earnings
    double totalEarnings = earningBreakdown.values.reduce((a, b) => a + b);

    return Scaffold(

      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios,color: Colors.white,),),
        title: Text('Total Earnings', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.teal,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Total Earnings Header
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.teal, Colors.tealAccent[700]!],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.teal.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Text(
                    'Total Earnings',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    '₹${NumberFormat('#,##,##0.00').format(totalEarnings)}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            // Earnings Breakdown Title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Text(
                'Earnings Breakdown',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal[800],
                ),
              ),
            ),

            // Earnings Breakdown List
            ...earningBreakdown.entries.map((entry) => _buildEarningItem(
              entry.key,
              entry.value,
              totalEarnings,
            )),

            // Additional Insights
            _buildInsightsCard(totalEarnings),
          ],
        ),
      ),
    );
  }

  // Custom widget for individual earning items
  Widget _buildEarningItem(String type, double amount, double total) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.teal.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        title: Text(
          type,
          style: TextStyle(
            color: Colors.teal[800],
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '₹${NumberFormat('#,##,##0.00').format(amount)}',
              style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '${((amount / total) * 100).toStringAsFixed(1)}%',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
            ),
          ],
        ),
        leading: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.teal[100],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            _getIconForEarningType(type),
            color: Colors.teal[800],
          ),
        ),
      ),
    );
  }

  // Custom insights card
  Widget _buildInsightsCard(double totalEarnings) {
    return Container(
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.teal[50],
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.teal[100]!, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Earnings Insights',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.teal[800],
            ),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Average Monthly Earnings'),
              Text(
                '₹${NumberFormat('#,##,##0.00').format(totalEarnings / 12)}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.teal[700],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Helper method to get icons based on earning type
  IconData _getIconForEarningType(String type) {
    switch (type) {
      case 'Purchase Earnings':
        return Icons.shopping_bag_outlined;
      case 'Referral Earnings':
        return Icons.people_outline;
      case 'Bonus Earnings':
        return Icons.card_giftcard;
      case 'Cashback':
        return Icons.money_off;
      default:
        return Icons.money;
    }
  }
}
