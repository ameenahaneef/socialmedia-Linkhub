import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:socialmedia/application/apiservices/authenticationservice.dart';
import 'package:socialmedia/core/constants.dart';
import 'package:socialmedia/core/navigator.dart';
import 'package:socialmedia/presentation/screens/mainhomee/pages/screenmain.dart';
import 'package:socialmedia/presentation/screens/forgotpassword/pages/forgotpassword.dart';
import 'package:socialmedia/presentation/screens/login/widget/formfield.dart';
import 'package:socialmedia/presentation/screens/signup/pages/signup.dart';

class LoginScreen extends StatelessWidget {
  final GoogleSignIn _googleSignIn=GoogleSignIn(clientId: 'http://911150474747-16l271tmjuihvbjee1jn80skms874su5.apps.googleusercontent.com',
  scopes: [
    'email',
    'profile'
  ]);
  LoginScreen({super.key});
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

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
                child: Form(
                  key: _formKey,
                  child: Column(children: [
                    CustomTextformField(
                      labelText: 'Email id',
                      controller: emailController,
                    ),
                    height,
                    CustomTextformField(
                      labelText: 'Password',
                      controller: passwordController,
                    ),
                    Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) {
                                return ForgotPasswordScreen();
                              }));
                            },
                            child: Text(
                              'Forgot Password?',
                              style: nostyle,
                            ))),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          bool loginSuccess = await SignupService().login(
                              emailController.text, passwordController.text);
                          if (loginSuccess) {
                            navigate(context, ScreenMainPage());
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        'Login Failed,Please check your credentials or create an account')));
                          }
                        }
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
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) {
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
                          '  welcomee  ',
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
                      // child: GestureDetector(
                      //   onTap: ()async {
                      //    try {
                      //      final GoogleSignInAccount? googleUser=await _googleSignIn.signIn();
                      //      if(googleUser!=null){
                      //       final String email=googleUser.email;
                      //       final String idToken=googleUser.id;
                      //       print('signed in with $email');
                      //       print('id token is $idToken');

                      //      }else{
                      //       print('sign in failed');
                      //      }
                      //    }on PlatformException 
                         
                      //     catch (e) {
                      //      print('platformexception during .......${e.message}');
                      //    }
                      //   },
                      //   child: Image.asset(
                      //       'assets/images/[removal.ai]_f9043f7d-ee3c-4038-a825-c0e8a5ede24e-kisspng-google-icon-5d4175d6037a16-4552672815645710940143.png'),
                      // ),
                    )
                  ]),
                ))
          ],
        ),
      ),
    );

    
  }
 
}
