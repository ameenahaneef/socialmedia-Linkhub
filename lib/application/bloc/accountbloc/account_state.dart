part of 'account_bloc.dart';

@immutable
sealed class AccountState {}

final class AccountInitial extends AccountState {}

class LoadingState extends AccountState {}

class LoadedState extends AccountState {
  final ProfileModel profileModel;
  LoadedState(this.profileModel);
}

class ErrorState extends AccountState {
  final String error;
  ErrorState(this.error);
}
class ShowingPostState extends AccountState{
  final ProfileModel profileModel;
  ShowingPostState(this.profileModel);
}
class Edited extends AccountState{}
