import 'package:flutter/material.dart';
import 'package:socialmedia/core/colors/colors.dart';

class textformfield extends StatelessWidget {
  final String labelText;
  const textformfield({
    super.key, required this.labelText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(color: kwhite, fontSize: 16),
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(
              color: kwhite,
            )),
        label:  Text( labelText,style: TextStyle(color: Colors.grey),),
        floatingLabelStyle: TextStyle(color: Colors.orange[800],fontSize: 16),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(color: kwhite)),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: kwhite)
            ),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Colors.orange[800]!)),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(color: Colors.white)),
      ),
      
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'please enter a value';
        }
        return null;
      },
    );
  }
}
