
import 'package:flutter/material.dart';
import 'package:socialmedia/application/models/chatmodel.dart';
import 'package:socialmedia/core/colors/colors.dart';
import 'package:socialmedia/core/constants.dart';
import 'package:socialmedia/presentation/screens/messages/pages/singlechat.dart';

class Columnmessage extends StatelessWidget {
  const Columnmessage({
    super.key,
    required this.showDate,
    required this.formattedDate,
    required this.widget,
    required this.chat,
    required this.formattedTime,
  });

  final bool showDate;
  final String formattedDate;
  final SingleChat widget;
  final ChatMessage chat;
  final String formattedTime;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (showDate)
          Text(
            formattedDate,
            style: const TextStyle(
              color:kwhite,
            ),
          ),
        Align(
          alignment: widget.id != chat.senderId
              ? Alignment.centerRight
              : Alignment.centerLeft,
          child: Padding(
            padding:
                const EdgeInsets.only(left: 18.0, right: 18),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: widget.id != chat.senderId
                    ? orange.withOpacity(0.7)
                    : kgrey,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(25),
                  topRight: const Radius.circular(25),
                  bottomLeft: widget.id != chat.senderId
                      ? const Radius.circular(25)
                      : Radius.zero,
                  bottomRight: widget.id != chat.senderId
                      ? Radius.zero
                      : const Radius.circular(25),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: Text(
                      chat.content ?? '',
                      style: TextStyle(
                          color: widget.id!=chat.senderId
                              ? kwhite
                              : black),
                    ),
                  ),
                  kwidth,
                  Text(
                    formattedTime,
                    style: TextStyle(
                        color: black.withOpacity(0.6),fontSize: 10 ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

