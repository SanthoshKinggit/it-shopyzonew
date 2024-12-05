// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PurchaseEarningsScreen extends StatelessWidget {
  final List<Map<String, dynamic>> purchaseEarnings = [
    {
      'product': 'Wireless Headphones',
      'date': '2024-01-15',
      'earnings': 2050.50
    },
    {
      'product': 'Smart Watch',
      'date': '2024-02-20',
      'earnings': 2975.75
    },

    {
      'product': 'Wireless Headphones',
      'date': '2024-01-15',
      'earnings': 2050.50
    },
    {
      'product': 'Smart Watch',
      'date': '2024-02-20',
      'earnings': 2975.75
    },
  ];

  @override
  Widget build(BuildContext context) {
    // Calculate total earnings
    double totalEarnings = purchaseEarnings.fold(
        0, (previous, current) => previous + current['earnings']);

    return Scaffold(
      backgroundColor: Colors.purple[50],
      appBar: AppBar(
        title: Text(
          'Purchase Earnings',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
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
                colors: [Colors.deepPurple, Colors.purple],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.purple.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              children: [
                Text(
                  'Total Purchase Earnings',
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
              itemCount: purchaseEarnings.length,
              itemBuilder: (context, index) {
                final earning = purchaseEarnings[index];
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.purple.withOpacity(0.1),
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
                      earning['product'],
                      style: TextStyle(
                        color: Colors.deepPurple,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      earning['date'],
                      style: TextStyle(
                        color: Colors.purple[700],
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
                        color: Colors.purple[100],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        Icons.shopping_bag_outlined,
                        color: Colors.deepPurple,
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
      'referredUser': 'John Doe',
      'date': '2024-01-15',
      'earnings': 1250.50
    },
    {
      'referredUser': 'Jane Smith',
      'date': '2024-02-20',
      'earnings': 1675.75
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

// Earnings History Screen
class EarningsHistoryScreen extends StatelessWidget {
  final List<Map<String, dynamic>> earningsHistory = [
    {
      'type': 'Purchase',
      'date': '2024-01-15',
      'earnings': 25.50
    },
    {
      'type': 'Referral',
      'date': '2024-02-20',
      'earnings': 20.75
    },
    {
      'type': 'Purchase',
      'date': '2024-03-10',
      'earnings': 35.25
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Earnings History'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Total Earnings: \$81.50',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: earningsHistory.length,
              itemBuilder: (context, index) {
                final earning = earningsHistory[index];
                return ListTile(
                  title: Text(earning['type']),
                  subtitle: Text(earning['date']),
                  trailing: Text('\$${earning['earnings']}'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class PurchaseHistoryScreen extends StatelessWidget {
  final List<Map<String, dynamic>> purchaseHistory = [
    {
      'name': 'Nike Shoes',
      'date': '2024-01-15',
      'amount': 129.99,
      'status': 'Delivered',
      'icon': 'N'
    },
    {
      'name': 'Wireless Earbuds',
      'date': '2024-02-20',
      'amount': 79.50,
      'status': 'Shipped',
      'icon': 'W'
    },
    {
      'name': 'Laptop Bag',
      'date': '2024-03-10',
      'amount': 55.25,
      'status': 'Delivered',
      'icon': 'L'
    }
  ];

  @override
  Widget build(BuildContext context) {
    // Calculate total purchase amount
    double totalPurchaseAmount = purchaseHistory.fold(
        0,
            (previousValue, element) => previousValue + element['amount']
    );

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.blue,
        title: Text(
          'Purchase History',
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list, color: Colors.white),
            onPressed: () {
              // Add filter functionality if needed
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              padding: EdgeInsets.all(16),
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total Purchases',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  Text(
                    '\$${totalPurchaseAmount.toStringAsFixed(2)}',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.green
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 16),
              itemCount: purchaseHistory.length,
              separatorBuilder: (context, index) => Divider(height: 1),
              itemBuilder: (context, index) {
                final purchase = purchaseHistory[index];
                return Container(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Row(
                    children: [
                      // Purchase Icon
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: _getColorForName(purchase['icon']),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            purchase['icon'],
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 12),

                      // Name and Date
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              purchase['name'],
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              purchase['date'],
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Amount and Status
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '\$${purchase['amount']}',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.green
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            purchase['status'],
                            style: TextStyle(
                                color: _getStatusColor(purchase['status']),
                                fontSize: 14,
                                fontWeight: FontWeight.w500
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to get color based on name initial
  Color _getColorForName(String initial) {
    switch (initial) {
      case 'N':
        return Colors.teal;
      case 'W':
        return Colors.orange;
      case 'L':
        return Colors.purple;
      default:
        return Colors.blue;
    }
  }

  // Helper method to get status color
  Color _getStatusColor(String status) {
    switch (status) {
      case 'Delivered':
        return Colors.green;
      case 'Shipped':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }
}

class TransactionHistoryScreen extends StatelessWidget {
  final List<Transaction> transactions = [
    Transaction(
      date: DateTime(2024, 1, 15),
      description: 'Salary Deposit',
      amount: 5000.00,
      type: TransactionType.credit,
    ),
    Transaction(
      date: DateTime(2024, 1, 20),
      description: 'Grocery Shopping',
      amount: 250.50,
      type: TransactionType.debit,
    ),
    Transaction(
      date: DateTime(2024, 1, 25),
      description: 'Online Shopping',
      amount: 350.75,
      type: TransactionType.debit,
    ),
    Transaction(
      date: DateTime(2024, 2, 1),
      description: 'Freelance Payment',
      amount: 1200.00,
      type: TransactionType.credit,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    // Calculate total summary
    double totalCredit = transactions
        .where((t) => t.type == TransactionType.credit)
        .map((t) => t.amount)
        .reduce((a, b) => a + b);

    double totalDebit = transactions
        .where((t) => t.type == TransactionType.debit)
        .map((t) => t.amount)
        .reduce((a, b) => a + b);

    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        title: Text('Transaction History'),
        backgroundColor: Colors.blue[800],
        elevation: 0,
      ),
      body: Column(
        children: [
          // Summary Cards
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildSummaryCard(
                  title: 'Total Credit',
                  amount: totalCredit,
                  color: Colors.green[100]!,
                  textColor: Colors.green[800]!,
                ),
                _buildSummaryCard(
                  title: 'Total Debit',
                  amount: totalDebit,
                  color: Colors.red[100]!,
                  textColor: Colors.red[800]!,
                ),
              ],
            ),
          ),

          // Transaction List
          Expanded(
            child: Card(
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListView.separated(
                padding: EdgeInsets.all(16),
                itemCount: transactions.length,
                separatorBuilder: (context, index) => Divider(
                  color: Colors.blue[100],
                  thickness: 1,
                ),
                itemBuilder: (context, index) {
                  final transaction = transactions[index];
                  return _buildTransactionTile(transaction);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard({
    required String title,
    required double amount,
    required Color color,
    required Color textColor,
  }) {
    return Container(
      width: 150,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            '\$${amount.toStringAsFixed(2)}',
            style: TextStyle(
              color: textColor,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionTile(Transaction transaction) {
    return ListTile(
      title: Text(
        transaction.description,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.blue[800],
        ),
      ),
      subtitle: Text(
        '${transaction.date.toLocal()}'.split(' ')[0],
        style: TextStyle(color: Colors.blue[600]),
      ),
      trailing: Text(
        '\$${transaction.amount.toStringAsFixed(2)}',
        style: TextStyle(
          color: transaction.type == TransactionType.credit
              ? Colors.green[700]
              : Colors.red[700],
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

enum TransactionType {
  credit,
  debit,
}

class Transaction {
  final DateTime date;
  final String description;
  final double amount;
  final TransactionType type;

  Transaction({
    required this.date,
    required this.description,
    required this.amount,
    required this.type,
  });
}