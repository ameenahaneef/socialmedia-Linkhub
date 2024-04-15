import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialmedia/application/bloc/post/post_bloc.dart';
import 'package:socialmedia/core/colors/colors.dart';
import 'package:socialmedia/core/constants.dart';

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
                const Text('Add your post here',
                    style: TextStyle(color: kwhite, fontSize: 20)),
                BlocBuilder<PostBloc, PostState>(
                  builder: (context, state) {
                    if (state is ImagePickedState) {
                      return Column(
                        children: [
                          CarouselSlider(
                              items: state.path.map((path) {
                                return Container(
                                  margin: const EdgeInsets.all(5.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.0),
                                    image: DecorationImage(
                                      image: FileImage(File(path)),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                );
                              }).toList(),
                              options: CarouselOptions(
                                  height: 350, enableInfiniteScroll: false)),
                          height20,
                          TextField(
                            controller: captionController,
                            style: nostyle,
                            maxLines: 4,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder()),
                          ),
                          height,
                          ElevatedButton(
                            onPressed: () {
                              imagess.clear();
                              imagess.addAll(state.path);
                              print(imagess);
                              context.read<PostBloc>().add(UploadImagesEvent(
                                  captionController.text, imagess));
                                 
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text('posted successfully'),
                                backgroundColor: Colors.green,
                              ));
                               captionController.clear();
                            },
                            style: buttonstyle,
                            child: const Text('post'),
                          )
                        ],
                      );
                    } else {
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
