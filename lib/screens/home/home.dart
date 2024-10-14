import 'package:flutter/material.dart';
import 'package:salama_users/constants/colors.dart';
import 'package:salama_users/screens/home/active_drivers_screen.dart';
import 'package:salama_users/screens/home/earning_screen.dart';
import 'package:salama_users/screens/home/history_list.screen.dart';
import 'package:salama_users/screens/home/home_screen.dart';
import 'package:salama_users/screens/home/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  // List of pages (screens) for each navigation tab
  final List<Widget> _pages = [
    const DashboardScreen(),
    RideHistoryScreen(),
    EarningsScreen(),
    ProfileScreen()
  ];

  // Function to handle navigation bar tap
  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: AppColors.white,
        selectedIconTheme: IconThemeData(color: AppColors.primaryColor),
        unselectedIconTheme: IconThemeData(color: AppColors.grey),
        selectedLabelStyle: TextStyle(color: AppColors.primaryColor),
        unselectedLabelStyle: TextStyle(color: AppColors.grey),
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppColors.white,
        showSelectedLabels: true,
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.subscriptions_outlined),
            label: 'Subscriptions',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
