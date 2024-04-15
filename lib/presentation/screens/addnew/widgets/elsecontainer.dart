import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialmedia/application/bloc/post/post_bloc.dart';
import 'package:socialmedia/core/colors/colors.dart';

class Elsecontainer extends StatelessWidget {
  const Elsecontainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
            color: kgrey.withOpacity(0.3),
            borderRadius: BorderRadius.circular(30)),
        width: 300,
        height: 420,
        child: IconButton(
            onPressed: () {
              context.read<PostBloc>().add(PickImagesEvent());
            },
            icon: const Icon(
              Icons.upload,
              color: kwhite,
              size: 50,
            )),
      ),
    );
  }
}

