import 'package:flutter/material.dart';
import 'package:socialmedia/core/colors/colors.dart';
import 'package:socialmedia/core/constants.dart';

class AddPostWidget extends StatelessWidget {
  const AddPostWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: Padding(
          padding: const EdgeInsets.all(50.0),
          child: Column(
            children: [
              Text(
                'Add your post here',
                style: nostyle,
              ),
              Container(
                decoration: BoxDecoration(
                    color: kgrey.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(30)),
                width: 300,
                height: 420,
                child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.upload,
                      color: kwhite,
                      size: 50,
                    )),
              ),
              height20,
            ],
          ),
        ),
      ),
    );
  }
}
