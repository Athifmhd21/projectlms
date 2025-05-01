import 'package:flutter/material.dart';

Widget textfeild({
  required String labelText,
  String? hintText,
  TextEditingController? controller,
  String? Function(String?)? validator,
  obscureText = false,
  Function(String value)? onChanged,
}) {
  return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: TextFormField(
        obscureText: obscureText,
        controller: controller,
        validator: validator,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          labelStyle: TextStyle(
            fontSize: 15,
            fontStyle: FontStyle.italic,
            color: Colors.white,
          ),
          border: OutlineInputBorder(),
          filled: true,
          fillColor: Colors.black,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: const Color.fromARGB(132, 255, 255, 255),
            ),
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        ),
      ));
}
