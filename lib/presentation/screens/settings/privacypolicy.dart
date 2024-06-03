import 'package:flutter/material.dart';
import 'package:socialmedia/core/colors/colors.dart';
import 'package:socialmedia/core/constants.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
     backgroundColor: black,
      appBar: AppBar(backgroundColor: black,foregroundColor: kwhite,),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0,right: 8.0),
          child: text,
        ),
        ),
    );
  }
}