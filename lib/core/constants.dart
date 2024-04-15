import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:socialmedia/core/colors/colors.dart';

TextStyle style = GoogleFonts.caveat(
    textStyle: const TextStyle(
        color: Colors.white, fontSize: 50, fontWeight: FontWeight.bold));
const height = SizedBox(height: 10);
const height20 = SizedBox(height: 20);
const kwidth = SizedBox(width: 10);

TextStyle stylet = GoogleFonts.montserrat(
    textStyle: const TextStyle(color: Colors.white, fontSize: 18));

final buttonstyle = ElevatedButton.styleFrom(
  backgroundColor: Colors.orange[800],
  foregroundColor: kwhite,
  textStyle: const TextStyle(fontSize: 15),
  elevation: 5,
  shadowColor: kwhite,
);

TextStyle nostyle = const TextStyle(color: kwhite);
TextStyle captionStyle = const TextStyle(color: kwhite, fontSize: 20);
