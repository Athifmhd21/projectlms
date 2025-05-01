import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddEducationProvider extends ChangeNotifier {
  final educationcontroller = TextEditingController();
  final universityorinstitutecontroller = TextEditingController();
  final coursecontroller = TextEditingController();
  final specializationcontroller = TextEditingController();
  final coursetypecontroller = TextEditingController();
  final startyearcontroller = TextEditingController();
  final endyearcontroller = TextEditingController();
  final markcontroller = TextEditingController();

  String? _Education = "Select an Education";
  String? get Education => _Education;
  void setEducation(String? newEducation) {
    _Education = newEducation;
    notifyListeners();
  }

  String? _CourseType = "Select a Course Type";
  String? get CourseType => _CourseType;
  void setCourseType(String? newCourseType) {
    _CourseType = newCourseType;
    notifyListeners();
  }

  String? validateEducation(String? value) {
    value = value?.trim();
    if (value == null || value == 'Select an Education') {
      return 'Please select a field';
    }
    return null;
  }

  String? validateUniversityOrInstitute(String? value) {
    value = value?.trim();
    if (value == null || value.isEmpty) {
      return 'Please enter the value';
    } else if (!RegExp(r'[a-zA-Z-&]+$').hasMatch(value)) {
      return 'Only characters allowed';
    }
    return null;
  }

  String? validateCourse(String? value) {
    value = value?.trim();
    if (value == null || value.isEmpty) {
      return 'Please enter the value';
    } else if (!RegExp(r'[a-zA-Z-&]+$').hasMatch(value)) {
      return 'Only characters allowed';
    }
    return null;
  }

  String? validateSpecialization(String? value) {
    value = value?.trim();
    if (value == null || value.isEmpty) {
      return 'PLease enter the value';
    } else if (!RegExp(r'[a-zA-Z-&]+$').hasMatch(value)) {
      return 'Only characters allowed';
    }
    return null;
  }

  String? validateCourseType(String? value) {
    value = value?.trim();
    if (value == null || value == "Select a Course Type") {
      return 'PLease enter the value';
    }
    return null;
  }

  String? validateStartYear(String? value) {
    value = value?.trim();
    if (value == null || value.isEmpty) {
      return 'Please enter the value';
    } else if (!RegExp(r'^\d{4}$').hasMatch(value)) {
      return 'Enter a valid 4-digit year';
    }
    return null;
  }

  String? validateEndYear(String? value) {
    value = value?.trim();
    final startValue = startyearcontroller.text.trim();

    if (value == null || value.isEmpty) {
      return 'Please enter the value';
    } else if (!RegExp(r'^\d{4}$').hasMatch(value)) {
      return 'Enter a valid 4-digit year';
    } else if (!RegExp(r'^\d{4}$').hasMatch(startValue)) {
      return 'Enter a valid start year first';
    } else {
      int endYear = int.parse(value);
      int startYear = int.parse(startValue);

      if (endYear < startYear) {
        return 'End year cannot be before start year';
      }
    }
    return null;
  }

  String? validateMark(String? value) {
    value = value?.trim();
    if (value == null || value.isEmpty) {
      return 'Please enter your mark';
    } else if (!RegExp(r'^\d+(\.\d+)?%?$').hasMatch(value)) {
      return 'Only numbers and "%" are allowed';
    } else if (value.endsWith('%')) {
      value = value.substring(0, value.length - 1);
    }
    final mark = double.parse(value);
    if (mark < 0 || mark > 100) {
      return 'Mark must be between 0 and 100';
    }
    return null;
  }

  int getEducation() {
    if (_Education == "UG") return 1;
    if (_Education == "PG") return 2;
    if (_Education == "DOCTRATE") return 3;
    if (_Education == "PH.D") return 4;
    return 0;
  }

  int getCourseType() {
    if (_CourseType == "Full Time") return 1;
    if (_CourseType == "Part Time") return 2;
    if (_CourseType == "Distance") return 3;
    return 0;
  }

  void clearFields() {
    educationcontroller.clear();
    universityorinstitutecontroller.clear();
    coursecontroller.clear();
    specializationcontroller.clear();
    coursetypecontroller.clear();
    startyearcontroller.clear();
    endyearcontroller.clear();
    markcontroller.clear();
    _Education = "Select an Education";
    _CourseType = "Select a Course Type";
    notifyListeners();
  }

  Future<void> educationProvider(BuildContext context) async {
    final url = Uri.parse(
        'https://b968-49-205-254-63.ngrok-free.app/registerOrganization');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'education': getEducation(),
          'university/institute': universityorinstitutecontroller.text.trim(),
          'course': coursecontroller.text.trim(),
          'specialization': specializationcontroller.text.trim(),
          'course Type': getCourseType(),
          'start year': startyearcontroller.text.trim(),
          'end year': endyearcontroller.text.trim()
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
