import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:socialmedia/application/apiservices/followservice.dart';
import 'package:socialmedia/application/models/following.dart';

part 'following_event.dart';
part 'following_state.dart';

class FollowingBloc extends Bloc<FollowingEvent, FollowingState> {
  FollowingBloc() : super(FollowingInitial()) {
    on<FetchFollowingList>((event, emit)async {
      emit(FollowLoading());
      try {
        List<FollowingUser> followingList=await FollowService().getFollowingList();
        emit(FollowSuccess(followingList));
        
      } catch (e) {
        emit(FollowingFailure('failed'));
      }
    });

    on<FetchFollowersList>((event, emit)async{
      emit(FollowLoading());
      try {
        List<FollowingUser> followersList=await FollowService().getFollowersList();
        emit(FollowSuccess(followersList));
      } catch (e) {
        emit(FollowingFailure('failed to fetch followers'));
      }
    });
  }
}
