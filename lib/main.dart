import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:remindo/screens/mainPage.dart';
import 'package:remindo/screens/splash/splashScreen1.dart';
import 'package:shared_preferences/shared_preferences.dart';

// void main() async {
//   await Hive.initFlutter('hive_boxes');
//   runApp(const MaterialApp(home: Main()));
// }
late SharedPreferences prefs;
void main() async {
  await Hive.initFlutter('hive_boxes');
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();
  bool isFirstLaunch = prefs.getBool('isFirstLaunch') ?? true;

  runApp(MaterialApp(home: Main(isFirstLaunch: isFirstLaunch)));
}

class Main extends StatelessWidget {
  final bool isFirstLaunch;

  const Main({Key? key, required this.isFirstLaunch}) : super(key: key);

  Widget build(BuildContext context) {
    return isFirstLaunch ? SplashOne() : MainPage();
  }
}
