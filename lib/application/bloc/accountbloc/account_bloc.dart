import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:socialmedia/application/apiservices/authenticationservice.dart';
import 'package:socialmedia/application/models/profilemodel.dart';

part 'account_event.dart';
part 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  AccountBloc() : super(AccountInitial()) {
    on<FetchUserDataEvent>((event, emit) async {
      emit(LoadingState());
      final ProfileModel? userProfile = await SignupService().fetchUser();
      if (userProfile != null) {
        emit(LoadedState(userProfile));
      } else {
        emit(ErrorState('failed to fetch user data'));
      }
    });


   
    on<PostAddedEvent>((event, emit) async{
 if (state is LoadedState) {
        final currentState = state as LoadedState;
        final updatedProfile = currentState.profileModel.copyWith(
          afterExecution: currentState.profileModel.afterExecution!.copyWith(
            postsCount: currentState.profileModel.afterExecution!.postsCount + 1,
          ),
        );
        emit(LoadedState(updatedProfile));
      }
    });
    on<PostDeletedEvent>((event, emit)async{
 if (state is LoadedState) {
        final currentState = state as LoadedState;
        final updatedProfile = currentState.profileModel.copyWith(
          afterExecution: currentState.profileModel.afterExecution!.copyWith(
            postsCount: currentState.profileModel.afterExecution!.postsCount - 1,
          ),
        );
        emit(LoadedState(updatedProfile));
      }
    });
on<ShowPostEvent>((event, emit) async{
if(state is LoadedState){
  emit(ShowingPostState((state as LoadedState).profileModel));
}
});
  }
}
