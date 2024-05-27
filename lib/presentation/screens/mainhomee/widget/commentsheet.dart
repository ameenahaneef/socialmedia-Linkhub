import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialmedia/application/bloc/comment/comment_bloc.dart';
import 'package:socialmedia/core/colors/colors.dart';
import 'package:socialmedia/core/constants.dart';

Future<dynamic> commentsheet(BuildContext context, int postId) {
  TextEditingController commentController = TextEditingController();
  context.read<CommentBloc>().add(FetchCommentEvent(postId));
  return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
            height: 600,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30)),
              color: kgrey,
            ),
            child: Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child:
                    Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                  height20,
                  Text(
                    'Comments',
                    style: captionStyle,
                  ),
                  Expanded(
                    child: BlocBuilder<CommentBloc, CommentState>(
                      builder: (context, state) {
                        if (state is CommentLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (state is CommentError) {
                          return Center(
                            child: Text(
                              'No comments',
                              style: captionStyle,
                            ),
                          );
                        } else if (state is CommentLoaded) {
                          return ListView.builder(
                            itemBuilder: (context, index) {
                              final comment = state.comments.afterExecution
                                  .parentComments[index];
                              return ListTile(
                                leading: CircleAvatar(
                                  backgroundImage: NetworkImage(comment
                                          .UserProfileimageUrl ??
                                      'https://static-00.iconduck.com/assets.00/profile-default-icon-2048x2045-u3j7s5nj.png'),
                                ),
                                title: Row(
                                  children: [
                                    Text(
                                      comment.userName,
                                      style: captionStyle,
                                    ),
                                    kwidth,
                                    Text(
                                      comment.commentAge,
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ],
                                ),
                                subtitle: Text(comment.commentText),
                               
                              );
                              
                            },
                            itemCount: state
                                .comments.afterExecution.parentComments.length,
                          );
                        } else if (state is CommentAdded) {
                          context
                              .read<CommentBloc>()
                              .add(FetchCommentEvent(postId));
                        }
                        return Container();
                      },
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: kwhite.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: TextField(
                          controller: commentController,
                          decoration: InputDecoration(
                            hintText: 'Add a comment',
                            border: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(width: 30, color: kwhite),
                                borderRadius: BorderRadius.circular(30)),
                            prefixIcon: const Padding(
                              padding: EdgeInsets.only(left: 10.0, right: 10),
                              child: CircleAvatar(
                                radius: 20,
                              ),
                            ),
                            suffixIcon: Padding(
                              padding: const EdgeInsets.only(right: 20.0),
                              child: IconButton(
                                  onPressed: () async {
                                    context.read<CommentBloc>().add(
                                        AddCommentEvent(
                                            postId, commentController.text));
                                    commentController.clear();
                                  },
                                  icon: Icon(
                                    Icons.send,
                                    color: korange,
                                    size: 30,
                                  )),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(color: korange)),
                          ),
                        ),
                      ))
                ])));
      });
}
