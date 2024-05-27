part of 'editprofilebloc_bloc.dart';

@immutable
sealed class EditprofileblocState {}

final class EditprofileblocInitial extends EditprofileblocState {}

class EditProfileSuccess extends EditprofileblocState {}

class EditProfileFailure extends EditprofileblocState {
  final String errorMessage;

  EditProfileFailure(this.errorMessage);
}
