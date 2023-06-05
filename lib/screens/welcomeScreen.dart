import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:remindo/constants/stylingFonts.dart';
import 'package:remindo/screens/mainPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';
import '../models/networking.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

File? imageFile;
SharedPreferences? preferences;
String? profileImagePath;
var deviceSize;
var devHeight;
var devWidth;
late String name = '';
TextEditingController username = TextEditingController();

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    getFromGallery() async {
      PickedFile? pickedFile = await ImagePicker().getImage(
        source: ImageSource.gallery,
        maxWidth: 1800,
        maxHeight: 1800,
      );
      if (pickedFile != null) {
        setState(() {
          imageFile = File(pickedFile.path);
          profileImagePath = pickedFile.path;
        });

        preferences?.setString('profileImagePath', profileImagePath!);
      }
    }

    Future<void> loadProfileImage() async {
      preferences = await SharedPreferences.getInstance();
      setState(() {
        profileImagePath = preferences?.getString('profileImagePath');
      });
    }

    deviceSize = MediaQuery.of(context).size;
    devHeight = deviceSize.height;
    devWidth = deviceSize.width;
    return Scaffold(
      backgroundColor: Colors.lime.shade500,
      body: SafeArea(
          child: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                devWidth >= 500
                    ? SizedBox(height: devHeight * 0.2)
                    : SizedBox(height: devHeight * 0.08),
                Stack(children: [
                  CircleAvatar(
                    backgroundColor: Colors.white60,
                    radius: devWidth >= 500 ? 130 : 100,
                    child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: devWidth >= 500 ? 120 : 90,
                        backgroundImage: profileImagePath != null
                            ? FileImage(File(profileImagePath!))
                            : null),
                  ),
                  Positioned(
                      left: devWidth >= 500 ? devWidth * 0.25 : devWidth * 0.35,
                      top:
                          devWidth >= 500 ? devHeight * 0.14 : devHeight * 0.17,
                      child: CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.red.shade400,
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              getFromGallery();
                            });
                          },
                          icon: Icon(
                            size: devWidth >= 500 ? 20 : 20,
                            FontAwesomeIcons.pencil,
                            color: Colors.white,
                          ),
                        ),
                      ))
                ]),
                devWidth >= 500
                    ? SizedBox(height: devHeight * 0.2)
                    : SizedBox(height: devHeight * 0.1),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal:
                          devWidth > 500 ? devWidth * 0.1 : devWidth * 0.05),
                  child: TextFormField(
                    style: kBodyFont.copyWith(
                      color: Colors.red.shade400,
                    ),
                    controller: username,
                    cursorColor: Colors.red.shade400,
                    decoration: InputDecoration(
                        hintText: 'Enter Name',
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 2,
                              color: Colors.red.shade400,
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(18))),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 2,
                              color: Colors.red.shade400,
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(18)))),
                  ),
                ),
                SizedBox(height: devHeight * 0.03),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                          horizontal: devWidth >= 500
                              ? devWidth * 0.06
                              : devWidth * 0.08,
                          vertical: devWidth >= 500
                              ? devHeight * 0.01
                              : devHeight * 0.01),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18)),
                      backgroundColor: Colors.red.shade400,
                      elevation: 15,
                    ),
                    onPressed: () async {
                      name = username.text.toString().trim();
                      await saveUsername(name);
                      await loadProfileImage();
                      prefs.setBool('isFirstLaunch', false);
                      print('Username Set : $name');
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (_) => const MainPage()));
                    },
                    child:
                        Text('Submit', style: kAppBar.copyWith(fontSize: 20))),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
