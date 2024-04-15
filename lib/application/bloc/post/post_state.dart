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
  final List<AfterExecution> posts;
  PostFetchSuccessState({required this.posts});
}

class PostFetchFailureState extends PostState {}

class PostFetchEmptyState extends PostState {}

class PostDeleteProgressState extends PostState {}

class PostDeleteSuccessState extends PostState {}

class PostDeleteFailureState extends PostState {}

class CaptionEditingProgressState extends PostState {}

class CaptionEditSuccessState extends PostState {
  final String newCaption;
  CaptionEditSuccessState({required this.newCaption});
}

class CaptionEditFailureState extends PostState {}
