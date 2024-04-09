import 'package:flutter/material.dart';
import 'package:socialmedia/application/apiservices/authenticationservice.dart';
import 'package:socialmedia/core/colors/colors.dart';
import 'package:socialmedia/core/constants.dart';
import 'package:socialmedia/core/navigator.dart';
import 'package:socialmedia/presentation/screens/login/login.dart';
import 'package:socialmedia/presentation/screens/login/widget/formfield.dart';

class ResetPassword extends StatelessWidget {
  final String otp;
  final String token;
  ResetPassword({super.key, required this.otp, required this.token});
  final TextEditingController newpasswordController = TextEditingController();
  final TextEditingController confrimnewController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        foregroundColor: kwhite,
      ),
      backgroundColor: backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            CustomTextformField(
                labelText: 'newpassword', controller: newpasswordController),
            height20,
            CustomTextformField(
                labelText: 'confirm password',
                controller: confrimnewController),
            height20,
            ElevatedButton(
              onPressed: () {
                if (newpasswordController.text == confrimnewController.text) {
                  SignupService().resetPassword(otp, newpasswordController.text,
                      confrimnewController.text, token);
                  navigate(context, LoginScreen());
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: const Text('password not matching'),
                    backgroundColor: korange,
                  ));
                }
              },
              style: buttonstyle,
              child: const Text('submit'),
            )
          ],
        ),
      ),
    );
  }
}
