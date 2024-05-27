import 'package:flutter/material.dart';

void navigate(BuildContext context, Widget screen) {
  Navigator.of(context).push(MaterialPageRoute(builder: (context) {
    return screen;
  }));
}

void navigatePop(BuildContext context) {
  Navigator.pop(context);
}





