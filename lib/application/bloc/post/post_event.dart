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
class DeletePostEvent extends PostEvent{
  final String postId;
  DeletePostEvent(this.postId);
}


class EditCaptionEvent extends PostEvent{
  final String postId;
  final String newCaption;
  EditCaptionEvent({required this.postId,required this.newCaption});
}
