import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Registerorganizationprovider extends ChangeNotifier {
  // controllers
  final namecontroller = TextEditingController();
  final emailcontroller = TextEditingController();
  final websitecontroller = TextEditingController();
  final organizationcontroller = TextEditingController();

  String? _Organization = 'Select an organization';
  String? get Organization => _Organization;
  void setOrgansation(String? newOrganisation) {
    _Organization = newOrganisation;
    notifyListeners();
  }

// validation

// Dropdown
  String? validateOrganization(String? value) {
    value = value?.trim();
    if (value == null || value == 'Select an organization') {
      return 'Please select a field';
    }
    return null;
  }

  // Name
  String? validateName(String? value) {
    value = value?.trim();
    if (value == null || value.isEmpty) {
      return 'Please enter your organizer name';
    } else if (value.length < 2) {
      return 'Name must be at least 2 characters long';
    } else if (!RegExp(r'^[a-zA-Z-0-9]+$').hasMatch(value)) {
      return 'Only characters allowed';
    }
    return null;
  }

  // Email
  String? validateEmail(String? value) {
    value = value?.trim();
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  // Website
  String? validateWebsite(String? value) {
    value = value?.trim();
    if (value == null || value.isEmpty) {
      return 'Please enter your website';
    }

    // Regex: www. + [2-53 alphanum & symbols] + . + [2-53 letters]
    final regex = RegExp(r'^www\.([a-zA-Z0-9._-]{2,53})\.([a-zA-Z]{2,53})$');

    if (!regex.hasMatch(value)) {
      return 'Enter a valid website like www.my-site.name';
    }

    return null;
  }

  int getOrganizationType() {
    if (_Organization == "Company") return 1;
    if (_Organization == "Institute") return 2;
    return 0;
  }

  // Api
  Future<void> registerProvider(BuildContext context) async {
    final url = Uri.parse(
        'https://b968-49-205-254-63.ngrok-free.app/registerOrganization');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json', 'userToken': '105'},
        body: jsonEncode({
          'orgName': namecontroller.text.trim(),
          'orgEmail': emailcontroller.text.trim(),
          'website': websitecontroller.text.trim(),
          'type': getOrganizationType()
        }),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Registration Successfull")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Registration Failed:${response.body}")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("An error occured:$e")),
      );
    }
  }
}
