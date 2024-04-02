import 'package:flutter/material.dart';
import 'package:socialmedia/core/colors/colors.dart';
import 'package:socialmedia/core/constants.dart';
import 'package:socialmedia/core/navigator.dart';
import 'package:socialmedia/presentation/mainhomee/screenmain.dart';
import 'package:socialmedia/presentation/screens/login/widget/formfield.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(backgroundColor: backgroundColor,foregroundColor: kwhite,),
      body: Padding(
        padding: const EdgeInsets.all(50.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CircleAvatar(radius:60,backgroundColor: Colors.grey.withOpacity(0.2),child: Icon(Icons.person,size: 60,color: Colors.orange[800],),),
              height,
              const textformfield(labelText: 'Name'),
              height,
              const textformfield(labelText: 'Mobile Number'),
              height,
              const textformfield(labelText: 'Date of Birth'),
              height,
              const textformfield(labelText: 'Bio'),
              height,
              const textformfield(labelText:'Gender'),
              height,
              ElevatedButton(onPressed: (){
                navigate(context,  ScreenMainPage());
              },style: buttonstyle, child: const Text('Create'),)
            ],
          ),
        ),
      ),
    );
  }
}