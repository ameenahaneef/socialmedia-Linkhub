part of 'like_bloc.dart';

@immutable
sealed class LikeEvent {}

class LikedEvent extends LikeEvent{
  final int postId;
  final int? likeCount;
  LikedEvent(this.postId,this.likeCount);
}

class UnLikedEvent extends LikeEvent{
  final int postId;
  final int? likeCount;
  UnLikedEvent(this.postId,this.likeCount);
}