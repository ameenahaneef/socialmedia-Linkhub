part of 'follow_bloc.dart';

@immutable
sealed class FollowState {}

final class FollowInitial extends FollowState {}
class FollowLoading extends FollowState{}

class FollowSuccess extends FollowState{
  final Follow? follow;
  FollowSuccess(this.follow);
}
class FollowFailure extends FollowState{
  final String errorMessage;
  FollowFailure(this.errorMessage);
}
class UnfollowSuccess extends FollowState{
  final Follow? follow;
  UnfollowSuccess(this.follow);
}