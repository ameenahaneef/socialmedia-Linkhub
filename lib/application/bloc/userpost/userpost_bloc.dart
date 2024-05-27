import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:socialmedia/application/apiservices/postservice.dart';
import 'package:socialmedia/application/models/fetchpostmodel.dart';

part 'userpost_event.dart';
part 'userpost_state.dart';

class UserpostBloc extends Bloc<UserpostEvent, UserpostState> {
  UserpostBloc() : super(UserpostInitial()) {

    on<UserFetchPostEvent>((event, emit)async{
  emit(UserPostFetchProgress());
  try {
    List<After> userposts=await PostApiService().getUserPost(userId:event.userId);
    if(userposts.isEmpty){
      emit(UserPostFetchEmpty());
    }else{
      emit(UserPostFetchSuccess(userposts));
    }
  } catch (e) {
    emit(UserPostFetchFailure());
  }
});
  }
}
