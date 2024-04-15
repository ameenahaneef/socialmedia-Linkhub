import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialmedia/application/bloc/post/post_bloc.dart';
import 'package:socialmedia/core/colors/colors.dart';
import 'package:socialmedia/core/constants.dart';
import 'package:socialmedia/presentation/screens/addnew/widgets/carouselwidget.dart';
import 'package:socialmedia/presentation/screens/addnew/widgets/elsecontainer.dart';

class AddPostWidget extends StatelessWidget {
  AddPostWidget({super.key});
  final List<String> imagess = [];
  final TextEditingController captionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                 Text('Add your post here',
                    style: captionStyle),
                BlocBuilder<PostBloc, PostState>(
                  builder: (context, state) {
                    if (state is ImagePickedState) {
                      return Carousel(
                          captionController: captionController,
                          imagess: imagess);
                    } else {
                      return const Elsecontainer();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
