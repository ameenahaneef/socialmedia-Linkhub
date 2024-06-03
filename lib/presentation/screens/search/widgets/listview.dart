
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
     if(userList.isEmpty){
      return const Center(child: Text('no'),);
     }else{
    return ListView.builder(
      itemCount:userList.length,
        itemBuilder: (context, index) {
          final user=userList[index];
          return ListTile(
            onTap: () {
             Navigator.push(context, MaterialPageRoute(builder: (context){
              return PeopleDetails(userId: user.userId,name: user.name,);
             }));       
            },
            leading:  CircleAvatar(
              radius: 30,
              backgroundColor: korange,
             
                backgroundImage:user.userProfileImage!=null&&user.userProfileImage!.isNotEmpty? NetworkImage(user.userProfileImage!) as ImageProvider:
                const AssetImage('assets/images/download.png')
                  //'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQttE9sxpEu1EoZgU2lUF_HtygNLCaz2rZYHg&s',
               
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