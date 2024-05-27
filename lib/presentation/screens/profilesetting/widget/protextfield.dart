import 'package:flutter/material.dart';
import 'package:socialmedia/core/colors/colors.dart';
import 'package:socialmedia/core/constants.dart';

TextField editfield(String label, TextEditingController controller) {
  return TextField(
    controller: controller,
    cursorColor: kwhite,
    style: const TextStyle(color: kwhite),
    decoration: InputDecoration(
      label: Text(
        label,
        style: nostyle,
      ),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: kwhite)),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: const BorderSide(color: kwhite)),
      floatingLabelStyle: TextStyle(color: Colors.orange[800], fontSize: 16),
      enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: kwhite),
          borderRadius: BorderRadius.circular(25)),
    ),
  );
}
