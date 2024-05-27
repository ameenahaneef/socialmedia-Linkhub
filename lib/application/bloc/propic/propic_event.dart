part of 'propic_bloc.dart';

@immutable
sealed class PropicEvent {}


class PickImage extends PropicEvent{}


class UploadImage extends PropicEvent {
  final String imagePath;
  UploadImage(this.imagePath);
}