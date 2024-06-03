import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:socialmedia/core/colors/colors.dart';

class ShimmerList extends StatelessWidget {
  const ShimmerList({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor:kwhite,
      highlightColor:kgrey,
      child: ListView.builder(
        itemCount: 10,
        itemBuilder:(context, index) {
        return const ListTile(
          leading: CircleAvatar(radius: 30,),
          title: SizedBox(width: 100,height: 100,),
          
        );
      },),
    );
  }
}