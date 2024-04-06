import 'package:flutter/material.dart';
import 'package:socialmedia/core/colors/colors.dart';
import 'package:socialmedia/core/constants.dart';

GestureDetector card() {
  return GestureDetector(
    child: Container(
      width: 110,
      height: 140,
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                  'assets/images/[removal.ai]_4eefa410-d30a-47d3-8050-8050591fe0f3-54158.png'),
              fit: BoxFit.cover)),
      child: Card(
        color: Colors.white.withOpacity(0),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: const BorderSide(color: kwhite)),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: 110,
                height: 40,
                decoration: BoxDecoration(
                    color: korange, borderRadius: BorderRadius.circular(10)),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    const ClipOval(
                      child: Image(
                        image: AssetImage(
                          'assets/images/young-lady-with-deep-green-eyes-long-brown-hair.jpg',
                        ),
                        fit: BoxFit.cover,
                        width: 36,
                        height: 38,
                      ),
                    ),
                    Text(
                      'Ameena',
                      style: nostyle,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    ),
  );
}
