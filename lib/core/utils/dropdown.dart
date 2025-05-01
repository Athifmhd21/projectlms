import 'package:flutter/material.dart';

Widget Dropdown({
  required String labelText,
  required String? value,
  required List<String> items,
  required ValueChanged<String?> onChanged,
  String? Function(String?)? validator,
}) {
  return DropdownButtonFormField<String>(
    dropdownColor: Colors.grey[900],
    value: value,
    validator: validator,
    isExpanded: true,
    decoration: InputDecoration(
      labelText: labelText,
      filled: true,
      fillColor: Colors.white10,
      labelStyle: const TextStyle(color: Colors.white),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
    ),
    icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
    items: items
        .map((item) => DropdownMenuItem(
              value: item,
              child: Text(item, style: const TextStyle(color: Colors.white)),
            ))
        .toList(),
    onChanged: onChanged,
  );
}
