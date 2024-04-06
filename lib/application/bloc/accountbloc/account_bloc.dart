import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:socialmedia/application/apiservices/apiservice.dart';
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
  }
}
