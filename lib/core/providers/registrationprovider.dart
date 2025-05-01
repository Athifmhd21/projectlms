import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Registrationprovider extends ChangeNotifier {
  // Controllers

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // Validation functions :-

  //validating First Name
  String? validateFirstName(String? value) {
    value = value?.trim();
    if (value == null || value.isEmpty) {
      return 'Please enter your first name';
    } else if (value.length < 3) {
      return 'Name must be at least 3 characters long';
    } else if (!RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
      return 'Only characters allowed';
    }
    return null;
  }

  //validating Last Name

  //String? validateLastName(String? value) {
  //value = value?.trim();
  //if (value != null && value.isNotEmpty) {
  //if (!RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
  //return 'Only alphabets allowed';
  // }
  // }
  // return null;
  //}

  //validating Email
  String? validateEmail(String? value) {
    value = value?.trim();
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  //validating Phone
  String? validatePhone(String? value) {
    value = value?.trim();
    if (value == null || value.isEmpty) {
      return 'Please enter your phone number';
    } else if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
      return 'Only numbers allowed';
    } else if (value.length != 10) {
      return 'Please check your number';
    }
    return null;
  }

  //validating Password
  String? validatePassword(String? value) {
    value = value?.trim();
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    } else if (value.length != 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }

  //validating Confirm Password
  String? validateConfirmPassword(String? value) {
    value = value?.trim();
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    } else if (value != passwordController.text.trim()) {
      return 'Passwords do not match';
    }
    return null;
  }

  // API Calling:-
  Future<void> registerUser(BuildContext context) async {
    final url =
        Uri.parse('https://b968-49-205-254-63.ngrok-free.app/resgister');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'firstName': firstNameController.text.trim(),
          'lastName': lastNameController.text.trim(),
          'email': emailController.text.trim(),
          'phoneNumber': phoneController.text.trim(),
          'password': passwordController.text.trim(),
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
}
