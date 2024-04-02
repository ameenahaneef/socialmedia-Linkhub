import 'package:flutter/material.dart';
import 'package:socialmedia/core/colors/colors.dart';
import 'package:socialmedia/core/constants.dart';
import 'package:socialmedia/presentation/screens/login/login.dart';
import 'package:socialmedia/presentation/screens/otp/widget/otpformfield.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        foregroundColor: kwhite,
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 20.0, top: 70),
        child: SizedBox(
          width: 350,
          height: 400,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Text(
                  'OTP Verification',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                height20,
                const Text(
                  'We Have sent a verification code to your\nemail address',
                  style: TextStyle(color: kwhite, fontSize: 15),
                ),
                height20,
                const Form(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    otpwidgettextform(),
                    otpwidgettextform(),
                    otpwidgettextform(),
                    otpwidgettextform(),
                  ],
                )),
                height20,
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context){
                      return LoginScreen();
                    }));
                  },
                  style: buttonstyle,
                  child: const Text('Submit'),
                ),
                height20,
                TextButton(
                    onPressed: () {},
                    child: Text(
                      'Resend OTP?',
                      style: nostyle,
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
