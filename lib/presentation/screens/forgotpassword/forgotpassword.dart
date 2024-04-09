import 'package:flutter/material.dart';
import 'package:socialmedia/application/apiservices/authenticationservice.dart';
import 'package:socialmedia/core/colors/colors.dart';
import 'package:socialmedia/core/constants.dart';
import 'package:socialmedia/core/navigator.dart';
import 'package:socialmedia/presentation/screens/forgotpassword/passwordotp.dart';
import 'package:socialmedia/presentation/screens/login/widget/formfield.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});

  final TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        foregroundColor: kwhite,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SizedBox(
          height: 250,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Enter your Email id',
                style: nostyle,
              ),
              CustomTextformField(
                labelText: 'Please enter your Email id',
                controller: emailController,
              ),
              Center(
                  child: ElevatedButton(
                onPressed: () async {
                  String token = await SignupService()
                      .forgotpassword(emailController.text);
                  navigate(context, PasswordOtpScreen(token: token));
                },
                style: buttonstyle,
                child: const Text('Submit'),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
