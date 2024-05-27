import 'package:flutter/material.dart';
import 'package:socialmedia/application/models/profilemodel.dart';
import 'package:socialmedia/core/colors/colors.dart';
import 'package:socialmedia/core/constants.dart';
import 'package:socialmedia/core/navigator.dart';
import 'package:socialmedia/presentation/screens/profilesetting/pages/profilesetting.dart';

class Secondwidget extends StatelessWidget {
  final ProfileModel profileModel;
  const Secondwidget({
    super.key,
    required this.profileModel
  });

  @override
  Widget build(BuildContext context) {
     final afterExecution = profileModel.afterExecution;

    if (afterExecution == null) {
      return Center(child: Text('Profile data is not available', style: nostyle));
    }
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
        Column(
          children: [
            Text(
              profileModel.afterExecution!.name,
              style: nostyle,
            ),
            Text(
              profileModel.afterExecution!
                  .username,
              style: nostyle,
            ),
          ],
        ),
        kwidth45,
        ElevatedButton(
          onPressed: () {
            if(profileModel.afterExecution!=null){}
            navigate(context, ProfileSetting(name: profileModel.afterExecution!.name, username: profileModel.afterExecution!.username, bio: profileModel.afterExecution!.bio, links: profileModel.afterExecution!.links,image: profileModel.afterExecution!.userprofileimageurl,));
          },
          style: ElevatedButton.styleFrom(
              backgroundColor:korange),
          child: Text(
            'Edit profile',
            style: nostyle,
          ),
        ),
      ]),
    );
  }
}
