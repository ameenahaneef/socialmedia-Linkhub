part of 'following_bloc.dart';

@immutable
sealed class FollowingState {}

final class FollowingInitial extends FollowingState {}

class FollowLoading extends FollowingState{}
class FollowSuccess extends FollowingState{
final List< FollowingUser> followingUser;
  FollowSuccess(this.followingUser);
}
class FollowingFailure extends FollowingState{
  final String errorMessage;
  FollowingFailure(this.errorMessage);
}