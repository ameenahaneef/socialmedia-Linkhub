import 'package:flutter/material.dart';
import 'package:socialmedia/application/apiservices/apiservice.dart';
import 'package:socialmedia/core/colors/colors.dart';

class userstatus extends StatelessWidget {
  const userstatus({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 110,
        height: 140,
        child: Card(
          color: Colors.grey.withOpacity(0.4),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: const BorderSide(color: kwhite)),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: 110,
              height: 40,
              decoration: BoxDecoration(
                  color: korange, borderRadius: BorderRadius.circular(10)),
              child: IconButton(
                onPressed: () async {
                  await SignupService().fetchUser();
                },
                icon: const Icon(Icons.add),
                color: Colors.black,
              ),
            ),
          ),
        ));
  }
}
