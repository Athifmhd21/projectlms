import 'package:flutter/material.dart';

Widget header({
  required String title,
  double fontSize = 30,
  Color color = Colors.white,
  FontWeight fontWeight = FontWeight.bold,
  TextAlign align = TextAlign.center,
  FontStyle fontStyle = FontStyle.normal,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 20.0),
    child: Text(
      title,
      textAlign: align,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        fontStyle: fontStyle,
      ),
    ),
  );
}
