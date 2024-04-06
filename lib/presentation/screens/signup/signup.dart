import 'package:flutter/material.dart';
import 'package:socialmedia/application/apiservices/apiservice.dart';
import 'package:socialmedia/application/models/usermodel.dart';
import 'package:socialmedia/core/colors/colors.dart';
import 'package:socialmedia/core/constants.dart';
import 'package:socialmedia/presentation/screens/login/widget/formfield.dart';
import 'package:socialmedia/presentation/screens/otp/otpscreen.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});
  final TextEditingController nameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        foregroundColor: kwhite,
      ),
      backgroundColor: backgroundColor,
      body: Center(
          child: Column(children: [
        Image.asset(
          'assets/images/[removal.ai]_b1934004-b13d-49d0-8db5-f8d0882759c9-screenshot-2024-03-30-221955.png',
          scale: 4,
        ),
        Text(
          'Sign Up',
          style: style,
        ),
        Expanded(
          child: Container(
            width: 370,
            decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.2),
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30))),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CustomTextformField(
                          labelText: 'name', controller: nameController),
                      height,
                      CustomTextformField(
                        labelText: 'Username',
                        controller: usernameController,
                      ),
                      height,
                      CustomTextformField(
                        labelText: 'Email id',
                        controller: emailController,
                      ),
                      height,
                      CustomTextformField(
                        labelText: 'Password',
                        controller: passwordController,
                      ),
                      height,
                      CustomTextformField(
                          labelText: 'confirm password',
                          controller: confirmPasswordController),
                      height,
                      ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            if (passwordController.text !=
                                confirmPasswordController.text) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: const Text('Passwords do not match'),
                                backgroundColor: korange,
                              ));
                              return;
                            }
                            String token = await SignupService().createUser(
                                UserModel(
                                    name: nameController.text,
                                    userName: usernameController.text,
                                    emailid: emailController.text,
                                    password: passwordController.text,
                                    confirmPassword:
                                        confirmPasswordController.text));

                            if (token.isNotEmpty) {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) {
                                return OtpScreen(
                                  token: token,
                                );
                              }));
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: const Text(
                                  'Email already exists.please use another one',
                                ),
                                backgroundColor: korange,
                              ));
                            }
                          }
                        },
                        style: buttonstyle,
                        child: const Text('Create Account'),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        )
      ])),
    );
  }
}
