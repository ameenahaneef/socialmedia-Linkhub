import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialmedia/application/bloc/editprofilebloc/editprofilebloc_bloc.dart';
import 'package:socialmedia/core/colors/colors.dart';
import 'package:socialmedia/core/constants.dart';
import 'package:socialmedia/presentation/screens/profilesetting/widget/buttongesture.dart';
import 'package:socialmedia/presentation/screens/profilesetting/widget/protextfield.dart';
class ProfileSetting extends StatelessWidget {
  final String name;
  final String username;
  final String bio;
  final String links;
  final String image;
  ProfileSetting(
      {super.key,
      required this.name,
      required this.username,
      required this.bio,
      required this.links,
      required this.image
      });
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _usernameContr = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _linksController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    _nameController.text = name;
    _usernameContr.text = username;
    _bioController.text = bio;
    _linksController.text = links;
    return Scaffold(
      backgroundColor: black,
      appBar: AppBar(
        backgroundColor: black,
        foregroundColor: kwhite,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 30, right: 30),
        child: SingleChildScrollView(
          child: Column(
            children: [
              
              Text('Edit your Details here',style: captionStyle,),
              height30,
              BlocBuilder<EditprofileblocBloc, EditprofileblocState>(
                  builder: (context, state) {
                return Container(
                  decoration: BoxDecoration(color: korange.withOpacity(0.3),borderRadius: BorderRadius.circular(30)),
                  width: 400,
                  height: 400,
                  //color: kgrey,
                  child: Padding(
                    padding: const EdgeInsets.only(top:40.0,left: 20,right: 20),
                    child: Column(
                      children: [
                        editfield('Name', _nameController),
                        height20,
                        editfield('Username', _usernameContr),
                        height20,
                        editfield('Bio', _bioController),
                        height20,
                        // editfield('Links', _linksController),
                        // height20,
                        Gesturebutton(
                            nameController: _nameController,
                            usernameContr: _usernameContr,
                            bioController: _bioController,
                            linksController: _linksController,
                            ),   
                                                 
                      ],
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
