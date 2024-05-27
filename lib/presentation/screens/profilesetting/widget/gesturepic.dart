import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socialmedia/application/bloc/propic/propic_bloc.dart';
import 'package:socialmedia/core/colors/colors.dart';

class gesturepic extends StatelessWidget {
  final String imageUrl;
  const gesturepic({
    super.key,
    required this.imageUrl
  });
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PropicBloc, PropicState>(

      builder: (context, state) {
       
        return GestureDetector(
          onTap: ()async {
            context.read<PropicBloc>().add(PickImage());
          
          },
          child:
          Container(
            width: 130,
            height: 120,
            decoration: BoxDecoration(
              color: kgrey.withOpacity(0.5),
              border: Border.all(width: 1.2,color: kwhite),
              borderRadius: BorderRadius.circular(40),
                            image:state is ImagePicked? DecorationImage(image: FileImage(File(state.imagePath,)),fit: BoxFit.cover):imageUrl.isNotEmpty?DecorationImage(image: NetworkImage(imageUrl),fit: BoxFit.cover):null,

            ),
            
          
            child: state is ImagePicked&&imageUrl.isEmpty? const Icon(
              Icons.person,
              size: 80,
              color: kwhite,
            ):null
          ),
        );
      },
    );
  }
}
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:socialmedia/application/bloc/accountbloc/account_bloc.dart';
// import 'package:socialmedia/application/bloc/propic/propic_bloc.dart';
// import 'package:socialmedia/core/colors/colors.dart';

// class GesturePic extends StatelessWidget {
//   final String imageUrl;
//   const GesturePic({
//     super.key,
//     required this.imageUrl
//   });

//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<PropicBloc, PropicState>(
//       listener: (context, state) {
//         if (state is ImagePicked) {
//           context.read<PropicBloc>().add(PickImage());
//           // When an image is picked, trigger the upload event
//           context.read<PropicBloc>().add(UploadImage(state.imagePath));
//           //context.read<AccountBloc>().add(FetchUserDataEvent());
//         } 
//         // else if (state is ImageUploadSuccess) {
//         //   ScaffoldMessenger.of(context).showSnackBar(
//         //     SnackBar(content: Text('Image uploaded successfully!')),
//         //   );
//         // }
//          else if (state is ImageUploadFailure) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text('Image upload failed: ${state.error}')),
//           );
//         }
//       },
//       builder: (context, state) {
//         return GestureDetector(
//           onTap: () async {
//             context.read<PropicBloc>().add(PickImage());
//           },
//           child: Container(
//             width: 130,
//             height: 120,
//             decoration: BoxDecoration(
//               color: kgrey.withOpacity(0.5),
//               border: Border.all(width: 1.2, color: kwhite),
//               borderRadius: BorderRadius.circular(40),
//               image: state is ImagePicked
//                 ? DecorationImage(image: FileImage(File(state.imagePath)), fit: BoxFit.cover)
//                 : 
//                 imageUrl.isNotEmpty
//                   ?
//                    DecorationImage(image: NetworkImage(imageUrl), fit: BoxFit.cover)
//                   : null,
//             ),
//             child: state is ImageUploading
//               ? Center(child: CircularProgressIndicator())
//               : state is! ImagePicked && imageUrl.isEmpty
//                 ? const Icon(
//                     Icons.person,
//                     size: 80,
//                     color: kwhite,
//                   )
//                 : null,
//           ),
//         );
//       },
//     );
//   }
// }
