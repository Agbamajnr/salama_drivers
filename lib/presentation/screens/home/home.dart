import 'package:flutter/material.dart';
import 'package:salama_users/core/extensions/ctx_extension.dart';
import 'package:salama_users/core/styles/colors.dart';
import 'package:salama_users/presentation/screens/home/earning_screen.dart';
import 'package:salama_users/presentation/screens/home/history_list.screen.dart';
import 'package:salama_users/presentation/screens/home/home_screen.dart';
import 'package:salama_users/presentation/screens/home/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  @override
  void initState() {
    context.subsription.fetchActiveBooking(rideStatus: 'DRIVER_ACCEPTED');
    context.subsription.getCurentPosition();
    super.initState();
  }

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
        // fixedColor: AppColors.white,
        selectedIconTheme: IconThemeData(color: AppColors.primaryColor),
        unselectedIconTheme: IconThemeData(color: AppColors.grey),
        selectedLabelStyle: TextStyle(color: AppColors.primaryColor),
        unselectedLabelStyle: TextStyle(color: AppColors.primaryBlue),
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppColors.white,
        showSelectedLabels: true,
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            activeIcon: Icon(
              Icons.home,
              color: AppColors.primaryColor,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            activeIcon: Icon(
              Icons.history,
              color: AppColors.primaryColor,
            ),
            label: 'Trips',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.subscriptions_outlined),
            activeIcon: Icon(
              Icons.subscriptions_outlined,
              color: AppColors.primaryColor,
            ),
            label: 'Subscriptions',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            activeIcon: Icon(
              Icons.person,
              color: AppColors.primaryColor,
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
