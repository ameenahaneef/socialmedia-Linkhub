import 'package:flutter/material.dart';
import 'package:socialmedia/core/colors/colors.dart';

class CustomTextformField extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  const CustomTextformField({
    super.key,
    required this.labelText,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: const TextStyle(color: kwhite, fontSize: 16),
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(
              color: kwhite,
            )),
        label: Text(
          labelText,
          style: const TextStyle(color: Colors.grey),
        ),
        floatingLabelStyle: TextStyle(color: Colors.orange[800], fontSize: 16),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(color: kwhite)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(color: kwhite)),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Colors.orange[800]!)),
        errorStyle: const TextStyle(color: kwhite),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(color: Colors.white)),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'please enter a valid $labelText';
        } else if (labelText == 'Email id') {
          if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
            return 'Please enter a valid email address';
          }
        } else if(labelText=='Username'){
          if (value.length > 30) {
            return 'Username cannot exceed 30 characters';
          }
          if (!RegExp(r'^[a-z0-9._]+$').hasMatch(value)) {
            return 'Username contains invalid characters';
          }
          if (value.startsWith('.') || value.endsWith('.')) {
            return 'Username cannot start or end with a dot (.)';
          }
          if (value.contains('..')) {
            return 'Username cannot contain consecutive dots (..)';
          }
        }
        
        else if (labelText == 'Password') {
           bool hasUpper = false;
          bool hasLower = false;
          bool hasDigit = false;
          bool hasSpecial = false;

          for (int i = 0; i < value.length; i++) {
            var char = value[i];
            if (RegExp(r'[A-Z]').hasMatch(char)) {
              hasUpper = true;
            } else if (RegExp(r'[a-z]').hasMatch(char)) {
              hasLower = true;
            } else if (RegExp(r'[0-9]').hasMatch(char)) {
              hasDigit = true;
            } else {
              hasSpecial = true;
            }
          }
          if (value.length < 8) {
            return 'Password should be at least 8 characters long';
          }
          if (!hasUpper) {
            return 'Password must contain at least one uppercase letter';
          }

          if (!hasLower) {
            return 'Password must contain at least one lowercase letter';
          }

          if (!hasDigit) {
            return 'Password must contain at least one digit';
          }

          if (!hasSpecial) {
            return 'Password must contain at least one special character';
          }
          
        } else if (labelText == 'confirm password' &&
            value != controller.text) {
          return 'Password do not match';
        }
        return null;
      },
    );
  }
}
