part of 'userpost_bloc.dart';

@immutable
sealed class UserpostState {}

final class UserpostInitial extends UserpostState {}
class UserPostFetchProgress extends UserpostState{}

class UserPostFetchSuccess extends UserpostState{
  final List<After> userposts;
  UserPostFetchSuccess(this.userposts);
}
class UserPostFetchFailure extends UserpostState{}

class UserPostFetchEmpty extends UserpostState{}