import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:socialmedia/core/colors/colors.dart';
import 'package:socialmedia/core/constants.dart';

class listview extends StatelessWidget {
  const listview({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 10,
      itemBuilder: (context, index) {
        return GestureDetector(
          child: Container(
            decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.4),
                borderRadius: BorderRadius.circular(30)),
            height: 400,
            margin: const EdgeInsets.all(5),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 18.0, left: 18.0, bottom: 10.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: backgroundColor,
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
                Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30)),
                    height: 200,
                    child: const Image(
                      image: AssetImage(
                          'assets/images/young-happy-businesswoman-wearing-headset-waving-while-video-conference-office.jpg'),
                      fit: BoxFit.cover,
                    )),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Row(
                    children: [
                      Row(
                        children: [
                          const LikeButton(),
                          Text(
                            '24 likes',
                            style: nostyle,
                          )
                        ],
                      ),
                      kwidth,
                      Row(
                        children: [
                          TextButton(
                              onPressed: () {},
                              child: Text(
                                'Comments',
                                style: nostyle,
                              )),
                          Text(
                            '22',
                            style: nostyle,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Text(
                  'well spend saewe fsdfa wewew we',
                  style: nostyle,
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
