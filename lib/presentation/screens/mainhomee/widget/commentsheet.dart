import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialmedia/application/bloc/comment/comment_bloc.dart';
import 'package:socialmedia/application/bloc/homepost/home_bloc.dart';
import 'package:socialmedia/application/sharedpreference/sharedpreference.dart';
import 'package:socialmedia/core/colors/colors.dart';
import 'package:socialmedia/core/constants.dart';
import 'package:socialmedia/presentation/screens/mainhomee/widget/commentdialog.dart';

Future<dynamic> commentsheet(BuildContext context, int postId) async {
  final userId = await SharedPreferenceService.getUserId();
  TextEditingController commentController = TextEditingController();
  context.read<CommentBloc>().add(FetchCommentEvent(postId));
  return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
            height: 600,
            decoration: BoxDecoration(
              color: black.withOpacity(0.3),
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30)),
            ),
            child: Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child:
                    Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                  height20,
                  Text(
                    'Comments',
                    style: blackStyle,
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
                              style: blackStyle,
                            ),
                          );
                        } else if (state is CommentLoaded) {
                          return ListView.builder(
                            itemBuilder: (context, index) {
                              final comment = state.comments.afterExecution
                                  .parentComments[index];
                              return ListTile(
                                  leading: CircleAvatar(
                                    radius: 25,
                                    backgroundImage: NetworkImage(comment
                                            .UserProfileimageUrl ??
                                        'https://static-00.iconduck.com/assets.00/profile-default-icon-2048x2045-u3j7s5nj.png'),
                                  ),
                                  title: Row(
                                    children: [
                                      Text(
                                        comment.userName,
                                        style: blackheadStyle,
                                      ),
                                      kwidth,
                                      Text(
                                        comment.commentAge,
                                        style: blackdateStyle,
                                      ),
                                    ],
                                  ),
                                  subtitle: Text(comment.commentText),
                                  trailing: userId == comment.userId
                                      ? PopupMenuButton<String>(
                                          onSelected: (String choice) {
                                            if (choice == 'Edit') {
                                              final editController =
                                                  TextEditingController(
                                                      text:
                                                          comment.commentText);

                                              commentdialog(
                                                  context,
                                                  editController,
                                                  comment,
                                                  postId);
                                            } else if (choice == 'Delete') {
                                              context.read<CommentBloc>().add(
                                                  DeleteComments(
                                                      comment.commentId));
                                              context.read<CommentBloc>().add(
                                                  FetchCommentEvent(postId));
                                              context
                                                  .read<HomeBloc>()
                                                  .add(FetchHomeDetails());
                                              context
                                                  .read<HomeBloc>()
                                                  .add(FetchHomeDetails());
                                            }
                                          },
                                          itemBuilder: (BuildContext context) =>
                                              <PopupMenuEntry<String>>[
                                                const PopupMenuItem<String>(
                                                    value: 'Edit',
                                                    child: Text('Edit')),
                                                const PopupMenuItem<String>(
                                                    value: 'Delete',
                                                    child: Text('Delete'))
                                              ])
                                      : null

                                  //  Row(
                                  //     mainAxisSize: MainAxisSize.min,
                                  //     children: [
                                  //       IconButton(
                                  //           onPressed: () {
                                  //             final editController =
                                  //                 TextEditingController(
                                  //                     text: comment
                                  //                         .commentText);

                                  //             commentdialog(context, editController, comment, postId);
                                  //           },
                                  //           icon: const Icon(Icons.edit)),
                                  //       IconButton(
                                  //           onPressed: () {
                                  //             context
                                  //                 .read<CommentBloc>()
                                  //                 .add(DeleteComments(
                                  //                     comment.commentId));
                                  //             context
                                  //                 .read<CommentBloc>()
                                  //                 .add(FetchCommentEvent(
                                  //                     postId));
                                  //             context
                                  //                 .read<HomeBloc>()
                                  //                 .add(FetchHomeDetails());
                                  //           },
                                  //           icon: const Icon(Icons.delete))
                                  //     ],
                                  //   )
                                  // : null
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
                            suffixIcon: Padding(
                              padding: const EdgeInsets.only(right: 20.0),
                              child: IconButton(
                                  onPressed: () async {
                                    context.read<CommentBloc>().add(
                                        AddCommentEvent(
                                            postId, commentController.text));
                                    context
                                        .read<HomeBloc>()
                                        .add(FetchHomeDetails());

                                    commentController.clear();
                                  },
                                  icon: const Icon(
                                    Icons.send,
                                    color: black,
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
