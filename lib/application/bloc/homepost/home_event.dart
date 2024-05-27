part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class FetchHomeDetails extends HomeEvent{}