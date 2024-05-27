import 'package:flutter/material.dart';
import 'package:socialmedia/core/colors/colors.dart';
import 'package:socialmedia/core/constants.dart';
Future<dynamic> dialogbox(BuildContext context) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: kgrey.withOpacity(0.9),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: Row(
          children: [
            Icon(Icons.check_circle, color: korange),
            const SizedBox(width: 10),
            Text(
              'Done',
              style: TextStyle(color: korange),
            ),
          ],
        ),
        content: Text('Your profile has been updated successfully!',
            style: captionStyle),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
             
          },
            child: Text('OK', style: TextStyle(color: korange)),
          ),
        ],
      );
    },
  );
}
