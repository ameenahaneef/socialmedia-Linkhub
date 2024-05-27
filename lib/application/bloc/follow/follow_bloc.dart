import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:socialmedia/application/apiservices/followservice.dart';
import 'package:socialmedia/application/bloc/accountbloc/account_bloc.dart';
import 'package:socialmedia/application/models/follow.dart';

part 'follow_event.dart';
part 'follow_state.dart';

class FollowBloc extends Bloc<FollowEvent, FollowState> {
  final AccountBloc accountBloc;
  FollowBloc({required this.accountBloc}) : super(FollowInitial()) {
    on<FollowUser>((event, emit) async {
      emit(FollowLoading());
      try {
        final follow = await FollowService().followUsers(event.userId);
        emit(FollowSuccess(follow));
        accountBloc.add(FetchUserDataEvent());
      } catch (e) {
        emit(FollowFailure('$e'));
      }
    });

    on<UnfollowUser>((event, emit) async {
      emit(FollowLoading());
      try {
        final follow = await FollowService().unFollowUsers(event.userId);
        emit(UnfollowSuccess(follow));
        accountBloc.add(FetchUserDataEvent());
      } catch (e) {
        emit(FollowFailure('failed to follow'));
      }
    });
  }
}
