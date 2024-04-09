part of 'post_bloc.dart';

@immutable
sealed class PostEvent {}

class PickImagesEvent extends PostEvent {}

class UploadImagesEvent extends PostEvent {
  final String caption;
  final List<String> imagePaths;
  UploadImagesEvent(this.caption, this.imagePaths);
}

class FetchPostsEvent extends PostEvent {}
