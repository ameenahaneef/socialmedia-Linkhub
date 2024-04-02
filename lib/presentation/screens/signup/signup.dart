import 'package:flutter/material.dart';
import 'package:socialmedia/core/colors/colors.dart';
import 'package:socialmedia/core/constants.dart';
import 'package:socialmedia/presentation/screens/login/widget/formfield.dart';
import 'package:socialmedia/presentation/screens/otp/otpscreen.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: backgroundColor,foregroundColor: kwhite,),
      backgroundColor: backgroundColor,
      body: Center(
          child: Column(children: [
       
        Image.asset(
          'assets/images/[removal.ai]_b1934004-b13d-49d0-8db5-f8d0882759c9-screenshot-2024-03-30-221955.png',
          scale: 2.5,
        ),
      //const SizedBox(height: 50,),
        Expanded(
          child: Container(
            width: 370,
            decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.2),
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30))),
            child: Padding(
              padding: const EdgeInsets.all(40.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                     Text(
                          'Sign Up',
                          style: style,
                        ),height,
                    const textformfield(labelText: 'Username'),
                    height,
                    const textformfield(labelText: 'Email id'),
                    height,
                    const textformfield(labelText: 'Password'),
                    height,
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context){
                          return OtpScreen();
                        }));
                      },
                      style: buttonstyle,
                      child: const Text('Create Account'),
                    )
                  ],
                ),
              ),
            ),
          ),
        )
      ])),
    );
  }
}
