part of 'comment_bloc.dart';

@immutable
sealed class CommentState {}

final class CommentInitial extends CommentState {}

class CommentLoading extends CommentState{}
class CommentLoaded extends CommentState{
 final CommentModel comments;
  CommentLoaded(this.comments);
}
class CommentAdded extends CommentState{
  
 }
class CommentError extends CommentState{
  final String error;
  CommentError(this.error);
} 