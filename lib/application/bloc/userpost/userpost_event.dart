part of 'userpost_bloc.dart';

@immutable
sealed class UserpostEvent {}
class UserFetchPostEvent extends UserpostEvent{
final int userId;
UserFetchPostEvent(this.userId);
}
