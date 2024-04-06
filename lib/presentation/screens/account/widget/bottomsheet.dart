import 'package:flutter/material.dart';
import 'package:socialmedia/application/sharedpreference/sharedpreference.dart';
import 'package:socialmedia/core/colors/colors.dart';
import 'package:socialmedia/core/navigator.dart';
import 'package:socialmedia/presentation/screens/login/login.dart';

Future<dynamic> bottomsheet(BuildContext context) {
  return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          width: double.infinity,
          decoration: const BoxDecoration(
              color: kgrey,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                  onPressed: () async {
                    await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Logout'),
                            content:
                                const Text('Are you sure you want to logout?'),
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
                                    // Navigator.pop(context);

                                    navigate(context, LoginScreen());
                                  },
                                  child: const Text('Logout'))
                            ],
                          );
                        });
                  },
                  icon: const Icon(Icons.logout, color: backgroundColor))
            ],
          ),
        );
      });
}
