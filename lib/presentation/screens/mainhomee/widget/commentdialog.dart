import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialmedia/application/bloc/comment/comment_bloc.dart';
import 'package:socialmedia/application/bloc/homepost/home_bloc.dart';
import 'package:socialmedia/application/models/commentmodel.dart';
import 'package:socialmedia/core/colors/colors.dart';

Future<dynamic> commentdialog(BuildContext context,
    TextEditingController editController, ParentComment comment, int postId) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: editController,
              style: const TextStyle(color: black),
              decoration: const InputDecoration(),
            ),
            TextButton(
                onPressed: () {
                  context.read<CommentBloc>().add(
                      EditCommentEvent(comment.commentId, editController.text));
                  context.read<CommentBloc>().add(FetchCommentEvent(postId));
                  context.read<HomeBloc>().add(FetchHomeDetails());
                  Navigator.pop(context);
                },
                child: const Text(
                  'Save',
                  style: TextStyle(color: black),
                ))
          ],
        ),
      );
    },
  );
}
