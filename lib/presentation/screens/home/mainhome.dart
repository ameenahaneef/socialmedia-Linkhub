import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:socialmedia/core/constants.dart';
import 'package:socialmedia/presentation/screens/login/login.dart';

class MainHome extends StatelessWidget {
  const MainHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Center(
              child: Image.asset(
            'assets/images/[removal.ai]_da4a22d4-3aa7-4812-ac4e-aead220b7375-screenshot-2024-03-26-192518.png',
           scale: 2.3,
          )),
          const SizedBox(
            height: 50,
          ),
          Text(
              'Connect with purpose,create with\npassion.Join  LinkHub and be part\n   of a community that inspires.',
              style: stylet),
          const SizedBox(
            height: 80,
          ),
          ElevatedButton(
              onPressed: () {
                 Navigator.of(context).push(MaterialPageRoute(builder: (context){
            return LoginScreen();
          }));
              },
              style: buttonstyle,
              child: Text(
                'Get Started',
                style: GoogleFonts.montserrat(
                    textStyle: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20)),
              )),
        ],
      ),
    );
  }
}
