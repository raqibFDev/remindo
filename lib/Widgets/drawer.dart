// ignore_for_file: must_be_immutable

import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:remindo/constants/stylingFonts.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/networking.dart';
import '../screens/welcomeScreen.dart';

class SideBar extends StatefulWidget {
  const SideBar({super.key});

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();

    getUsername();
  }

  @override
  Widget build(BuildContext context) {
    print(name);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Drawer(
        width: devWidth > 500 ? devWidth * 0.45 : devWidth * 0.65,
        elevation: 30,
        backgroundColor: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
                topRight: Radius.circular(24),
                bottomRight: Radius.circular(24)),
            color: kMainColor,
          ),
          height: double.infinity,
          child: SafeArea(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // SizedBox(height: devHeight * 0.03),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      IconButton(
                          iconSize: devWidth > 500 ? 40 : 30,
                          padding: const EdgeInsets.only(right: 20),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(FontAwesomeIcons.circleChevronRight,
                              color: Colors.black54))
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: CircleAvatar(
                      backgroundColor: Colors.white60,
                      radius: devWidth >= 500 ? 130 : 90,
                      child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: devWidth >= 500 ? 120 : 84,
                          backgroundImage: profileImagePath != null
                              ? FileImage(File(profileImagePath!))
                              : null),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      'Hey  \'$name\'',
                      style: devWidth > 500
                          ? kAppBar.copyWith(fontSize: 30)
                          : kAppBar.copyWith(fontSize: 25),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: Text(
                      'It\'s A Good Day ToDo Something !',
                      style: kBodyFont.copyWith(fontSize: 18, letterSpacing: 1),
                    ),
                  ),
                  SizedBox(height: devHeight * 0.04),
                  Padding(
                    padding: const EdgeInsets.only(top: 50.0),
                    child: Text(
                      'Contact  Developer',
                      style: kAppBar.copyWith(fontSize: 25, letterSpacing: .3),
                    ),
                  ),
                  SizedBox(height: devWidth > 500 ? 5 : devHeight * 0.045),
                  // Slider Starts Here
                  CarouselSlider(
                      items: [
                        //GitHub
                        Slider(
                          icon: FontAwesomeIcons.github,
                          iconSize: 70,
                          text: 'GitHub',
                          function: () {
                            setState(() {
                              launchGithub(context);
                            });
                          },
                        ),

                        //Instagram
                        Slider(
                          icon: FontAwesomeIcons.instagram,
                          iconSize: 65,
                          text: 'Instagram',
                          function: () {
                            setState(() {
                              launchGithub(context);
                            });
                          },
                        ),

                        //LinkedIn
                        Slider(
                          icon: FontAwesomeIcons.linkedin,
                          iconSize: 65,
                          text: 'LinkedIn',
                          function: () {
                            print('Button Hit');
                            setState(() {
                              launchLinkedin(context);
                            });
                          },
                        ),
                      ],
                      options: CarouselOptions(
                        enlargeFactor: 1,
                        height:
                            devWidth > 500 ? devHeight * 0.1 : devHeight * 0.15,
                        autoPlay: true,
                      )),

                  SizedBox(height: devHeight * 0.1),

                  // Share This
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(16)),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            Share.share(
                                'https://play.google.com/store/apps/details?id=com.raakib.tictactoe');
                          });
                        },
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Share This App',
                                style: kAppBar.copyWith(fontSize: 18),
                              ),
                              SizedBox(width: devWidth * 0.04),
                              const Icon(
                                FontAwesomeIcons.share,
                                color: Colors.black,
                              ),
                            ]),
                      ),
                    ),
                  ),
                  SizedBox(
                      height: devWidth >= 500
                          ? devHeight * 0.12
                          : devHeight * 0.05),

                  // ListView(
                  //   shrinkWrap: true,
                  //   children:
                  // )
                ]),
          ),
        ),
      ),
    );
  }
}

class Slider extends StatelessWidget {
  late String text;
  late VoidCallback function;
  late IconData icon;
  late double iconSize;

  Slider(
      {required this.text,
      required this.icon,
      required this.iconSize,
      required this.function});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: GestureDetector(
        onTap: function,
        child: Container(
          width: devWidth * .7,
          decoration: BoxDecoration(
            color: Colors.white60,
            border: Border.all(color: Colors.black54, width: 3),
            borderRadius: BorderRadius.circular(22),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(
                icon,
                size: iconSize,
              ),
              Text(
                text,
                style: kDrawerButtonFont,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Github
// Padding(
//   padding: const EdgeInsets.symmetric(horizontal: 15.0),
//   child: Container(
//     decoration: BoxDecoration(
//       border: Border.all(color: Colors.white, width: 3),
//       borderRadius: BorderRadius.circular(22),
//     ),
//     child: GestureDetector(
//       onTap: () {
//         setState(() {
//           launchGithub(context);
//         });
//       },
//       child: const ListTile(
//         leading: Text(
//           'Github',
//           style: kDrawerButtonFont,
//         ),
//         trailing: Icon(
//           FontAwesomeIcons.github,
//           color: Colors.black,
//         ),
//       ),
//     ),
//   ),
// ),
// SizedBox(height: devHeight * 0.02),

// // Instagram
// Padding(
//   padding: const EdgeInsets.symmetric(horizontal: 15.0),
//   child: Container(
//     decoration: BoxDecoration(
//       border: Border.all(color: Colors.white, width: 3),
//       borderRadius: BorderRadius.circular(22),
//     ),
//     child: GestureDetector(
//       onTap: () {
//         setState(() {
//           launchInstagram(context);
//         });
//       },
//       child: const ListTile(
//         leading: Text(
//           'Instagram',
//           style: kDrawerButtonFont,
//         ),
//         trailing: Icon(
//           FontAwesomeIcons.instagram,
//           color: Colors.black,
//         ),
//       ),
//     ),
//   ),
// ),

// // LinkedIn

// SizedBox(height: devHeight * 0.02),

// // Instagram
// Padding(
//   padding: const EdgeInsets.symmetric(horizontal: 15.0),
//   child: Container(
//     decoration: BoxDecoration(
//       border: Border.all(color: Colors.white, width: 3),
//       borderRadius: BorderRadius.circular(22),
//     ),
//     child: GestureDetector(
//       onTap: () {
//         setState(() {
//           launchLinkedin(context);
//         });
//       },
//       child: const ListTile(
//         leading: Text(
//           'LinkedIn',
//           style: kDrawerButtonFont,
//         ),
//         trailing: Icon(
//           FontAwesomeIcons.linkedin,
//           color: Colors.black,
//         ),
//       ),
//     ),
//   ),
// ),
