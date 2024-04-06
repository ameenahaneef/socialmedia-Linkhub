part of 'navigation_bloc.dart';

@immutable
sealed class NavigationEvent {}

class ChangeNavigationEvent extends NavigationEvent {
  final int pageIndex;
  ChangeNavigationEvent(this.pageIndex);
}
