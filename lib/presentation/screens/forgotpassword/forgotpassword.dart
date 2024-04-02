import 'package:flutter/material.dart';
import 'package:socialmedia/core/colors/colors.dart';
import 'package:socialmedia/core/constants.dart';
import 'package:socialmedia/presentation/screens/login/login.dart';
import 'package:socialmedia/presentation/screens/login/widget/formfield.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(backgroundColor:backgroundColor ,foregroundColor: kwhite,),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SizedBox(
          height: 250,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Enter your Email id',style: nostyle,),
              const textformfield(labelText: 'Please enter your Email id'),
              Center(child: ElevatedButton(onPressed: (){},style: buttonstyle, child: const Text('Submit'),)),
              Align(
                child: TextButton(onPressed: (){
                   Navigator.of(context).push(MaterialPageRoute(builder: (context){
            return LoginScreen();
          }));
                }, child: Text('Back to Login',style: nostyle,)))
            ],
          ),
        ),
      ),
    );
  }
  
}