import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:socialmedia/core/colors/colors.dart';

class otpwidgettextform extends StatelessWidget {
  final TextEditingController controller;
  const otpwidgettextform({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 68,
      width: 64,
      child: TextFormField(
        controller: controller,
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          }
        },
        onSaved: (newValue) {},
        decoration: const InputDecoration(
            hintText: '0',
            border: OutlineInputBorder(),
            focusedBorder:
                OutlineInputBorder(borderSide: BorderSide(color: kwhite))),
        style: const TextStyle(color: kwhite),
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly,
        ],
        cursorColor: kwhite,
      ),
    );
  }
}



