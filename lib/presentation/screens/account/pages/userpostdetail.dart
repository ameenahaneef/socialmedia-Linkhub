import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialmedia/application/bloc/post/post_bloc.dart';
import 'package:socialmedia/application/models/fetchpostmodel.dart';
import 'package:socialmedia/core/colors/colors.dart';
import 'package:socialmedia/core/constants.dart';

class UserPostDetails extends StatelessWidget {
  final After post;
  const UserPostDetails({super.key, required this.post});
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: black,
      appBar: AppBar(
        backgroundColor: black,
        foregroundColor: kwhite,
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
height: 430,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: kgrey.withOpacity(0.3)),
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.only(top:8.0,left: 30),
                  child: ListTile(
                      // leading: CircleAvatar(
                      //   backgroundImage:
                      //       NetworkImage(post.userprofileimageurl??'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQttE9sxpEu1EoZgU2lUF_HtygNLCaz2rZYHg&s'),
                      // ),
                      title: Text(
                        post.username!,
                        style: headStyle,
                      ),
                      trailing: IconButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text('Delete Confirmation'),
                                  content: const Text(
                                      'Are you sure you want to delete?'),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text('Cancel')),
                                    TextButton(
                                        onPressed: () {
                                          context.read<PostBloc>().add(
                                              DeletePostEvent(
                                                  '${post.postid}'));
                                           Navigator.pop(context);

                                           Navigator.pop(context);
                                        },
                                        child: const Text('ok'))
                                  ],
                                );
                              },
                            );
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: kwhite,
                          ))),
                ),
                CarouselSlider(
                    items: post.mediaUrls!.map((url) {
                      return Container(
                        margin: const EdgeInsets.all(5.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(
                            url,
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    }).toList(),
                    options: CarouselOptions(
                        height: 350, enableInfiniteScroll: false)),
              ])),
          height20,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              BlocBuilder<PostBloc, PostState>(builder: (context, state) {
                if (state is CaptionEditSuccessState) {
                  return Text(
                    state.newCaption,
                    style: captionStyle,
                  );
                } else {
                  return Text(
                    post.caption!,
                    style: captionStyle,
                  );
                }
              }),
              post.caption != null && post.caption!.isNotEmpty
                  ? IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            TextEditingController editController =
                                TextEditingController(text: post.caption);
                            return AlertDialog(
                              title: const Text('edit caption'),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextField(
                                    controller: editController,
                                  ),
                                ],
                              ),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('cancel')),
                                TextButton(
                                    onPressed: () {
                                      String newCaption =
                                          editController.text.trim();
                                      context.read<PostBloc>().add(
                                          EditCaptionEvent(
                                              postId: post.postid.toString(),
                                              newCaption: newCaption));
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                        content: Text('edited successfully'),
                                        backgroundColor: green,
                                      ));
                                      Navigator.pop(context);
                                    },
                                    child: const Text('save changes'))
                              ],
                            );
                          },
                        );
                      },
                      icon: const Icon(
                        Icons.edit,
                        color: kwhite,
                      ),
                    )
                  : const SizedBox(),
            ],
          )
        ]),
      ),
    );
  }
}
