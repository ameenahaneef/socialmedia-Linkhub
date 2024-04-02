import 'package:flutter/material.dart';
import 'package:socialmedia/core/constants.dart';
import 'package:socialmedia/presentation/screens/forgotpassword/forgotpassword.dart';
import 'package:socialmedia/presentation/screens/login/widget/formfield.dart';
import 'package:socialmedia/presentation/screens/profile/profilescreen.dart';
import 'package:socialmedia/presentation/screens/signup/signup.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 35,
            ),
            Center(
                child: Image.asset(
              'assets/images/[removal.ai]_b1934004-b13d-49d0-8db5-f8d0882759c9-screenshot-2024-03-30-221955.png',
              scale: 2.5,
            )),
            height20,
            Text(
              'LinkHub',
              style: style,
            ),
            SizedBox(
                width: 350,
                child: Column(children: [
                  const textformfield(
                    labelText: 'Email id',
                  ),
                  height,
                  const textformfield(
                    labelText: 'Password',
                  ),
                  Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                          onPressed: () {
                             Navigator.of(context).push(MaterialPageRoute(builder: (context){
            return ForgotPasswordScreen();
          }));
                          },
                          child: Text(
                            'Forgot Password?',
                            style: nostyle,
                          ))),
                  ElevatedButton(
                    onPressed: () {
                       Navigator.of(context).push(MaterialPageRoute(builder: (context){
            return ProfileScreen();
          }));
                    },
                    style: buttonstyle,
                    child: const Text('Sign in'),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Dont have an Account?',
                        style: nostyle,
                      ),
                      TextButton(
                          onPressed: () {
                             Navigator.of(context).push(MaterialPageRoute(builder: (context){
            return SignUpScreen();
          }));
                          },
                          child: Text(
                            'Sign Up',
                            style: TextStyle(color: Colors.orange[800]),
                          ))
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Divider(
                          color: Colors.orange[800],
                        ),
                      ),
                      Text(
                        '  or continue with  ',
                        style: nostyle,
                      ),
                      Expanded(
                          child: Divider(
                        color: Colors.orange[800],
                      ))
                    ],
                  ),
                  height20,
                  SizedBox(
                    height: 40,
                    child: Image.asset(
                        'assets/images/[removal.ai]_f9043f7d-ee3c-4038-a825-c0e8a5ede24e-kisspng-google-icon-5d4175d6037a16-4552672815645710940143.png'),
                  )
                ]))
          ],
        ),
      ),
    );
  }
}
