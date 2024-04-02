  import 'package:flutter/material.dart';
import 'package:socialmedia/core/colors/colors.dart';

GestureDetector card() {
    return GestureDetector(
      child:  Container(
        width: 110,
        height: 140,
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/images/[removal.ai]_4eefa410-d30a-47d3-8050-8050591fe0f3-54158.png'))
        ),
        child: Card(
          color: Colors.white.withOpacity(0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(
              color: kwhite
            )
          ),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: 110,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.orange[800],
                borderRadius: BorderRadius.circular(10)
              ),
            ),
          ),
        ),
      ),
    );
  }
