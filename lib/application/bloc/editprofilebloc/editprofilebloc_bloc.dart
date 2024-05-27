import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:socialmedia/application/apiservices/editapi.dart';
import 'package:socialmedia/application/bloc/accountbloc/account_bloc.dart';
import 'package:socialmedia/application/models/newedit.dart';
part 'editprofilebloc_event.dart';
part 'editprofilebloc_state.dart';

class EditprofileblocBloc
    extends Bloc<EditprofileblocEvent, EditprofileblocState> {
final AccountBloc accountBloc;
String image='';
  EditprofileblocBloc(this.accountBloc) : super(EditprofileblocInitial()) {
    on<EditProfile>((event, emit) async {
      try {
        await EditApi().editProfile(event.profile);
        emit(EditProfileSuccess());
       accountBloc.add(FetchUserDataEvent());
             
      } catch (e) {
    print('$e');
emit(EditProfileFailure('Failed to edit profile'));
      }
    });
    
  }

}
