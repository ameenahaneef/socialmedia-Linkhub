part of 'editprofilebloc_bloc.dart';

@immutable
sealed class EditprofileblocEvent {}

class EditProfile extends EditprofileblocEvent{
  final Profilee profile;
  EditProfile(this.profile);
}
