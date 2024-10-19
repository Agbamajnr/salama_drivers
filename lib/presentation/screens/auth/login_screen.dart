import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:salama_users/core/extensions/__export.dart';
import 'package:salama_users/core/styles/colors.dart';
import 'package:salama_users/presentation/screens/auth/register.dart';
import 'package:salama_users/presentation/widgets/busy_button.dart';
import 'package:salama_users/presentation/widgets/custom_single_scroll_view.dart';

import '../../../core/routes/router_names.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  final _formKey = GlobalKey<FormState>();

  // Controllers for the text fields
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // Disposing controllers when done
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        automaticallyImplyLeading: false,
      ),
      body: CustomSingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Gap(30),
                // Email field
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                      return 'Enter a valid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),

                // Password field
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
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

                const SizedBox(height: 44.0),
                Spacer(),
                BusyButton(
                  title: "Proceed",
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      FocusScopeNode currentFocus = FocusScope.of(context);
                      if (!currentFocus.hasPrimaryFocus &&
                          currentFocus.focusedChild != null) {
                        currentFocus.focusedChild?.unfocus();
                      }
                      context.auth.login(
                          email: _emailController.text.trim(),
                          password: _passwordController.text.trim(),
                          device: 'Android')
                            .then((success) {
                              if (success) {
                                context.nav.pushNamedAndRemoveUntil(
                                    Routes.home,
                                    (Route<dynamic> route) => false);
                              }
                            });
                          ;
                    }
                  },
                ),
                Gap(10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("No account? "),
                    GestureDetector(
                      onTap: () {
                        // Navigate to the Registration screen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegistrationScreen()),
                        );
                      },
                      child: Text(
                        "Register",
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
