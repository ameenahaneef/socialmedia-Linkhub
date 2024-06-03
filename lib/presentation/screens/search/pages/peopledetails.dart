import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialmedia/application/apiservices/postservice.dart';
import 'package:socialmedia/application/bloc/follow/follow_bloc.dart';
import 'package:socialmedia/application/bloc/search/search_bloc.dart';
import 'package:socialmedia/application/bloc/userpost/userpost_bloc.dart';
import 'package:socialmedia/core/colors/colors.dart';
import 'package:socialmedia/core/constants.dart';
import 'package:socialmedia/core/navigator.dart';
import 'package:socialmedia/presentation/screens/messages/pages/singlechat.dart';
class PeopleDetails extends StatelessWidget {
  final int userId;
  final String name;
  const PeopleDetails({super.key, required this.userId, required this.name});
  @override
  Widget build(BuildContext context) {
    context.read<SearchBloc>().add(FetchPeopleProfile(userId));
    context.read<UserpostBloc>().add(UserFetchPostEvent(userId));
    return Scaffold(
      backgroundColor: black,
      appBar: AppBar(
        backgroundColor: black,
        foregroundColor: kwhite,
        title: Text(name),
       
      ),
      body: BlocBuilder<SearchBloc, SearchState>(builder: (context, state) {
        if (state is PeopleProfileLoaded) {
          final profile = state.profile;
          final imageUrl = profile!.userprofileimageurl?.isNotEmpty == true
              ? profile.userprofileimageurl
              : 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQttE9sxpEu1EoZgU2lUF_HtygNLCaz2rZYHg&ssal';
          return Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 10),
            child: Column(
              children: [
                Container(
                  color: black,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Column(
                            //mainAxisAlignment: MainAxisAlignment.start,
                            //crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                radius: 60,
                                backgroundImage: NetworkImage(imageUrl!),
                                backgroundColor: korange,
                              ),
                              // Text(
                              //   profile.name,
                              //   style: nostyle,
                              // ),
                              // Text(
                              //   profile.username,
                              //   style: nostyle,
                              // ),
                            ],
                          ),
                       
                          Row(
                            children: [
                              TextButton(
                                  onPressed: () {
                                    PostApiService()
                                        .getUserPost(userId: userId);
                                  },
                                  child: Text(
                                    'posts\n${profile.postcount}',
                                    style: nostyle,
                                  )),
                              TextButton(
                                  onPressed: () {
                                  },
                                  child: Text(
                                    'Following\n${profile.followingcount}',
                                    style: nostyle,
                                  )),
                              TextButton(
                                  onPressed: () {
                                  },
                                  child: Text(
                                    'Followers\n${profile.followerscount}',
                                    style: nostyle,
                                  )),
                            ],
                          ),
                        ],
                      ),
                      height,
                      
                      SizedBox(
                          width: double.infinity,
                          child: BlocBuilder<FollowBloc, FollowState>(
                            builder: (context, state) {
                              return Row(
                                children: [
                                  Expanded(
                                    child: ElevatedButton(
                                        onPressed: () {
                                          if (profile.followingstatus == true) {
                                            context.read<FollowBloc>().add(
                                                UnfollowUser(profile.userid));
                                            profile.followingstatus = false;
                                            profile.followerscount -= 1;
                                          } else {
                                            context.read<FollowBloc>().add(
                                                FollowUser(profile.userid));
                                            profile.followingstatus = true;
                                            profile.followingcount += 1;
                                          }
                                        },
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                profile.followingstatus == true
                                                    ? kgrey
                                                    : korange),
                                        child: Text(
                                          profile.followingstatus == true
                                              ? 'Following'
                                              : 'Follow',
                                          style: nostyle,
                                        )),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: () {
                                        navigate(context, SingleChat(id: profile.userid.toString(),userName: profile.username,userProfileUrl: profile.userprofileimageurl,));
                                      },
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: kgrey),
                                      child: Text(
                                        'Message',
                                        style: nostyle,
                                      ),
                                    ),
                                  )
                                ],
                              );
                            },
                          ))
                    ],
                  ),
                ),
                height20,
                Expanded(
                  child: BlocBuilder<UserpostBloc, UserpostState>(
                    builder: (context, state) {
                      if (state is UserPostFetchProgress) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is UserPostFetchSuccess) {
                        return GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  mainAxisSpacing: 3,
                                  crossAxisSpacing: 3),
                          itemCount: state.userposts.length,
                          itemBuilder: (context, index) {
                            final post = state.userposts[index];
                            return Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: kgrey),
                              child: Image.network(
                                post.mediaUrls!.first,
                                fit: BoxFit.cover,
                              ),
                            );
                          },
                        );
                      } else if (state is UserPostFetchEmpty) {
                        return Center(
                          child: Text(
                            'No posts Available',
                            style: captionStyle,
                          ),
                        );
                      } else if (state is UserPostFetchFailure) {
                        return Center(
                          child: Text(
                            'Failed to load post',
                            style: captionStyle,
                          ),
                        );
                      } else {
                        return Container();
                      }
                    },
                  ),
                )
              ],
            ),
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      }),
    );
  }
}
