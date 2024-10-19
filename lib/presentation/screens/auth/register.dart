import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:salama_users/core/extensions/ctx_extension.dart';
import 'package:salama_users/presentation/widgets/busy_button.dart';

import '../../../core/routes/router_names.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  // Global key for the form
  final _formKey = GlobalKey<FormState>();

  // Controllers for the form fields
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _middleNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _phoneController = TextEditingController();
  final _countryController = TextEditingController();
  final _plateNoController = TextEditingController();
  final _addressController = TextEditingController();

  // Disposing controllers when done
  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _middleNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _phoneController.dispose();
    _countryController.dispose();
    _plateNoController.dispose();
    super.dispose();
  }

  // Email validation
  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return 'Enter a valid email';
    }
    return null;
  }

  // Password match validation
  String? _validatePasswordMatch(String? value) {
    if (value != _passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
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
                SizedBox(height: 16.0),

                // Last Name
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
                SizedBox(height: 16.0),

                // Middle Name
                TextFormField(
                  controller: _middleNameController,
                  decoration: InputDecoration(
                    labelText: 'Middle Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16.0),

                TextFormField(
                  controller: _countryController,
                  decoration: InputDecoration(
                    labelText: 'Country',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your country';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),

                TextFormField(
                  controller: _addressController,
                  decoration: InputDecoration(
                    labelText: 'Address',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your address';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),

                // Email
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: _validateEmail,
                ),
                SizedBox(height: 16.0),

                // Phone
                TextFormField(
                  controller: _phoneController,
                  decoration: InputDecoration(
                    labelText: 'Phone',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your phone number';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),

                // Password
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),

                // Confirm Password
                TextFormField(
                  controller: _confirmPasswordController,
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                  validator: _validatePasswordMatch,
                ),
                SizedBox(height: 30.0),

                // Register Button
                BusyButton(
                  title: "Proceed",
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      FocusScopeNode currentFocus = FocusScope.of(context);
                      if (!currentFocus.hasPrimaryFocus &&
                          currentFocus.focusedChild != null) {
                        currentFocus.focusedChild?.unfocus();
                      }
                      context.auth.onboardingData.value['firstName'] =
                          _firstNameController.text.trim();
                      context.auth.onboardingData.value['lastName'] =
                          _lastNameController.text.trim();
                      context.auth.onboardingData.value['middleName'] =
                          _middleNameController.text.trim();
                      context.auth.onboardingData.value['country'] =
                          _countryController.text.trim();
                      context.auth.onboardingData.value['address'] =
                          _addressController.text.trim();
                      context.auth.onboardingData.value['userType'] = 'driver';
                      context.auth.onboardingData.value['email'] =
                          _emailController.text.trim();
                      context.auth.onboardingData.value['phone'] =
                          _phoneController.text.trim();
                      context.auth.onboardingData.value['password'] =
                          _passwordController.text.trim();
                      context.auth.onboardingData.value['rePassword'] =
                          _confirmPasswordController.text.trim();
                      context.auth.onboardingData.value['device'] = 'Android';
                      context.nav.pushNamed(Routes.photoConsentScreen);
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
