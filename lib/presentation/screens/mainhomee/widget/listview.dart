import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialmedia/application/bloc/homepost/home_bloc.dart';
import 'package:socialmedia/application/bloc/like/like_bloc.dart';
import 'package:socialmedia/core/colors/colors.dart';
import 'package:socialmedia/core/constants.dart';
import 'package:socialmedia/core/navigator.dart';
import 'package:socialmedia/presentation/screens/mainhomee/widget/commentsheet.dart';
import 'package:socialmedia/presentation/screens/search/pages/peopledetails.dart';

class Listview extends StatelessWidget {
  const Listview({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    context.read<HomeBloc>().add(FetchHomeDetails());
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is HomeLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is HomeError) {
          return Center(
            child: Text(
              'Erroorrrr',
              style: nostyle,
            ),
          );
        } else if (state is HomeLoaded) {
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: state.posts.length,
            itemBuilder: (context, index) {
              final post = state.posts[index];
              return Container(
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(30)),
                height: 460,
                margin: const EdgeInsets.all(5),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 18.0, left: 18.0, bottom: 10.0),
                      child: GestureDetector(
                        onTap: () {
                          navigate(
                              context,
                              PeopleDetails(
                                userId: post.userId,
                                name: post.userName,
                              ));
                        },
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 20,
                              backgroundImage:
                                  post?.userprofileimageurl != null &&
                                          post!.userprofileimageurl!.isNotEmpty
                                      ? NetworkImage(post.userprofileimageurl!)
                                      : const AssetImage(
                                              'assets/images/download.png')
                                          as ImageProvider,
                            ),
                            kwidth,
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  post!.userName,
                                  style: headStyle,
                                ),
                                Text(
                                  post.postAge,
                                  style: dateStyle,
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30)),
                          height: 280,
                          child: Container(
                            width: 330,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                image: DecorationImage(
                                    image: NetworkImage(post.mediaUrl.first),
                                    fit: BoxFit.cover)),
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              BlocBuilder<LikeBloc, LikeState>(
                                builder: (context, state) {
                                  bool isLiked = post.likeStatus ?? false;
                                  int likeCount = post.likesCount ?? 0;
                                  return Row(
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            if (isLiked) {
                                              context.read<LikeBloc>().add(
                                                  UnLikedEvent(
                                                      post.postId, likeCount));
                                              post.likeStatus = false;
                                              post.likesCount = likeCount - 1;
                                            } else {
                                              context.read<LikeBloc>().add(
                                                  LikedEvent(
                                                      post.postId, likeCount));
                                              post.likeStatus = true;
                                              post.likesCount = likeCount + 1;
                                            }
                                          },
                                          icon: Icon(
                                            Icons.favorite,
                                            color: post.likeStatus == true
                                                ? Colors.red
                                                : kgrey,
                                          )),
                                      Text(
                                        '${post.likesCount}',
                                        style: nostyle,
                                      )
                                    ],
                                  );
                                },
                              ),
                              kwidth,
                              Row(
                                children: [
                                  TextButton(
                                      onPressed: () {
                                        commentsheet(context, post.postId);
                                      },
                                      child: Text(
                                        'Comments',
                                        style: nostyle,
                                      )),
                                  Text(
                                    '${post.commentsCount}',
                                    style: nostyle,
                                  )
                                ],
                              ),
                            ],
                          ),
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Text(
                                post.caption!,
                                style: nostyle,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }
        return Center(
            child: Text(
          'Server Error',
          style: nostyle,
        ));
      },
    );
  }
}
