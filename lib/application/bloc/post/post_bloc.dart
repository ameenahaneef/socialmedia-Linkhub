
import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:socialmedia/application/apiservices/postservice.dart';
import 'package:socialmedia/application/bloc/accountbloc/account_bloc.dart';
import 'package:socialmedia/application/models/fetchpostmodel.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final List<String> imagess = [];
  final AccountBloc accountBloc;

  PostBloc({required this.accountBloc}) : super(PostInitial()) {
    on<PickImagesEvent>((event, emit) async {
      final List<XFile> pickedFiles = await ImagePicker().pickMultiImage();
      if (pickedFiles.isNotEmpty) {
        final List<String> images =
            pickedFiles.map((file) => file.path).toList();
        imagess.addAll(images);
        emit(ImagePickedState(images));
      }
    });

    on<UploadImagesEvent>((event, emit) async {
      print('upload images event triggeres');
      final String caption = event.caption;
      final List<String> imagePaths = event.imagePaths;

      try {
        await PostApiService().postImage(caption, imagePaths);
        List<After> updatedPosts = await PostApiService().postFetch();
        emit(ImageUploadSuccessState());
        emit(PostFetchSuccessState(posts: updatedPosts));
       
      } catch (e) {
        emit(ImageUploadFailureState());
      }
    });

    on<FetchPostsEvent>((event, emit) async {
      emit(PostFetchProgressState());
      try {
        List<After> post = await PostApiService().postFetch();
        print('fetched posts:$post');
        if (post.isEmpty) {
          emit(PostFetchEmptyState());
        } else {
          emit(PostFetchSuccessState(posts: post));
        }
      } catch (e) {
        emit(PostFetchFailureState());
      }
    });

    on<DeletePostEvent>((event, emit) async {
      emit(PostDeleteProgressState());
      try {
        await PostApiService().deletePost(event.postId);
        List<After> updatedPosts = await PostApiService().postFetch();
        emit(PostDeleteSuccessState(posts: updatedPosts));
        emit(PostFetchSuccessState(posts: updatedPosts));
        accountBloc.add(PostDeletedEvent());
      } catch (e) {
        emit(PostDeleteFailureState());
      }
    });

on<EditCaptionEvent>((event, emit) async{
  try {
    await PostApiService().editCaption(event.newCaption, event.postId);
    emit(CaptionEditSuccessState(newCaption: event.newCaption));

    
  } catch (e) {
    emit(CaptionEditFailureState());
  }

});




  }
   
   
}
