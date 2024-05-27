part of 'follow_bloc.dart';

@immutable
sealed class FollowEvent {}

class FollowUser extends FollowEvent{
  final int userId;
  FollowUser(this.userId);
}

class UnfollowUser extends FollowEvent{
  final int userId;
  UnfollowUser(this.userId);
}