import 'package:flutter/material.dart';
import 'package:socialmedia/core/colors/colors.dart';
import 'package:socialmedia/core/constants.dart';

class Listview extends StatelessWidget {
  const Listview({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 176,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 10,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 4.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(20),
                    color:
                        kgreyO),
                width: 100,
                height: 100,
                child: Column(
                  children: [
                    const Align(
                        alignment: Alignment.topCenter,
                        child: Image(
                            image: AssetImage(
                                'assets/images/[removal.ai]_da4a22d4-3aa7-4812-ac4e-aead220b7375-screenshot-2024-03-26-192518.png'))),
                    Text(
                      'Name',
                      style: stylet,
                    ),
                    TextButton(
                        onPressed: () {},
                        child: Text(
                          'Follow',
                          style: TextStyle(
                              color:
                                 korange),
                        ))
                  ],
                ),
              ),
            );
          }),
    );
  }
}
