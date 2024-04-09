import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:socialmedia/application/apiservices/postservice.dart';
import 'package:socialmedia/application/models/fetchpostmodel.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final List<String> imagess = [];

  PostBloc() : super(PostInitial()) {
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
      final String caption = event.caption;
      final List<String> imagePaths = event.imagePaths;

      try {
        await PostApiService().postImage(caption, imagePaths);
        emit(ImageUploadSuccessState());
      } catch (e) {
        emit(ImageUploadFailureState());
      }
    });

    on<FetchPostsEvent>((event, emit) async {
      emit(PostFetchProgressState());
      try {
        List<FetchModel> posts = await PostApiService().postFetch();
        print('recieved:$posts');

        emit(PostFetchSuccessState(posts: posts));
      } catch (e) {
        emit(PostFetchFailureState());
      }
    });
  }
}
