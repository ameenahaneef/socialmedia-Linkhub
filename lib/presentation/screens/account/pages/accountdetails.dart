import 'dart:io';
import 'package:flutter/material.dart';
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
import 'package:socialmedia/presentation/screens/account/widget/textbutton.dart';
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
              title: state is ShowingPostState
                  ? Text(
                      'Posts',
                      style: captionStyle,
                    )
                  : null,
              actions: [
                if (state is ShowingPostState)
                  CircleAvatar(
                    backgroundColor: korange,
                    child: IconButton(
                        onPressed: () {
                          context.read<AccountBloc>().add(FetchUserDataEvent());
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                          color: kwhite,
                        )),
                  ),
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
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20),
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
                          snackbar(context, 'Profile Image Edited Successfully',
                              backgroundColor: green);
                          context.read<AccountBloc>().add(FetchUserDataEvent());
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
                        'session expired',
                        style: captionStyle,
                      ));
                    } else if (state is ShowingPostState) {
                      return const GridviewBloc();
                    } else if (state is LoadedState) {
                      return BlocBuilder<PostBloc, PostState>(
                          builder: (context, poststate) {
                        if (poststate is PostFetchSuccessState) {
                          final postcount = poststate.posts.length;
                          final followingCount = state.profileModel
                                  .afterExecution?.followingCount ??
                              0;
                          final followersCount = state.profileModel
                                  .afterExecution?.followersCount ??
                              0;
                          final bio =
                              state.profileModel.afterExecution?.bio ?? '';

                          return Column(
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
                                                backgroundColor:
                                                    korange.withOpacity(0.9),
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
                                  Row(
                                    children: [
                                      textbutton('posts\n$postcount', () {
                                        context
                                            .read<AccountBloc>()
                                            .add(ShowPostEvent());
                                      }),
                                      textbutton('Following\n$followingCount',
                                          () {
                                        navigate(
                                            context,
                                            const FollowingList(
                                              showFollowing: true,
                                            ));
                                      }),
                                      textbutton('followers\n$followersCount',
                                          () {
                                        navigate(
                                            context,
                                            const FollowingList(
                                                showFollowing: false));
                                      }),
                                    ],
                                  ),
                                ],
                              ),
                              Secondwidget(profileModel: state.profileModel),
                              Padding(
                                padding: const EdgeInsets.only(left: 16.0),
                                child: Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Text(
                                      bio,
                                      style: nostyle,
                                    )),
                              ),
                              height20,
                              Text(
                                'Posts',
                                style: captionStyle,
                              ),
                              height20,
                              const GridviewBloc()
                            ],
                          );
                        }
                        return const SizedBox();
                      });
                    }
                    return Text(
                      'unexpected State',
                      style: captionStyle,
                    );
                  }),
                ),
              ),
            ));
      },
    );
  }
}
