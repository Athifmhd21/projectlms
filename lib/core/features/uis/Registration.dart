import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:placementcafe/core/utils/textfield.dart';
import 'package:provider/provider.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // THIS IS USED TO VALIDATE EMAIL.
  bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  // REQUESTING FOR API.
  Future<void> registerUser() async {
    final url = Uri.parse('http://192.168.0.107:8080/register');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'firstName': firstNameController.text,
          'lastName': lastNameController.text,
          'email': emailController.text,
          'phoneNumber': phoneController.text,
          'password': passwordController.text
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Registration Successful")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Registration failed: ${response.body}")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("An error occurred: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get the screen width for responsive layout
    double screenWidth = MediaQuery.of(context).size.width;
    final spacing = screenWidth * 0.03;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: screenWidth < 350 ? screenWidth * 0.9 : 300,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text(
                  "REGISTRATION",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),

                // First Name
                textfeild(
                  labelText: "First Name",
                  controller: firstNameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your first name';
                    } else if (value.length < 3) {
                      return 'Name must be at least 3 characters long';
                    } else if (!RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
                      return 'Only characters allowed';
                    }
                    return null;
                  },
                ),

                // Last Name
                textfeild(
                  labelText: "Last Name",
                  controller: lastNameController,
                  validator: (value) {
                    if (value != null && value.isNotEmpty) {
                      if (!RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
                        return 'Only alphabets allowed';
                      }
                    }
                    return null;
                  },
                ),

                // Email
                textfeild(
                  labelText: "Email",
                  controller: emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    } else if (!isValidEmail(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),

                // Phone
                textfeild(
                  labelText: "Phone Number",
                  controller: phoneController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your phone number';
                    } else if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                      return 'Only numbers allowed';
                    } else if (value.length != 10) {
                      return 'Please check your number';
                    }
                    return null;
                  },
                ),

                // Password
                textfeild(
                  labelText: "Password",
                  controller: passwordController,
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    } else if (value.length < 6) {
                      return 'Password must be at least 6 characters long';
                    }
                    return null;
                  },
                ),

                // Confirm Password
                textfeild(
                  labelText: "Confirm Password",
                  controller: confirmPasswordController,
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please confirm your password';
                    } else if (value != passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),

                // Submit Button
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      registerUser();
                    }
                  },
                  child: const Text("SUBMIT"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
