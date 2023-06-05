// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:remindo/constants/stylingFonts.dart';
import 'package:remindo/models/task.dart';

import '../screens/mainPage.dart';

DateTime now = DateTime.now();

String convertedDateTime =
    "${now.day.toString()}-${now.month.toString().padLeft(2, '0')}-${now.year.toString().padLeft(2, '0')} ${now.hour.toString().padLeft(2, '0')}-${now.minute.toString().padLeft(2, '0')}";

class ListWidget extends StatefulWidget {
  const ListWidget({super.key});

  @override
  State<ListWidget> createState() => _ListWidgetState();
}

class _ListWidgetState extends State<ListWidget> {
  @override
  Widget build(BuildContext context) {
    List tasksList = box!.values.toList();
    // Task newTask =
    //     Task(taskName: 'Eat Pizza', timeStamp: DateTime.now(), taskDone: false);
    // box?.add(newTask.taskToMap());
    return ListView.builder(
      itemBuilder: (context, index) {
        var task = Task.fromMap(tasksList[index]);
        return Padding(
          padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 15),
          child: Container(
            decoration: BoxDecoration(
              color: task.taskDone ? Colors.red.shade100 : Colors.lime.shade100,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                  color: task.taskDone
                      ? Colors.red.shade200
                      : Colors.lime.shade500,
                  width: 2),
            ),
            child: ListTile(
              subtitleTextStyle: kSubtitleFont,
              title: Text(
                task.taskName,
                style: kBodyFont.copyWith(
                    decoration: task.taskDone
                        ? TextDecoration.lineThrough
                        : TextDecoration.none),
              ),
              subtitle: Text(task.timeStamp.toString()),
              onTap: () {
                task.taskDone = !task.taskDone;

                box!.putAt(index, task.taskToMap());

                setState(() {});
              },
              trailing: !task.taskDone
                  ? IconButton(
                      color: Colors.black38,
                      icon: const Icon(FontAwesomeIcons.solidCircleCheck),
                      onPressed: () {},
                    )
                  : IconButton(
                      onPressed: () {
                        box!.deleteAt(index);
                        setState(() {});
                      },
                      icon: const Icon(
                        FontAwesomeIcons.trash,
                        color: Colors.black54,
                      )),
            ),
          ),
        );
      },
      itemCount: tasksList.length,
    );

    // ListView(
    //   children: [

    //   ],
    // );
  }
}
