import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:salama_users/constants/colors.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  "assets/maps.png",
                ),
                fit: BoxFit.cover)),
        child: Column(
          children: [
            // Search bar
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  Gap(30),
                ],
              ),
            ),
            // List of drivers
            Expanded(
              flex: 2,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                decoration: const BoxDecoration(color: AppColors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
