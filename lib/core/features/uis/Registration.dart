import 'package:flutter/material.dart';
import 'package:placementcafe/core/providers/registrationprovider.dart';
import 'package:placementcafe/core/utils/textfield.dart';
import 'package:placementcafe/core/utils/header.dart';
import 'package:provider/provider.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: screenWidth < 350 ? screenWidth * 0.9 : 300,
            ),
            child: Consumer<Registrationprovider>(
              builder: (context, provider, child) {
                return Padding(
                  padding:
                      const EdgeInsets.all(20.0), // Single Padding applied here
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        header(title: "REGISTRATION"),

                        // First Name
                        textfeild(
                          labelText: "First Name",
                          controller: provider.firstNameController,
                          validator: provider.validateFirstName,
                        ),
                        // Last Name
                        textfeild(
                          labelText: "Last Name",
                          controller: provider.lastNameController,
                        ),
                        // Email
                        textfeild(
                          labelText: "Email",
                          controller: provider.emailController,
                          validator: provider.validateEmail,
                        ),
                        // Phone Number
                        textfeild(
                          labelText: "Phone Number",
                          controller: provider.phoneController,
                          validator: provider.validatePhone,
                        ),
                        // Password
                        textfeild(
                          labelText: "Password",
                          controller: provider.passwordController,
                          obscureText: true,
                          validator: provider.validatePassword,
                        ),
                        // Confirm Password
                        textfeild(
                          labelText: "Confirm Password",
                          controller: provider.confirmPasswordController,
                          obscureText: true,
                          validator: provider.validateConfirmPassword,
                        ),
                        // Submit Button
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                provider.registerUser(context);
                              }
                            },
                            child: const Text("SUBMIT"),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
