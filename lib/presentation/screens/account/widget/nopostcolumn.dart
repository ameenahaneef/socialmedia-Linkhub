import 'package:flutter/material.dart';
import 'package:socialmedia/core/colors/colors.dart';
import 'package:socialmedia/core/constants.dart';

class Nopost extends StatelessWidget {
  const Nopost({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                  color: kwhite, width: 2.0)),
          child: const CircleAvatar(
            backgroundColor: black,
            radius: 40,
            child: Icon(
              Icons.camera_alt,
              color: kwhite,
            ),
          ),
        ),
        Text(
          'No posts yet',
          style: captionStyle,
        )
      ],
    );
  }
}

