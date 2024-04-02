import 'package:flutter/material.dart';
import 'package:socialmedia/core/colors/colors.dart';
import 'package:socialmedia/core/constants.dart';
import 'package:socialmedia/presentation/screens/home/mainhome.dart';

class HomeSplash extends StatelessWidget {
  const HomeSplash({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.black,
      body:Column(
       children: [
         const Image(image: AssetImage('assets/images/[removal.ai]_e9c280db-4b6c-43c6-8755-cf664c1a382e-screenshot-2024-03-30-175828.png',),),
         Text('Connect, share,inspire.\nJoin the conversation on LinkHub',style:stylet
         ),
         const SizedBox(height: 70),
         Container(
           width: 50,
           height: 50,
           decoration: BoxDecoration(
           borderRadius: BorderRadius.circular(30),color: Colors.orange[800]
         ),
         child:IconButton(onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context){
            return MainHome();
          }));
         }, icon:const Icon(Icons.arrow_forward,color: kwhite,)) 
         )
       ],
      ) );
  }
}