part of 'navigation_bloc.dart';

@immutable
sealed class NavigationState {}

final class NavigationInitial extends NavigationState {
  final int initialPageIndex;
  NavigationInitial(this.initialPageIndex);
}
