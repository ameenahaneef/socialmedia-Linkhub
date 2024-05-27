part of 'following_bloc.dart';

@immutable
sealed class FollowingEvent {}

class FetchFollowingList extends FollowingEvent{}

class FetchFollowersList extends FollowingEvent{}