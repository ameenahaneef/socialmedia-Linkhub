import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:socialmedia/core/colors/colors.dart';


const height = SizedBox(height: 10);
const height20 = SizedBox(height: 20);
const height30=SizedBox(height: 30,);
const kwidth = SizedBox(width: 10);
const kwidth20=SizedBox(width: 20,);
const kwidth45=SizedBox(width: 45,);

TextStyle style = GoogleFonts.caveat(
    textStyle: const TextStyle(
        color: Colors.white, fontSize: 50, fontWeight: FontWeight.bold));
TextStyle stylet = GoogleFonts.montserrat(
    textStyle: const TextStyle(color: Colors.white, fontSize: 18));
TextStyle nostyle = const TextStyle(color: kwhite);
TextStyle captionStyle = const TextStyle(color: kwhite, fontSize: 20);



final buttonstyle = ElevatedButton.styleFrom(
  backgroundColor: Colors.orange[800],
  foregroundColor: kwhite,
  textStyle: const TextStyle(fontSize: 15),
  elevation: 5,
  shadowColor: kwhite,
);