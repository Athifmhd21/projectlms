import 'package:flutter/material.dart';
import 'package:placementcafe/core/features/uis/AddEducation.dart';
import 'package:placementcafe/core/features/uis/AddSkills.dart';
import 'package:placementcafe/core/features/uis/RegisterOrganization.dart';
import 'package:placementcafe/core/features/uis/Registration.dart';
import 'package:placementcafe/core/providers/addskillsprovider.dart';
import 'package:placementcafe/core/providers/registerorganizationprovider.dart';
import 'package:placementcafe/core/providers/registrationprovider.dart';
import 'package:placementcafe/core/providers/addeducationprovider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => Registrationprovider()),
      ChangeNotifierProvider(
        create: (context) => Registerorganizationprovider(),
      ),
      ChangeNotifierProvider(
        create: (context) => AddEducationProvider(),
      ),
      ChangeNotifierProvider(create: (context) => Addskillsprovider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AddEducation(),
      debugShowCheckedModeBanner: false,
    );
  }
}
