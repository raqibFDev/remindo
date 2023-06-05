import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:remindo/constants/stylingFonts.dart';
import 'package:remindo/screens/welcomeScreen.dart';

class SplashOne extends StatefulWidget {
  const SplashOne({super.key});

  @override
  State<SplashOne> createState() => _SplashOneState();
}

class _SplashOneState extends State<SplashOne> {
  @override
  Widget build(BuildContext context) {
    var devWidth = MediaQuery.of(context).size.width;
    var devHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: kMainColor,
      body: Column(children: [
        Expanded(
            flex: 4,
            child: Center(
              child: CircleAvatar(
                backgroundColor: Colors.white70,
                radius: 140,
                child: CircleAvatar(
                  radius: 130,
                  backgroundImage: AssetImage('images/giphy.gif'),
                ),
              ),
            )),
        Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                  style: kBodyFont.copyWith(
                      fontSize: 18, fontStyle: FontStyle.italic),
                  textAlign: TextAlign.center,
                  '\'RemindR\' is a simple and intuitive todo list app designed to help you stay organized and manage your tasks efficiently.\nWith its clean and minimalistic interface, it provides a streamlined experience for users to create and complete their daily tasks.'),
            )),
        Expanded(
          child: Column(
            children: [
              // IconButton(
              //     iconSize: devWidth >= 500 ? 40 : 50,
              //     onPressed: () {},
              //     icon: Icon(FontAwesomeIcons.circleChevronRight))
              FilledButton(
                  style: FilledButton.styleFrom(
                      elevation: 15,
                      backgroundColor: Colors.red.shade400,
                      fixedSize: Size(devWidth * 0.7, devHeight * 0.07)),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => WelcomeScreen()));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Continue',
                        style: kBodyFont.copyWith(fontSize: 25),
                      ),
                      Icon(
                        FontAwesomeIcons.circleChevronRight,
                        size: 28,
                      )
                    ],
                  ))
            ],
          ),
        ),
      ]),
    );
  }
}
// [Your App Name] is a simple and intuitive todo list app designed to help you stay organized and manage your tasks efficiently. 
// With its clean and minimalistic interface, it provides a streamlined experience for users to createand complete their daily tasks.