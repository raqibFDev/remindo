import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../screens/welcomeScreen.dart';

final Uri githubURL = Uri.parse('https://github.com/hacker0id');

final Uri instaURL = Uri.parse('https://www.instagram.com/raakibzargar/');

final Uri linkedinURL = Uri.parse(
    'https://in.linkedin.com/in/raqib-zargar-47b7a0164?trk=public_profile_browsemap&original_referer=https%3A%2F%2Fwww.google.com%2F');

// void launchGithub(context) async {
//   const url = 'https://github.com/hacker0id'; // Replace with your desired URL
//   if (await canLaunch(url)) {
//     await launch(url);
//   } else {}
// }

Future<void> launchGithub(context) async {
  if (!await launchUrl(
    githubURL,
    mode: LaunchMode.externalApplication,
  )) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Text('Log In Successful !'),
      backgroundColor: Colors.purple.shade900.withOpacity(.7),
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 2),
    ));
  }
}

Future<void> launchInstagram(context) async {
  if (!await launchUrl(
    instaURL,
    mode: LaunchMode.externalApplication,
  )) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Text('Log In Successful !'),
      backgroundColor: Colors.purple.shade900.withOpacity(.7),
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 2),
    ));
  }
}

Future<void> launchLinkedin(context) async {
  if (!await launchUrl(
    linkedinURL,
    mode: LaunchMode.externalApplication,
  )) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Text('Log In Successful !'),
      backgroundColor: Colors.purple.shade900.withOpacity(.7),
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 2),
    ));
  }
}

// Save Username
Future saveUsername(String username) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('username', name);
}

//Get Username

Future<String> getUsername() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String username = prefs.getString('username').toString();
  return username;
}
