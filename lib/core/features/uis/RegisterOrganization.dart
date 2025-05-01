import 'package:flutter/material.dart';
import 'package:placementcafe/core/providers/registerorganizationprovider.dart';
import 'package:placementcafe/core/utils/header.dart';
import 'package:placementcafe/core/utils/textfield.dart';
import 'package:provider/provider.dart';
import 'package:placementcafe/core/utils/dropdown.dart';

class RegisterOrganization extends StatefulWidget {
  const RegisterOrganization({super.key});

  @override
  State<RegisterOrganization> createState() => _RegisterOrganization();
}

class _RegisterOrganization extends State<RegisterOrganization> {
  final _formkey = GlobalKey<FormState>();
  final List<String> Organisation = [
    "Select an organization",
    "Company",
    "Institute"
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
            child: Consumer<Registerorganizationprovider>(
              builder: (context, provider, child) {
                return Form(
                  key: _formkey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      header(title: "lets's get you regiistered"),
                      //SizedBox(height: 50),
                      textfeild(
                        labelText: "Name",
                        controller: provider.namecontroller,
                        validator: provider.validateName,
                      ),
                      textfeild(
                          labelText: "Email",
                          controller: provider.emailcontroller,
                          validator: provider.validateEmail),
                      textfeild(
                          labelText: "Website",
                          controller: provider.websitecontroller,
                          validator: provider.validateWebsite),
                      SizedBox(
                        height: 10,
                      ),
                      Dropdown(
                          labelText: 'Organization',
                          value: provider.Organization,
                          items: Organisation,
                          validator: provider.validateOrganization,
                          onChanged: (val) => provider.setOrgansation(val)),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: ElevatedButton(
                          onPressed: () {
                            // Add validation or logic here
                            if (_formkey.currentState!.validate()) {
                              provider.registerProvider(context);
                            }
                          },
                          child: const Text("SUBMIT"),
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
