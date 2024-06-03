import 'package:flutter/material.dart';
import 'package:socialmedia/core/colors/colors.dart';
import 'package:socialmedia/core/constants.dart';
import 'package:socialmedia/presentation/screens/mainhomee/widget/listview.dart';

class HomeMain extends StatelessWidget {
   const HomeMain({Key? key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: black,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 25, left: 8.0, right: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'LinkHub',
                style: style,
              ),
              const Listview(),
            ],
          ),
        ),
      ),
    );
  }
}












//  height20,
            //   SizedBox(
            //     height: 140,
            //     child: ListView.builder(
            //       scrollDirection: Axis.horizontal,
            //       itemCount: 10,
            //       itemBuilder: (context, index) {
            //         if (index == 0) {
            //           return const userstatus();
            //         } else {
            //           return card();
            //         }
            //       },
            //     ),
            //   ),