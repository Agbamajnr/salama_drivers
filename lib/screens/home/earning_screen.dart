import 'package:flutter/material.dart';
import 'package:salama_users/constants/colors.dart';

class EarningsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Color(0xffC7E6FC),
            AppColors.white,
          ],
        )),
        child: Scaffold(
          backgroundColor: AppColors.white,
          appBar: AppBar(
              backgroundColor: AppColors.white,
              elevation: 0,
              automaticallyImplyLeading: false,
              title: Text('Subscriptions',
                  style: TextStyle(fontWeight: FontWeight.w700))),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Earnings Card
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Color(0xffC7E6FC),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Balance',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        '₦21,860.02',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Row(
                            children: [
                              Icon(Icons.arrow_upward, color: Colors.green),
                              Text(
                                '1,200',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: 16),
                          Row(
                            children: [
                              Icon(Icons.arrow_downward, color: Colors.red),
                              Text(
                                '120',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                // Icons Row (Withdraw, Bank Account, Subscribe)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildActionIcon(Icons.account_balance_wallet, 'Withdraw'),
                    _buildActionIcon(Icons.account_balance, 'Bank Account'),
                    _buildActionIcon(Icons.subscriptions, 'Subscribe'),
                  ],
                ),
                SizedBox(height: 16),
                // Recent Transactions Header
                Text(
                  'Recent Subscriptions',
                  style: TextStyle(
                    color: AppColors.background,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16),
                // Transaction List
                Expanded(
                  child: ListView(
                    children: [
                      _buildTransactionItem(
                          'Withdrawal', '- \$26.65', Colors.green),
                      _buildTransactionItem('Tax', '- \$26.65', Colors.red),
                      _buildTransactionItem(
                          'Earning', '+ \$26.65', Colors.green),
                      _buildTransactionItem(
                          'Earning', '+ \$26.65', Colors.green),
                      _buildTransactionItem('Tax', '- \$26.65', Colors.red),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Widget _buildActionIcon(IconData icon, String label) {
    return Column(
      children: [
        CircleAvatar(
          radius: 32,
          backgroundColor: Color(0xffC7E6FC),
          child: Icon(icon, color: Colors.white, size: 32),
        ),
        SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(),
        ),
      ],
    );
  }

  Widget _buildTransactionItem(String title, String amount, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                title == 'Withdrawal' || title == 'Earning'
                    ? Icons.arrow_upward
                    : Icons.arrow_downward,
                color: color,
              ),
              SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(color: AppColors.background),
              ),
            ],
          ),
          Text(
            amount,
            style: TextStyle(color: AppColors.grey),
          ),
        ],
      ),
    );
  }
}
