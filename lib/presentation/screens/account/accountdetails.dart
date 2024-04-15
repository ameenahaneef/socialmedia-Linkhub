import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialmedia/application/bloc/accountbloc/account_bloc.dart';
import 'package:socialmedia/application/bloc/post/post_bloc.dart';
import 'package:socialmedia/core/colors/colors.dart';
import 'package:socialmedia/core/constants.dart';
import 'package:socialmedia/core/navigator.dart';
import 'package:socialmedia/presentation/screens/account/postdetails.dart';
import 'package:socialmedia/presentation/screens/account/widget/bottomsheet.dart';
import 'package:socialmedia/presentation/screens/account/widget/textbutton.dart';

class AccountDetails extends StatelessWidget {
  const AccountDetails({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<AccountBloc>().add(FetchUserDataEvent());
    context.read<PostBloc>().add(FetchPostsEvent());
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: backgroundColor,
          actions: [
            IconButton(
                onPressed: () {
                  bottomsheet(context);
                },
                icon: const Icon(
                  Icons.more_vert,
                  color: kwhite,
                ))
          ],
        ),
        backgroundColor: backgroundColor,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20),
            child: BlocBuilder<AccountBloc, AccountState>(
              builder: (context, state) {
                if (state is LoadingState) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is ErrorState) {
                  return Center(
                      child: Text(
                    'error loading',
                    style: captionStyle,
                  ));
                } else if (state is LoadedState) {
                  return BlocBuilder<PostBloc, PostState>(
                    builder: (context, poststate) {
                      if(poststate is PostFetchSuccessState){
                        final postcount=poststate.posts.length;
                      
                      return Column(
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 50,
                                backgroundColor: Colors.orange[800],
                                child: IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.add)),
                              ),
                              const SizedBox(
                                width: 50,
                              ),
                              Column(
                                children: [
                                  Text(
                                    state.profileModel.afterExecution!.name,
                                    style: nostyle,
                                  ),
                                  Text(
                                    state.profileModel.afterExecution!.username,
                                    style: nostyle,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          height,
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.orange[800]),
                            child: Text(
                              'Edit profile',
                              style: nostyle,
                            ),
                          ),
                          Row(
                            children: [
                              textbutton(
                                  'post\n$postcount'),
                              textbutton(
                                  'Following\n0'),
                              textbutton(
                                  'followers\n${state.profileModel.afterExecution!.followingCount}'),
                            ],
                          ),
                          height,
                          Text(
                            'Explore people',
                            style: nostyle,
                          ),
                          height,
                          SizedBox(
                            height: 176,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: 10,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 4.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: Colors.grey.withOpacity(0.3)),
                                      width: 100,
                                      height: 100,
                                      child: Column(
                                        children: [
                                          const Align(
                                              alignment: Alignment.topCenter,
                                              child: Image(
                                                  image: AssetImage(
                                                      'assets/images/[removal.ai]_da4a22d4-3aa7-4812-ac4e-aead220b7375-screenshot-2024-03-26-192518.png'))),
                                          Text(
                                            'Name',
                                            style: stylet,
                                          ),
                                          TextButton(
                                              onPressed: () {},
                                              child: Text(
                                                'Follow',
                                                style: TextStyle(
                                                    color: Colors.orange[800]),
                                              ))
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                          ),
                          height20,
                          Text(
                            'Posts',
                            style: nostyle,
                          ),
                          height20,
                          BlocBuilder<PostBloc, PostState>(
                            builder: (context, state) {
                              if (state is PostFetchProgressState) {
                                return const CircularProgressIndicator();
                              } else if (state is PostFetchFailureState) {
                                return Text(
                                  'Failed to fetch',
                                  style: nostyle,
                                );
                              } else if (state is PostFetchEmptyState) {
                                return Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              color: kwhite, width: 2.0)),
                                      child: const CircleAvatar(
                                        backgroundColor: backgroundColor,
                                        radius: 40,
                                        child: Icon(
                                          Icons.camera_alt,
                                          color: kwhite,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      'No posts yet',
                                      style: captionStyle,
                                    )
                                  ],
                                );
                              } else if (state is PostFetchSuccessState) {
                                return GridView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 3,
                                            crossAxisSpacing: 8.0,
                                            mainAxisSpacing: 8.0),
                                    itemCount: state.posts.length,
                                    itemBuilder: (context, index) {
                                      final post = state.posts[index];

                                      final List<String>? mediaUrl =
                                          post.mediaUrls;

                                      if (mediaUrl != null &&
                                          mediaUrl.isNotEmpty) {
                                        if (mediaUrl.length > 1) {
                                          return Stack(
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  navigate(
                                                      context,
                                                      PostDetails(
                                                        post: post,
                                                      ));
                                                },
                                                child: Container(
                                                  width: 200,
                                                  height: 200,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      image: DecorationImage(
                                                          image: NetworkImage(
                                                              mediaUrl.first),
                                                          fit: BoxFit.fill,
                                                          
                                                        
                                                          )),
                                                ),
                                              ),
                                              const Positioned(
                                                  top: 0,
                                                  right: 0,
                                                  child: Icon(
                                                    Icons.photo_library,
                                                    color: kwhite,
                                                    size: 18,
                                                  ))
                                            ],
                                          );
                                        } else {
                                          return GestureDetector(
                                            onTap: () {
                                              navigate(context,
                                                  PostDetails(post: post));
                                            },
                                            child: Container(
                                              width: 200,
                                              height: 200,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                image: DecorationImage(
                                                    image: NetworkImage(
                                                        mediaUrl.first),
                                                    fit: BoxFit.fill),
                                              ),
                                            ),
                                          );
                                        }
                                      }
                                      return Container(
                                        width: 200,
                                        height: 200,
                                        color: kgrey,
                                        child: const CircularProgressIndicator(),
                                      );
                                    });
                              } else {
                                print('unknown postbloc state');
                                return const SizedBox();
                              }
                            },
                          )
                        ],
                      );
                     }return const SizedBox(); },
                  );
                }
                print('unnown accountbloc state');
                return const SizedBox();
              },
            ),
          ),
        ));
  }
}
