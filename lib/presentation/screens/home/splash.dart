import 'package:flutter/material.dart';
import 'package:socialmedia/core/colors/colors.dart';
import 'package:socialmedia/core/constants.dart';
import 'package:socialmedia/presentation/screens/home/homesplash.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) {
          return const HomeSplash();
        }),
        (route) => false,
      );
    });
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('LinkHub', style: style),
          ],
        ),
      ),
    );
  }
}
