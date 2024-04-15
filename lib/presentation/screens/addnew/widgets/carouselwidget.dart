import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialmedia/application/bloc/post/post_bloc.dart';
import 'package:socialmedia/core/constants.dart';

class Carousel extends StatelessWidget {
  const Carousel({
    super.key,
    required this.captionController,
    required this.imagess,
  });

  final TextEditingController captionController;
  final List<String> imagess;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostBloc, PostState>(
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
                options:
                    CarouselOptions(height: 350, enableInfiniteScroll: false),
              ),
              height20,
              TextField(
                controller: captionController,
                style: nostyle,
                maxLines: 4,
                decoration: const InputDecoration(border: OutlineInputBorder()),
              ),
              height,
              ElevatedButton(
                onPressed: () {
                  imagess.clear();
                  imagess.addAll(state.path);
                  context
                      .read<PostBloc>()
                      .add(UploadImagesEvent(captionController.text, imagess));

                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
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
        }
        return const SizedBox();
      },
    );
  }
}
