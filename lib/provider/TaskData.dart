
import 'package:flutter/material.dart';
import 'package:flutter_springboot/Service/Database_Service.dart';
import 'package:flutter_springboot/model/Task.dart';

class Taskdata extends ChangeNotifier {
  List<Task>tasks = [];

  void addTask (String taskTitle) async {
    Task task = await DatabaseService.addTask(taskTitle);
    tasks.add(task);
    notifyListeners();
  }

  void upDateTask (Task task) {
    task.Toggle();
    notifyListeners();
  }

   // Edit task by finding it in the list and updating it
  void editTask(Task task) async {
  Task? editedTask = await DatabaseService.editTask(task);
  print("Edited Task: ${editedTask?.title}");
  
  if (editedTask != null) {
    int taskIndex = tasks.indexWhere((t) => t.id == task.id);
    if (taskIndex != -1) {
      tasks[taskIndex] = editedTask; // Update the task in the list
      notifyListeners(); // Notify listeners to rebuild the UI
    }
  }
}


  
  void deleteTask(int id) async {
  await DatabaseService.deleteTask(id);
  tasks.removeWhere((task) => task.id == id); // Remove task by ID
  notifyListeners();
}


}