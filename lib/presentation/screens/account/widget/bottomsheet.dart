import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:socialmedia/application/sharedpreference/sharedpreference.dart';
import 'package:socialmedia/core/colors/colors.dart';
import 'package:socialmedia/core/constants.dart';
import 'package:socialmedia/core/navigator.dart';
import 'package:socialmedia/presentation/screens/login/pages/login.dart';
import 'package:socialmedia/presentation/screens/settings/about.dart';
import 'package:socialmedia/presentation/screens/settings/privacypolicy.dart';

Future<dynamic> bottomsheet(BuildContext context) {
  return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
         // width: double.infinity,
          height: 350,
          decoration: BoxDecoration(
             

              color: black.withOpacity(0.8),
              
                  ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                ListTile(
                  onTap: () {
                    navigate(context, const About());
                  },
                  leading: const Icon(Icons.info_outline,color: kwhite,),
                  title:  Text('About',style: nostyle,),
                ),
                ListTile(
                  onTap: () {
                    navigate(context, const PrivacyPolicy());
                  },
                  leading: const Icon(Icons.privacy_tip,color: kwhite),
                  title:  Text('Privacy Policy',style: nostyle,),
                ),
                ListTile(
                  onTap: () {
                    Share.share('text');
                  },
                  leading: const Icon(Icons.share,color:kwhite,),
                  title:  Text('Share',style: nostyle,),
                ),
                ListTile(
                 
                      onTap: () async {
                        await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Logout'),
                                content: const Text(
                                    'Are you sure you want to logout?'),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text('cancel')),
                                  TextButton(
                                      onPressed: () async {
                                        await SharedPreferenceService
                                            .deleteLoginStatus();
                                        navigate(context, LoginScreen());
                                      },
                                      child: const Text('Logout'))
                                ],
                              );
                            });
                      },
                      leading: const Icon(Icons.logout,color: kwhite,),
                      title: Text('Logout',style: nostyle,),
                      ),
                
              
           ] ),
          ),
        );
      });
}
