import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialmedia/application/bloc/search/search_bloc.dart';
import 'package:socialmedia/core/colors/colors.dart';
import 'package:socialmedia/core/constants.dart';
import 'package:socialmedia/presentation/screens/search/widgets/gridview.dart';
import 'package:socialmedia/presentation/screens/search/widgets/listview.dart';
import 'package:socialmedia/presentation/screens/search/widgets/textfield.dart';

class SearchScreen extends StatelessWidget {
  
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController();
    context.read<SearchBloc>().add(FetchPosts());

    return Scaffold(
      backgroundColor: black,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 50.0, left: 20, right: 20),
            child: TextfieldSearch(
              searchController: searchController,
            ),
          ),
          Expanded(child: BlocBuilder<SearchBloc, SearchState>(
            builder: (context, state) {
              print('cAME');
              if (state is GridDisplay) {
                return const GridviewSearch();
                
              } else if (state is PostLoaded) {
                return const Padding(
                  padding: EdgeInsets.only(left: 10.0, right: 10.0),
                  child: GridviewSearch(),
                );
              } else if (state is SearchResults) {
                if (state.userList.isNotEmpty) {
                  return ListviewSearch(
                    userList: state.userList,
                  );
                } else {
                  return Center(
                    child: Text(
                      'no user found',
                      style: captionStyle,
                    ),
                  );
                }
              } else if (state is SearchError) {
                return Center(
                  child: Text(state.errorMessage),
                );
              } 
             

              return  SizedBox();
            },
          ))
        ],
      ),
    );
  }
}
