import 'package:flutter/material.dart';
import 'package:socialmedia/core/constants.dart';

TextButton textbutton(String text,VoidCallback onPressed) {
  return TextButton(
      onPressed:onPressed,
      child: Text(
        text,
        style: nostyle,
      ));
}
