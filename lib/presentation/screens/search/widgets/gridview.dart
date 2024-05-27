import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialmedia/application/bloc/search/search_bloc.dart';
import 'package:socialmedia/core/navigator.dart';
import 'package:socialmedia/presentation/screens/account/pages/userpostdetail.dart';
class GridviewSearch extends StatelessWidget {
  const GridviewSearch({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(builder: (context, state) {
      if (state is PostLoaded) {
        return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, mainAxisSpacing: 10, crossAxisSpacing: 10),
            itemCount: state.posts.length,
            itemBuilder: (BuildContext context, int index) {
              final posts = state.posts[index];
              return GestureDetector(
                onTap: () {
                  navigate(context,UserPostDetails(post: posts));
                },
                child: Container(  
                 decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          image: NetworkImage(posts.mediaUrls!.first),
                          fit: BoxFit.cover)),
                ),
              );
            });
      }
      return Center(child: CircularProgressIndicator());
    });
  }
}
