import 'package:flutter/material.dart';
import 'package:socialmedia/core/colors/colors.dart';
import 'package:socialmedia/core/constants.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      
      backgroundColor: black,
      appBar: AppBar(backgroundColor: black,foregroundColor: kwhite,),
      body: Padding(
        padding: const EdgeInsets.only(left:10.0,right: 10),
        child: textabout,
      ),
    );
  }
}