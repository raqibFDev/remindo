// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';
import 'package:remindo/Widgets/drawer.dart';
import 'package:remindo/Widgets/listWidget.dart';
import 'package:remindo/constants/stylingFonts.dart';
import 'package:remindo/models/networking.dart';
import 'package:remindo/models/task.dart';

import 'welcomeScreen.dart';

late Size deviceSize;
String? newTaskName;
Box? box;

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

final GlobalKey<ScaffoldState> mainPage = GlobalKey();

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    deviceSize = MediaQuery.of(context).size;
    devHeight = deviceSize.height;
    devWidth = deviceSize.width;
    List<Widget> appBarItems = [
      IconButton(
        padding: EdgeInsets.only(right: 20),
        iconSize: devWidth > 500 ? 40 : 30,
        onPressed: () {
          getUsername();
          mainPage.currentState!.openEndDrawer();
        },
        icon: Icon(FontAwesomeIcons.circleChevronLeft),
      )
    ];

    return Scaffold(
        key: mainPage,
        endDrawer: SideBar(),
        floatingActionButton: FloatingActionButton.extended(
          elevation: 10,
          backgroundColor: Colors.red.shade400,
          onPressed: () {
            displayPopUp(context);
          },
          label: Text(
            'Add Task !',
            style: devWidth > 500
                ? kAppBarTablet.copyWith(fontSize: 25)
                : kAppBar.copyWith(fontSize: 20),
          ),
        ),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: devHeight * 0.15,
          backgroundColor: kMainColor,
          title:
              Text('RemindR', style: devWidth > 500 ? kAppBarTablet : kAppBar),
          actions: appBarItems,
        ),
        body: taskView());
  }

  Widget taskView() {
    return FutureBuilder(
      future: Hive.openBox('Tasks'),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          box = snapshot.data;
          return ListWidget();
        } else {
          return Center(
              child: SizedBox(
            height: 50,
            width: 50,
            child: CircularProgressIndicator(
              strokeWidth: 8,
              color: kMainColor,
            ),
          ));
        }
      },
    );
  }

  void displayPopUp(context) {
    showDialog(
        context: context,
        builder: ((context) => AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18)),
              backgroundColor: Colors.lime.shade500,
              title: Center(
                child: Text(
                  'Add New Task!',
                  style: kBodyFont.copyWith(fontSize: 30),
                ),
              ),
              content: TextField(
                cursorColor: Colors.black,
                style: kBodyFont,
                decoration: InputDecoration(
                    hintStyle: kBodyFont.copyWith(fontSize: 20),
                    hintText: 'Enter Name',
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2),
                        borderRadius: BorderRadius.all(Radius.circular(18))),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2),
                        borderRadius: BorderRadius.all(Radius.circular(18)))),
                onSubmitted: (_) {
                  if (newTaskName != null) {
                    var tsk = Task(
                      taskName: newTaskName!,
                      timeStamp: DateTime.now(),
                      taskDone: false,
                    );
                    box!.add(tsk.taskToMap());
                    setState(() {
                      newTaskName = null;
                      Navigator.pop(context);
                    });
                  }
                },
                onChanged: (value) {
                  setState(() {
                    newTaskName = value;
                  });
                },
              ),
            )));
  }
}
