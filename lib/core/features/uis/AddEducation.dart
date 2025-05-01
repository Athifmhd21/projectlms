import 'package:flutter/material.dart';
import 'package:placementcafe/core/providers/addeducationprovider.dart';
import 'package:placementcafe/core/utils/dropdown.dart';
import 'package:placementcafe/core/utils/header.dart';
import 'package:placementcafe/core/utils/textfield.dart';
import 'package:provider/provider.dart';

class AddEducation extends StatefulWidget {
  const AddEducation({super.key});

  @override
  State<AddEducation> createState() => _AddEducationState();
}

class _AddEducationState extends State<AddEducation> {
  final _formkey = GlobalKey<FormState>();
  final List<String> Education = [
    "Select an Education",
    "UG",
    "PG",
    "DOCTRATE",
    "PH.D"
  ];
  final List<String> CourseType = [
    "Select a Course Type",
    "Full Time",
    "Part Time",
    "Distance"
  ];

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
            child: Consumer<AddEducationProvider>(
              builder: (context, provider, child) {
                return Form(
                  key: _formkey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      header(title: "Add Education"),

                      Dropdown(
                        labelText: "Education",
                        value: provider.Education,
                        items: Education,
                        validator: provider.validateEducation,
                        onChanged: (val) => provider.setEducation(val),
                      ),
                      textfeild(
                        labelText: "University/Institute",
                        controller: provider.educationcontroller,
                        validator: provider.validateUniversityOrInstitute,
                      ),
                      textfeild(
                        labelText: "Course",
                        controller: provider.coursecontroller,
                        validator: provider.validateCourse,
                      ),
                      textfeild(
                        labelText: "Specialization",
                        controller: provider.specializationcontroller,
                        validator: provider.validateSpecialization,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 8),
                      ),
                      Dropdown(
                        labelText: "Course Type",
                        value: provider.CourseType,
                        items: CourseType,
                        validator: provider.validateCourseType,
                        onChanged: (val) => provider.setCourseType(val),
                      ),

                      // Start and End inside a row
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(
                                    right: screenWidth *
                                        0.03), // Adds space between fields
                                child: textfeild(
                                    labelText: "Start Year",
                                    controller: provider.startyearcontroller,
                                    validator: provider.validateStartYear),
                              ),
                            ),
                            Expanded(
                              child: textfeild(
                                  labelText: "End Year",
                                  controller: provider.endyearcontroller,
                                  validator: provider.validateEndYear),
                            ),
                          ],
                        ),
                      ),
                      textfeild(
                          labelText: "Mark",
                          controller: provider.markcontroller,
                          validator: provider.validateMark),

                      // Updated Row for Cancel (TextButton) and Submit buttons

                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(
                                    right: screenWidth *
                                        0.05), // Adds space between buttons
                                child: TextButton(
                                  onPressed: () {
                                    provider.clearFields();
                                  },
                                  style: TextButton.styleFrom(
                                    textStyle: TextStyle(fontSize: 13),
                                  ),
                                  child: const Text("CANCEL"),
                                ),
                              ),
                            ),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  if (_formkey.currentState!.validate()) {
                                    provider.educationProvider(context);
                                  }
                                },
                                child: const Text("SUBMIT"),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
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
