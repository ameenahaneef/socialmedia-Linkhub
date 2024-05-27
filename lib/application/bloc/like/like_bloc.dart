import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:socialmedia/application/apiservices/likepost.dart';

part 'like_event.dart';
part 'like_state.dart';

class LikeBloc extends Bloc<LikeEvent, LikeState> {
  LikeBloc() : super(LikeInitial()) {
    on<LikedEvent>((event, emit) async {
      try {
        await LikeServices().likePost(event.postId);
        emit(Liked(event.likeCount! +1));
      } catch (e) {
        log(e.toString());
      }
    });

    on<UnLikedEvent>((event, emit)async{
try {
  await LikeServices().unLikePost(event.postId);
  emit(Unliked(event.likeCount!-1));
} catch (e) {
  log(e.toString());
}
    });
  }
}
