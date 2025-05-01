import 'package:flutter/material.dart';
import 'package:placementcafe/core/providers/addskillsprovider.dart';
import 'package:placementcafe/core/utils/dropdown.dart';
import 'package:placementcafe/core/utils/header.dart';
import 'package:placementcafe/core/utils/textfield.dart';
import 'package:provider/provider.dart';

class AddSkills extends StatefulWidget {
  const AddSkills({super.key});

  @override
  State<AddSkills> createState() => _AddSkillsState();
}

class _AddSkillsState extends State<AddSkills> {
  final _formkey = GlobalKey<FormState>();
  final List<String> Proficiency = [
    "Select your proficiency",
    "Beginner",
    "Intermediate",
    "Advanced"
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
            child: Consumer<Addskillsprovider>(
                builder: (context, provider, child) {
              return Form(
                key: _formkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    header(title: "Add Skills"),
                    textfeild(
                        labelText: "Skills",
                        controller: provider.skillscontroller,
                        validator: provider.validateSkills),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Dropdown(
                          labelText: "Proficiency",
                          value: provider.Proficiency,
                          validator: provider.validateProficiency,
                          items: Proficiency,
                          onChanged: (val) => provider.setProficiency(val)),
                    ),
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
                                  provider.skillProvider(context);
                                }
                              },
                              child: const Text("SAVE"),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
