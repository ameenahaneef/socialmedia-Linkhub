part of 'comment_bloc.dart';

@immutable
sealed class CommentEvent {}

class FetchCommentEvent extends CommentEvent {
  final int postId;
  FetchCommentEvent(this.postId);
}

class AddCommentEvent extends CommentEvent {
  final int postId;
  final String commentText;
  AddCommentEvent(this.postId, this.commentText);
}

class DeleteComments extends CommentEvent {
  final int commentId;
  DeleteComments(this.commentId);
}

class EditCommentEvent extends CommentEvent {
  final int commentId;
  final String commentText;

  EditCommentEvent(this.commentId, this.commentText);
}
class DeleteCommentEvent extends CommentEvent {
  final int commentId;
  DeleteCommentEvent(this.commentId);
}
