part of 'like_bloc.dart';

@immutable
sealed class LikeState {}

final class LikeInitial extends LikeState {}
class Liked extends LikeState{
  final int likeCount;
  Liked(this.likeCount);
}

class Unliked extends LikeState{
  final int likeCount;
  Unliked(this.likeCount);
}