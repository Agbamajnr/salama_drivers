import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:salama_users/core/extensions/__export.dart';
import 'package:salama_users/core/routes/router_names.dart';
import 'package:salama_users/core/styles/colors.dart';

import 'package:salama_users/presentation/widgets/busy_button.dart';

class ProfilePhotoConsentScreen extends StatefulWidget {
 
  const ProfilePhotoConsentScreen({super.key});
  @override
  State<ProfilePhotoConsentScreen> createState() =>
      _ProfilePhotoConsentScreenState();
}

class _ProfilePhotoConsentScreenState extends State<ProfilePhotoConsentScreen> {
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
              SizedBox(height: 300, child: Image.asset("assets/image 130.png")),
              Text(
                "Thanks ${context.auth.onboardingData.value['firstName'] ?? ""}, now time for a photo of you",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
              ),
              const Gap(20),
              const Text(
                "We will only use your photo to verify your account and for riders.",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
              const Gap(20),
              const Spacer(),
              BusyButton(
                title: "Got it",
                onTap: () {
                  context.nav.pushNamed(Routes.profilePhotoCameraScreen);
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
