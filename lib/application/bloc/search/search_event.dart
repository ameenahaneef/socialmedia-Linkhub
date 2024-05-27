part of 'search_bloc.dart';

@immutable
sealed class SearchEvent {}

 class SearchTextChangedd extends SearchEvent{
  final String searchText;
  SearchTextChangedd(this.searchText);
 }

 class FetchPosts extends SearchEvent{}

class FetchPeopleProfile extends SearchEvent{
  final int userId;
  FetchPeopleProfile(this.userId);
}

class NavigateBack extends SearchEvent{
  
}