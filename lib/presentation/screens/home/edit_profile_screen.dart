import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:salama_users/core/extensions/__export.dart';
import 'package:salama_users/core/styles/colors.dart';
import 'package:salama_users/domain/entities/auth/location.dart';
import 'package:salama_users/presentation/notifiers/auth_notifier.dart';
import 'package:salama_users/presentation/widgets/busy_button.dart';
import 'package:salama_users/presentation/widgets/custom_single_scroll_view.dart';

class ProfileUpdateScreen extends StatefulWidget {
  const ProfileUpdateScreen({super.key});

  @override
  State<ProfileUpdateScreen> createState() => _ProfileUpdateScreenState();
}

class _ProfileUpdateScreenState extends State<ProfileUpdateScreen> {
  // Global key for the form
  final _formKey = GlobalKey<FormState>();

  // Controllers for the form fields
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _middleNameController = TextEditingController();

  @override
  void initState() {
    final user = context.auth.user.value;
    setState(() {
      _firstNameController.text = user?.firstName ?? "";
      _middleNameController.text = user?.middleName ?? "";
      _lastNameController.text = user?.lastName ?? "";
    });

    super.initState();
  }

  // Disposing controllers when done
  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _middleNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthNotifier>(
      builder: (context, AuthNotifier auth, child) => Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          backgroundColor: AppColors.white,
          title: const Text(
            "Profile Info",
            style: TextStyle(fontSize: 25),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: CustomSingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Gap(15),
                  // First Name
                  TextFormField(
                    controller: _firstNameController,
                    decoration: InputDecoration(
                      labelText: 'First Name',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your first name';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 18.0),

                  TextFormField(
                    controller: _middleNameController,
                    decoration: InputDecoration(
                      labelText: 'Middle Name',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      // if (value == null || value.isEmpty) {
                      //   return 'Please enter your first name';
                      // }
                      return null;
                    },
                  ),

                  SizedBox(height: 18.0),

                  TextFormField(
                    controller: _lastNameController,
                    decoration: InputDecoration(
                      labelText: 'Last Name',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your last name';
                      }
                      return null;
                    },
                  ),

                  SizedBox(height: 18.0),

                  Spacer(),
                  Gap(10),
                  BusyButton(
                      title: "Save",
                      // isLoading: aug,
                      onTap: () async {
                        final location =
                            context.subsription.currentPosition.value;
                        auth.updateUserDetails(
                            firstName: _firstNameController.text,
                            lastName: _lastNameController.text,
                            middleName: _middleNameController.text,
                            firebaseToken:
                                context.auth.user.value?.firebaseToken ?? "",
                            longitude: location?.lng ?? 0.0,
                            latitude: location?.lat ?? 0.0);
                      }),
                  Gap(10),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
