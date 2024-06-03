import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialmedia/application/bloc/following/following_bloc.dart';
import 'package:socialmedia/application/models/following.dart';
import 'package:socialmedia/core/colors/colors.dart';
import 'package:socialmedia/core/constants.dart';
import 'package:socialmedia/core/navigator.dart';
import 'package:socialmedia/presentation/screens/search/pages/peopledetails.dart';

class FollowingList extends StatelessWidget {
  final bool showFollowing;
  const FollowingList({super.key, required this.showFollowing});

  @override
  Widget build(BuildContext context) {
    if (showFollowing) {
      context.read<FollowingBloc>().add(FetchFollowingList());
    } else {
      context.read<FollowingBloc>().add(FetchFollowersList());
    }
    return Scaffold(
      backgroundColor: black,
      appBar: AppBar(
        backgroundColor: black,
        foregroundColor: kwhite,
        title: Center(
          child: Text(

            showFollowing?'Following':'Followers',
            style: captionStyle,
          ),
        ),
      ),
      body:
          BlocBuilder<FollowingBloc, FollowingState>(builder: (context, state) {
        if (state is FollowingInitial) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is FollowSuccess) {
          return ListView.separated(
              itemBuilder: (context, index) {
                FollowingUser user = state.followingUser[index];
                return SizedBox(
                  width: 20,
                  height: 80,
                  child: ListTile(
                    onTap: () {
                      navigate(context, PeopleDetails(userId: user.userId,name: user.name,));
                    },
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(user.profileImageUrl??'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQttE9sxpEu1EoZgU2lUF_HtygNLCaz2rZYHg&s'),
                      radius: 40,
                      
                    ),
                    title: Text(
                      user.name,
                      style: headStyle,
                    ),
                    subtitle: Text(
                      user.username,
                      style: TextStyle(color: kwhite.withOpacity(0.6)),
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return Spacer();
              },
              itemCount: state.followingUser.length);
        }else if(state is FollowingFailure){
          return Center(child: Text('Failed to fetch list',style: nostyle,),);
        }
        return SizedBox();
      }),
    );
  }
}
