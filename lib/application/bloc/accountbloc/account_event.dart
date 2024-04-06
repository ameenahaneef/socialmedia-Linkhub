part of 'account_bloc.dart';

@immutable
sealed class AccountEvent {}

class FetchUserDataEvent extends AccountEvent {}
