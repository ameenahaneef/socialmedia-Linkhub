import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialmedia/application/bloc/accountbloc/account_bloc.dart';
import 'package:socialmedia/application/bloc/propic/propic_bloc.dart';
import 'package:socialmedia/application/bloc/follow/follow_bloc.dart';
import 'package:socialmedia/application/bloc/post/post_bloc.dart';
import 'package:socialmedia/core/colors/colors.dart';
import 'package:socialmedia/core/constants.dart';
import 'package:socialmedia/core/navigator.dart';
import 'package:socialmedia/presentation/screens/account/widget/bottomsheet.dart';
import 'package:socialmedia/presentation/screens/account/widget/gridview.dart';
import 'package:socialmedia/presentation/screens/account/widget/secondwidget.dart';
import 'package:socialmedia/presentation/screens/account/widget/snackbar.dart';
import 'package:socialmedia/presentation/screens/search/pages/followingpeople.dart';

class AccountDetails extends StatelessWidget {
  const AccountDetails({super.key});
  @override
  Widget build(BuildContext context) {
    context.read<AccountBloc>().add(FetchUserDataEvent());
    context.read<PostBloc>().add(FetchPostsEvent());

    return BlocBuilder<AccountBloc, AccountState>(
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: black,
              foregroundColor: kwhite,
              leading: state is ShowingPostState
                  ? IconButton(
                      onPressed: () {
                        context.read<AccountBloc>().add(FetchUserDataEvent());
                      },
                      icon: Icon(Icons.arrow_back))
                  : null,
              title: state is ShowingPostState
                  ? Text(
                      'Posts',
                      style: captionStyle,
                    )
                  : null,
              actions: [
                //   // if (state is ShowingPostState)
                //   //   CircleAvatar(
                //   //     backgroundColor: korange,
                //   //     child: IconButton(
                //   //         onPressed: () {
                //   //           context.read<AccountBloc>().add(FetchUserDataEvent());
                //   //         },
                //   //         icon: const Icon(
                //   //           Icons.arrow_back,
                //   //           color: kwhite,
                //   //         )),
                //   //   ),
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
            backgroundColor: black,
            body: SingleChildScrollView(
              child: MultiBlocListener(
                listeners: [
                  BlocListener<FollowBloc, FollowState>(
                    listener: (context, state) {
                      context.read<AccountBloc>().add(FetchUserDataEvent());
                    },
                  ),
                  BlocListener<PropicBloc, PropicState>(
                    listener: (context, state) {
                      if (state is ImagePicked) {
                        context
                            .read<PropicBloc>()
                            .add(UploadImage(state.imagePath));
                      } else if (state is ImageUploadSuccess) {
                        context.read<AccountBloc>().add(FetchUserDataEvent());

                        // snackbar(context, 'Profile Image Edited Successfully',
                        //     backgroundColor: green);
                      } else if (state is ImageUploadFailure) {
                        snackbar(context, 'Failed to edit Image',
                            backgroundColor: red);
                      }
                    },
                  ),
                ],
                child: BlocBuilder<AccountBloc, AccountState>(
                    builder: (context, state) {
                  if (state is LoadingState) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is ErrorState) {
                    return Center(
                        child: Text(
                      'Session Expired\nLogin to continue',
                      style: captionStyle,
                    ));
                  } else if (state is ShowingPostState) {
                    return const GridviewBloc();
                  } else if (state is LoadedState) {
                    return BlocBuilder<PostBloc, PostState>(
                        builder: (context, poststate) {
                      if (poststate is PostFetchSuccessState) {
                        final postcount = poststate.posts.length;
                        final followingCount =
                            state.profileModel.afterExecution?.followingCount ??
                                0;
                        final followersCount =
                            state.profileModel.afterExecution?.followersCount ??
                                0;
                        return Stack(
                          children:[ Padding(
                            padding: const EdgeInsets.only(left: 8.0, right: 8),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    BlocBuilder<PropicBloc, PropicState>(
                                      builder: (context, propicState) {
                                        return Stack(children: [
                                          CircleAvatar(
                                            radius: 50,
                                            backgroundImage: propicState
                                                    is ImagePicked
                                                ? FileImage(
                                                    File(propicState.imagePath))
                                                : NetworkImage(state
                                                        .profileModel
                                                        .afterExecution!
                                                        .userprofileimageurl)
                                                    as ImageProvider,
                                            backgroundColor: korange,
                                          ),
                                          Positioned(
                                              bottom: 0,
                                              right: 0,
                                              child: CircleAvatar(
                                                  backgroundColor: kwhite,
                                                  child: IconButton(
                                                      onPressed: () {
                                                        context
                                                            .read<PropicBloc>()
                                                            .add(PickImage());
                                                      },
                                                      icon: const Icon(
                                                        Icons.edit,
                                                        color: black,
                                                      ))))
                                        ]);
                                      },
                                    ),
                                    kwidth20,
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            context
                                                .read<AccountBloc>()
                                                .add(ShowPostEvent());
                                          },
                                          child: Column(
                                            children: [
                                              Text(
                                                'Post',
                                                style: headStyle,
                                              ),
                                              Text(
                                                '$postcount',
                                                style: nostyle,
                                              )
                                            ],
                                          ),
                                        ),
                                        kwidth20,
                                        GestureDetector(
                                          onTap: () {
                                            navigate(
                                                context,
                                                const FollowingList(
                                                  showFollowing: true,
                                                ));
                                          },
                                          child: Column(
                                            children: [
                                              Text(
                                                'Following',
                                                style: headStyle,
                                              ),
                                              Text(
                                                '$followingCount',
                                                style: nostyle,
                                              )
                                            ],
                                          ),
                                        ),
                                        kwidth20,
                                        GestureDetector(
                                          onTap: () {
                                            navigate(
                                                context,
                                                const FollowingList(
                                                    showFollowing: false));
                                          },
                                          child: Column(
                                            children: [
                                              Text(
                                                'Followers',
                                                style: headStyle,
                                              ),
                                              Text(
                                                '$followersCount',
                                                style: nostyle,
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                height,
                                Secondwidget(profileModel: state.profileModel),
                                Text(
                                  'Posts',
                                  style: captionStyle,
                                ),
                                const GridviewBloc()
                              ],
                            ),
                          ),
                          BlocBuilder<PropicBloc,PropicState>(builder: (context,PropicState){
                            if(PropicState is ImageUploading){
                              return Positioned.fill(child: Container(color: black.withOpacity(0.5),child: Center(child: CircularProgressIndicator(),),));
                            }return SizedBox();
                          })
                      ]  );
                      }
                      return SizedBox();
                    });
                  }
                  return Text(
                    'unexpected State',
                    style: captionStyle,
                  );
                }),
              ),
            ));
      },
    );
  }
}
