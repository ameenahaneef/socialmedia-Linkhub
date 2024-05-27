import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:socialmedia/core/colors/colors.dart';
import 'package:socialmedia/core/constants.dart';

class SingleChat extends StatelessWidget {
  const SingleChat({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: black,
        appBar: AppBar(
          backgroundColor: black,
          foregroundColor: kwhite,
          title: Row(
            children: [
              CircleAvatar(
                radius: 25,
              ),
              kwidth,
              Text(
                'Ameena',
                style: nostyle,
              )
            ],
          ),
        ),
        body: Column(
          children: [
            height20,
            Expanded(
              child: ListView.separated(
                separatorBuilder: (context, index) {
                  return SizedBox(
                    height: 15,
                  );
                },
                itemCount: 10,
                itemBuilder: (context, index) {
                  bool isUserMessage = index % 2 == 0;
                  return Align(
                    alignment: isUserMessage
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: isUserMessage ? Colors.blue[50] : kgrey,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25),
                              topRight: Radius.circular(25),
                              bottomLeft: isUserMessage
                                  ? Radius.circular(25)
                                  : Radius.zero,
                              bottomRight: isUserMessage
                                  ? Radius.zero
                                  : Radius.circular(25))),
                                  child: Text('bbbbbbbbbb'),
                    ),
                  );
                },
              ),
            ),
            TextField(
              cursorColor: kwhite,
              style: nostyle,
              decoration: InputDecoration(
                 focusedBorder:OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: kwhite)
                 ),
                 
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30)),
                  suffixIcon: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.send,
                        color: kwhite,
                      ))),
            )
          ],
        ));
  }
}
