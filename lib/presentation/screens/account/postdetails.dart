import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialmedia/application/bloc/post/post_bloc.dart';
import 'package:socialmedia/application/models/fetchpostmodel.dart';
import 'package:socialmedia/core/colors/colors.dart';
import 'package:socialmedia/core/constants.dart';

class PostDetails extends StatelessWidget {
  final AfterExecution post;
  const PostDetails({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          backgroundColor: backgroundColor,
          foregroundColor: kwhite,
        ),
        body: Column(children: [
          Container(
              width: double.infinity,
              height: 450,
              color: kwhite.withOpacity(.8),
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                      leading: CircleAvatar(),
                      title: Text('Ameena'),
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
                            color: Colors.black,
                          ))),
                ),
                CarouselSlider(
                    items: post.mediaUrls!.map((url) {
                      return Container(
                        margin: const EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Image.network(
                          url,
                          fit: BoxFit.cover,
                        ),
                      );
                    }).toList(),
                    options: CarouselOptions(
                        height: 350, enableInfiniteScroll: false)),
              ])),
          height20,
          Text(
            post.caption!,
            style: captionStyle,
          )
        ]));
  }
}
