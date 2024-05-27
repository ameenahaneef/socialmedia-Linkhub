import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialmedia/application/bloc/search/search_bloc.dart';
import 'package:socialmedia/core/colors/colors.dart';
import 'package:socialmedia/core/constants.dart';

class TextfieldSearch extends StatelessWidget {
  const TextfieldSearch({
    super.key,
    required this.searchController,
  });

  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: searchController,
      style: nostyle,
      onChanged: (text) {
        if (text.isEmpty) {
          context.read<SearchBloc>().add(FetchPosts());
        } else {
          context.read<SearchBloc>().add(SearchTextChangedd(text));
        }
      },
      decoration: InputDecoration(
          hintText: 'Search here',
          hintStyle: const TextStyle(color: kgrey),
          prefixIcon: const Icon(
            Icons.search,
            color: kgrey,
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(color: kwhite))),
    );
  }
}
