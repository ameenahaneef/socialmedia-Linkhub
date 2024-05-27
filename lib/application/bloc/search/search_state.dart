part of 'search_bloc.dart';

@immutable
sealed class SearchState {}

final class SearchInitial extends SearchState {}

class GridDisplay extends SearchState {}

class ListDisplay extends SearchState {}

class PostLoaded extends SearchState {
  final List<After> posts;
  PostLoaded(this.posts);
}

class SearchResults extends SearchState {
  final List<User> userList;
  SearchResults(this.userList);
}

class SearchError extends SearchState {
  final String errorMessage;
  SearchError(this.errorMessage);
}

class PeopleProfileLoaded extends SearchState {
  final PeopleAfter? profile;
  PeopleProfileLoaded(this.profile);
}

class NavigateBackResults extends SearchState {
  final List<User> userList;
  NavigateBackResults(this.userList);
}
