part of 'comment_bloc.dart';

@immutable
sealed class CommentEvent {}

class FetchCommentEvent extends CommentEvent{
  final int commentId;
  FetchCommentEvent(this.commentId);
}

class AddCommentEvent extends CommentEvent{
  final int postId;
  final String commentText;
  AddCommentEvent(this.postId,this.commentText);
}

class DeleteComments extends CommentEvent{
  final int commentId;
  DeleteComments(this.commentId);
}