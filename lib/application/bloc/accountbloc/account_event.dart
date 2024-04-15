part of 'account_bloc.dart';

@immutable
sealed class AccountEvent {}

class FetchUserDataEvent extends AccountEvent {}
class PostAddedEvent extends AccountEvent{}
class PostDeletedEvent extends AccountEvent{}