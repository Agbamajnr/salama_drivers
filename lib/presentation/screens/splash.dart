import 'package:flutter/material.dart';
import 'package:salama_users/core/extensions/__export.dart';
import 'package:salama_users/core/styles/colors.dart';
import '../../core/routes/router_names.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 1000), () {
      context.auth.checkSavedUser().then((value) {
        if (value) {
          context.nav.pushReplacementNamed(Routes.home);
        } else {
          context.nav.pushReplacementNamed(Routes.login);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Center(child: Image.asset("assets/logo.png")),
      ),
    );
  }
}
