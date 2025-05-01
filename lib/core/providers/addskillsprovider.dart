import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Addskillsprovider extends ChangeNotifier {
  final skillscontroller = TextEditingController();
  final proficiancycontroller = TextEditingController();

  String? _Proficiency = "Select your proficiency";
  String? get Proficiency => _Proficiency;
  void setProficiency(String? newProficiency) {
    _Proficiency = newProficiency;
    notifyListeners();
  }

  int getProficiency() {
    if (_Proficiency == "Beginner") return 1;
    if (_Proficiency == "Intermediate") return 2;
    if (_Proficiency == "Advanced") return 3;
    return 0;
  }

  String? validateSkills(String? value) {
    value = value?.trim();
    if (value == null || value.isEmpty) {
      return 'Please enter the value';
    } else if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(value)) {
      return 'Only letters allowed';
    }
    return null;
  }

  String? validateProficiency(String? value) {
    value == value?.trim();
    if (value == null || value == "Select your proficiency") {
      return 'Please enter the value';
    }
    return null;
  }

  void clearFields() {
    skillscontroller.clear();
    proficiancycontroller.clear();
    _Proficiency = "Select your proficiency";
    notifyListeners();
  }

  Future<void> skillProvider(BuildContext context) async {
    final url = Uri.parse(
        'https://b968-49-205-254-63.ngrok-free.app/registerOrganization');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'skills': skillscontroller.text.trim(),
          'proficiency': getProficiency()
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
