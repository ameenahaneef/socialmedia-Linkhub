import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:socialmedia/application/models/profilemodel.dart';
import 'package:socialmedia/core/colors/colors.dart';
import 'package:socialmedia/core/constants.dart';
import 'package:socialmedia/core/navigator.dart';
import 'package:socialmedia/presentation/screens/profilesetting/pages/profilesetting.dart';

class Secondwidget extends StatelessWidget {
  final ProfileModel profileModel;
  const Secondwidget({super.key, required this.profileModel});

  @override
  Widget build(BuildContext context) {
    final afterExecution = profileModel.afterExecution;

    if (afterExecution == null) {
      return Center(
          child: Text('Profile data is not available', style: nostyle));
    }
    return Align(
      alignment: Alignment.bottomLeft,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                profileModel.afterExecution!.name,
                style: captionStyle,
              ),
              Text(
                profileModel.afterExecution!.username,
                style: nostyle,
              ),
              Text(
                profileModel.afterExecution!.bio,
                style: nostyle,
                maxLines: 2,
                
              ),
              height,
              ElevatedButton(
                onPressed: () {
                  if (profileModel.afterExecution != null) {}
                  navigate(
                      context,
                      ProfileSetting(
                        name: profileModel.afterExecution!.name,
                        username: profileModel.afterExecution!.username,
                        bio: profileModel.afterExecution!.bio,
                        links: profileModel.afterExecution!.links,
                        image: profileModel.afterExecution!.userprofileimageurl,
                      ));
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    side: const BorderSide(color: kwhite),
                    shape:BeveledRectangleBorder()),
                child: Text(
                  'Edit profile',
                  style: nostyle,
                ),
              ),
            ]),
      ),
    );
  }
}
