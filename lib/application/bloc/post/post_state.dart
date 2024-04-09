part of 'post_bloc.dart';

@immutable
sealed class PostState {}

final class PostInitial extends PostState {}

class ImagePickedState extends PostState {
  final List<String> path;
  ImagePickedState(this.path);
}

class ImageUploadInProgressState extends PostState {}

class ImageUploadSuccessState extends PostState {}

class ImageUploadFailureState extends PostState {}

class PostFetchProgressState extends PostState {}

class PostFetchSuccessState extends PostState {
  final List<FetchModel> posts;
  PostFetchSuccessState({required this.posts});
}

class PostFetchFailureState extends PostState {}
