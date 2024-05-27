
import 'package:flutter/material.dart';
import 'package:socialmedia/application/models/searchmodel.dart';
import 'package:socialmedia/core/colors/colors.dart';
import 'package:socialmedia/core/constants.dart';
import 'package:socialmedia/presentation/screens/search/pages/peopledetails.dart';

class ListviewSearch extends StatelessWidget {
  final List<User> userList;
   ListviewSearch({
    super.key,
    required this.userList
  });
   
  @override
  Widget build(BuildContext context) {
     print('User List Length: ${userList.length}');
     if(userList.isEmpty){
      print('emptyyyyyyy');
      return Center(child: Text('no'),);
     }else{
    return ListView.builder(
      itemCount:userList.length,
        itemBuilder: (context, index) {
          final user=userList[index];
          return ListTile(
            onTap: () {
             Navigator.push(context, MaterialPageRoute(builder: (context){
              return PeopleDetails(userId: user.userId);
             }));       
            },
            leading: const CircleAvatar(
              radius: 30,
              backgroundColor: kgrey,
              child: Image(
                image: AssetImage(
                  'assets/images/[removal.ai]_da4a22d4-3aa7-4812-ac4e-aead220b7375-screenshot-2024-03-26-192518.png',
                ),
                fit: BoxFit.cover,
              ),
            ),
            title: 
            Text(
             user.name,
              style: nostyle,
            ),
            subtitle: Text(
              user.username,
              style: nostyle,
            ),
          );
        },
        );
  }
}
}