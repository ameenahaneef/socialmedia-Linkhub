import 'package:flutter/material.dart';
import 'package:socialmedia/core/colors/colors.dart';
import 'package:socialmedia/core/constants.dart';
import 'package:socialmedia/presentation/userprofile/widgets/textbutton.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        foregroundColor: kwhite,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 30.0),
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.orange[800],
                    child: Image.asset(
                        'assets/images/[removal.ai]_da4a22d4-3aa7-4812-ac4e-aead220b7375-screenshot-2024-03-26-192518.png'),
                  ),
                  kwidth,
                  Column(
                    children: [
                      Text(
                        'Andrea elizabeth',
                        style: nostyle,
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange[800]),
                        child: Text(
                          'Edit profile',
                          style: nostyle,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 70,
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.more_vert,
                        color: kwhite,
                        size: 30,
                      ))
                ],
              ),
              height20,
              Row(
                children: [
                  textbutton('post\n112'),
                  textbutton('Following\n112'),
                  textbutton('followers\n223'),
                ],
              ),
              height,
              Text('Explore people',style: nostyle,),
              height,
              SizedBox(
                height: 176,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.grey.withOpacity(0.3)),
                          width: 100,
                          height: 100,
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.topCenter,
                                child: Image(image: AssetImage('assets/images/[removal.ai]_da4a22d4-3aa7-4812-ac4e-aead220b7375-screenshot-2024-03-26-192518.png'))),
                              Text('Name',style: stylet,),
                              TextButton(onPressed: (){}, child: Text('Follow',style: TextStyle(color: Colors.orange[800]),))
                            ],
                          ),
                        ),
                      );
                    }),
              ),
              height20,
              Text(
                'Posts',
                style: nostyle,
              ),
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0),
                itemCount: 20,
                itemBuilder: (context, index) {
                  return Container(
                    width: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey,
                      image: const DecorationImage(
                          image: AssetImage(
                              'assets/images/[removal.ai]_e9c280db-4b6c-43c6-8755-cf664c1a382e-screenshot-2024-03-30-175828.png'),
                          fit: BoxFit.cover),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
