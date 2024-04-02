import 'package:flutter/material.dart';
import 'package:socialmedia/core/colors/colors.dart';
import 'package:socialmedia/core/constants.dart';
import 'package:socialmedia/presentation/mainhomee/widget/cardwidget.dart';
import 'package:socialmedia/presentation/mainhomee/widget/listview.dart';
import 'package:socialmedia/presentation/userprofile/userprofile.dart';

class HomeMain extends StatelessWidget {
  const HomeMain({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 50.0,left: 20.0 ,right: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const UserProfile(),
                  ));
                },
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.orange[800],
                      child: Image.asset(
                          'assets/images/[removal.ai]_da4a22d4-3aa7-4812-ac4e-aead220b7375-screenshot-2024-03-26-192518.png'),
                    ),
                    kwidth,
                    Text(
                      'Ameena',
                      style: nostyle,
                    )
                  ],
                ),
              ),
             
              height20,
              SizedBox(
                height: 140,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return card();
                  },
                ),
              ),
             // height20,
              const listview(),
            ],
          ),
        ),
      ),
     // bottomNavigationBar: const bottomnavigationbar(),
    );
  }
}

