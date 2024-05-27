import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:socialmedia/application/apiservices/searchservice.dart';
import 'package:socialmedia/application/models/fetchpostmodel.dart';
import 'package:socialmedia/application/models/peopleprofile.dart';
import 'package:socialmedia/application/models/searchmodel.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(GridDisplay()) {
    on<SearchTextChangedd>((event, emit) async {
      if (event.searchText.isEmpty) {
        emit(GridDisplay());
      } else {
        try {
          final user = await SearchApiService().searchUser(event.searchText);
          emit(SearchResults(user));
          
        } catch (e) {
          emit(SearchError('failed to sear'));
        }
      }
    });
    on<FetchPosts>((event, emit) async {
      try {
        final pos = await SearchApiService().getGlobalPost();
        emit(PostLoaded(pos));
      } catch (e) {
        log(e.toString());
      }
    });
    on<FetchPeopleProfile>((event, emit) async {
      try {
        final users = await SearchApiService().getPeopleProfile(event.userId);
        emit(PeopleProfileLoaded(users));
      } catch (e) {
        print('Error fetching people profile: $e');
        log(e.toString());
      }
    });

    on<NavigateBack>((event, emit) {
      final userList = (state as SearchResults).userList;
      emit(NavigateBackResults(userList));
    });
  }
}
