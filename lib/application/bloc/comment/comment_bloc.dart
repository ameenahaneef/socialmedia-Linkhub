import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:socialmedia/application/apiservices/commentservice.dart';
import 'package:socialmedia/application/models/commentmodel.dart';

part 'comment_event.dart';
part 'comment_state.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  CommentBloc() : super(CommentInitial()) {
    on<FetchCommentEvent>((event, emit) async {
      emit(CommentLoading());
      try {
        final res = await CommentService().getAllComments(event.postId);
        emit(CommentLoaded(res));
      } catch (e) {
        emit(CommentError('failed to fetch $e'));
      }
    });

    on<AddCommentEvent>((event, emit) async {
      emit(CommentLoading());
      try {
        await CommentService().addComment(event.postId, event.commentText);
        emit(CommentAdded());
      
        
      } catch (e) {
        emit(CommentError('failed to add comment'));
      }
    });

    on<DeleteComments>((event, emit) async {
      try {
        await CommentService().deleteComment(event.commentId);

        emit(CommentDeleted(event.commentId));
      } catch (e) {
        emit(CommentError(e.toString()));
      }
    });

    on<EditCommentEvent>((event, emit) async {
      try {
        await CommentService().editComment(event.commentId, event.commentText);

        emit(CommentEdited(event.commentId));
       
      } catch (e) {
        emit(CommentError('Failed to edit comment:$e'));
      }
    });
  }
}
