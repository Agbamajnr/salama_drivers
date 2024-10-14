import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:salama_users/constants/colors.dart';
import 'package:salama_users/screens/auth/id_photo_screen.dart';
import 'package:salama_users/widgets/busy_button.dart';

class RegistrationConfirmedScreen extends StatefulWidget {
  final Map<String, dynamic> payload;
  const RegistrationConfirmedScreen({super.key, required this.payload});

  @override
  State<RegistrationConfirmedScreen> createState() => _RegistrationConfirmedScreenState();
}

class _RegistrationConfirmedScreenState extends State<RegistrationConfirmedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(30),

              const Text(
                "We’ve confirmed your details",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
              ),
              const Gap(20),
              const Text(
                "Log into your account again, and begin the journey with us. First Client on Us!!",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
              const Gap(20),
              SizedBox(height: 300, child: Image.asset("assets/image 134.png")),
              Spacer(),
              BusyButton(
                title: "Let's Go",
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          IdPhotoPage(payload: widget.payload)));
                },
              ),
              Gap(20)
            ],
          ),
        ),
      ),
    );
  }
}
