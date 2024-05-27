part of 'account_bloc.dart';

@immutable
sealed class AccountEvent {}


class FetchUserDataEvent extends AccountEvent {}
class PostAddedEvent extends AccountEvent{}
class PostDeletedEvent extends AccountEvent{}
class FollowUserEvent extends AccountEvent{
  final int userId;
  FollowUserEvent(this.userId);
}
class UnFollowUserEvent extends AccountEvent{
  final int userId;
  UnFollowUserEvent(this.userId);
}
class ShowPostEvent extends AccountEvent{}

// class EditProfile extends AccountEvent{
//   final Profilee profile;
//   EditProfile(this.profile);
// }