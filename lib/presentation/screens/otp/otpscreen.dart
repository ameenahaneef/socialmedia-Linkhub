import 'package:flutter/material.dart';
import 'package:socialmedia/application/apiservices/apiservice.dart';
import 'package:socialmedia/core/colors/colors.dart';
import 'package:socialmedia/core/constants.dart';
import 'package:socialmedia/presentation/screens/mainhomee/screenmain.dart';
import 'package:socialmedia/presentation/screens/otp/widget/otpformfield.dart';

class OtpScreen extends StatelessWidget {
  final String token;
  OtpScreen({super.key, required this.token});
  final TextEditingController controller1 = TextEditingController();
  final TextEditingController controller2 = TextEditingController();
  final TextEditingController controller3 = TextEditingController();
  final TextEditingController controller4 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        foregroundColor: kwhite,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20.0, top: 70),
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
                Form(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    otpwidgettextform(controller: controller1),
                    otpwidgettextform(
                      controller: controller2,
                    ),
                    otpwidgettextform(
                      controller: controller3,
                    ),
                    otpwidgettextform(
                      controller: controller4,
                    ),
                  ],
                )),
                height20,
                ElevatedButton(
                  onPressed: () async {
                    String otp =
                        '${controller1.text}${controller2.text}${controller3.text}${controller4.text}';
                    print(otp);
                    print('ssss');
                    bool isOtpVerified =
                        await SignupService().otpVerification(otp, token);
                    if (isOtpVerified) {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return ScreenMainPage();
                      }));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text(
                          'OTP verification failed.please try again',
                        ),
                        duration: Duration(seconds: 3),
                      ));
                    }
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
