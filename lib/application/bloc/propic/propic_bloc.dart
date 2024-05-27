import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:socialmedia/application/apiservices/editapi.dart';

part 'propic_event.dart';
part 'propic_state.dart';

class PropicBloc extends Bloc<PropicEvent, PropicState> {
  String image='';
  PropicBloc() : super(PropicInitial()) {
     on<PickImage>((event, emit) async{
      final pickedImage=await ImagePicker().pickImage(source:ImageSource.gallery);
      if(pickedImage!=null){
         image=pickedImage.path;
        emit(ImagePicked(image));
        
      }
    });


    on<UploadImage>((event, emit)async{
emit(ImageUploading());
try {
   await EditApi().setProfileImage(event.imagePath);
  emit(ImageUploadSuccess(event.imagePath));
} catch (e) {
  emit(ImageUploadFailure(e.toString()));
}
    });
  }
}
