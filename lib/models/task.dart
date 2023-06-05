class Task {
  String taskName;
  DateTime timeStamp;
  bool taskDone;
  Task(
      {required this.taskName,
      required this.timeStamp,
      required this.taskDone});

  factory Task.fromMap(Map task) {
    return Task(
        taskName: task['Task Name'],
        timeStamp: task['Date Time'],
        taskDone: task['Task Done']);
  }

  Map taskToMap() {
    return {
      'Task Name': taskName,
      'Date Time': timeStamp,
      'Task Done': taskDone
    };
  }
}
