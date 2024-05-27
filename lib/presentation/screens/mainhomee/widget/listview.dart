import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialmedia/application/bloc/homepost/home_bloc.dart';
import 'package:socialmedia/application/bloc/like/like_bloc.dart';
import 'package:socialmedia/core/colors/colors.dart';
import 'package:socialmedia/core/constants.dart';
import 'package:socialmedia/core/navigator.dart';
import 'package:socialmedia/presentation/screens/mainhomee/widget/commentsheet.dart';
import 'package:socialmedia/presentation/screens/search/pages/peopledetails.dart';

class listview extends StatelessWidget {
  const listview({
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
                    color: Colors.grey.withOpacity(0.4),
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
                              context, PeopleDetails(userId: post.userId));
                        },
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 20,
                              backgroundColor: korange,
                              backgroundImage: NetworkImage(post!
                                      .userprofileimageurl ??
                                  'https://static-00.iconduck.com/assets.00/profile-default-icon-2048x2045-u3j7s5nj.png'),
                            ),
                            kwidth,
                            Column(
                              children: [
                                Text(
                                  post.userName,
                                  style: nostyle,
                                ),
                                Text(
                                  post.postAge,
                                  style: nostyle,
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
                                image: DecorationImage(image: NetworkImage(post.mediaUrl.first),fit: BoxFit.cover)
                                ),
                            
                            // child: Image(
                            //   image: NetworkImage(post.mediaUrl.first),
                            //   fit: BoxFit.cover,
                            // ),
                          )),
                    ),
                    Padding(
                      padding: EdgeInsets.all(18.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              BlocBuilder<LikeBloc, LikeState>(
                                builder: (context, state) {
                                  bool isLiked=post.likeStatus??false;
                                  int likeCount=post.likesCount??0;
                                  return Row(
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            if(isLiked){
                                              context.read<LikeBloc>().add(UnLikedEvent(post.postId, likeCount));
                                              post.likeStatus=false;
                                              post.likesCount=likeCount-1;
                                              
                                            }else{
                                              context.read<LikeBloc>().add(LikedEvent(post.postId, likeCount));
                                              post.likeStatus=true;
                                              post.likesCount=likeCount+1;
                                            }
                                          },
                                          icon: Icon(
                                            Icons.favorite,
                                            color:post.likeStatus==true?korange:kgrey,
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
                          Text(
                            post.caption!,
                            style: nostyle,
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
            child: Container(
          width: 100,
          height: 100,
          color: kgrey,
        ));
      },
    );
  }
}
