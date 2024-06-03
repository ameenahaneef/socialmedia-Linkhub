import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialmedia/application/bloc/post/post_bloc.dart';
import 'package:socialmedia/core/colors/colors.dart';
import 'package:socialmedia/core/constants.dart';
import 'package:socialmedia/core/navigator.dart';
import 'package:socialmedia/presentation/screens/account/pages/userpostdetail.dart';
import 'package:socialmedia/presentation/screens/account/widget/nopostcolumn.dart';

class GridviewBloc extends StatelessWidget {
  const GridviewBloc({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostBloc, PostState>(
      builder: (context, state) {
        if (state is PostFetchProgressState) {
          return const CircularProgressIndicator();
        } else if (state is PostFetchFailureState) {
          return Text(
            'Failed to fetch',
            style: nostyle,
          );
        } else if (state is PostFetchEmptyState) {
          return const Nopost();
        } else if (state is PostFetchSuccessState) {
          return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 4.0,
                  mainAxisSpacing: 4.0),
              itemCount: state.posts.length,
              itemBuilder: (context, index) {
                final post = state.posts[index];

                final List<String>? mediaUrl = post.mediaUrls;

                if (mediaUrl != null && mediaUrl.isNotEmpty) {
                  if (mediaUrl.length > 1) {
                    return Stack(
                      children: [
                        GestureDetector(
                          onTap: () {
                            navigate(
                                context,
                                UserPostDetails(
                                  post: post,
                                  
                                ));
                          },
                          child: Container(
                            width: 200,
                            height: 200,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(mediaUrl.first),
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
                        navigate(context, UserPostDetails(post: post));
                      },
                      child: Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                              image: NetworkImage(mediaUrl.first),
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
          return const SizedBox();
        }
      },
    );
  }
  
}
