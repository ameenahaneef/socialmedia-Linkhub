import 'package:flutter/material.dart';
import 'package:socialmedia/core/colors/colors.dart';
import 'package:socialmedia/core/constants.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 50.0, left: 20, right: 20),
            child: TextField(
              style: nostyle,
              decoration: InputDecoration(
                  hintText: 'Search here',
                  hintStyle: const TextStyle(color: kgrey),
                  prefixIcon: const Icon(
                    Icons.search,
                    color: kgrey,
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(color: kwhite))),
            ),
          ),
          Expanded(
            child: ListView.separated(
                itemBuilder: (context, index) {
                  return ListTile(
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
                    title: Text(
                      'Name',
                      style: nostyle,
                    ),
                    subtitle: Text(
                      'gffgdgfd',
                      style: nostyle,
                    ),
                    trailing: Text(
                      'Followers\n123',
                      style: nostyle,
                    ),
                  );
                },
                separatorBuilder: (context, index) => height,
                itemCount: 10),
          )
        ],
      ),
    );
  }
}
