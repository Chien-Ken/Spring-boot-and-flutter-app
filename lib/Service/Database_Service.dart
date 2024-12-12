import 'dart:convert';

import 'package:flutter_springboot/Service/global.dart';
import 'package:flutter_springboot/model/Task.dart';
import 'package:http/http.dart' as http;

class DatabaseService {
  static Future<Task>addTask (String title) async {
     Map data = {
      "title": title,
    };
    var body = json.encode(data);
    var url = Uri.parse(baseUrl + '/add');

    http.Response response = await http.post(
      url,
      headers: headers,
      body: body,
    );
    print(response.body);
    Map responseMap = jsonDecode(response.body);
    Task task = Task.fromMap(responseMap);

    return task;
  }

  static Future<List<Task>> getTasks() async {
    var url = Uri.parse(baseUrl);
    http.Response response = await http.get(
      url,
      headers: headers,
    );
    print(response.body);
    List responseList = jsonDecode(response.body);
    print('Response list: $responseList');
print('Type of responseList: ${responseList.runtimeType}');
    List<Task> tasks = [];
    for (Map taskMap in responseList) {
      Task task = Task.fromMap(taskMap);
      tasks.add(task);
    }
    return tasks;
  }

  
static Future<Task?> editTask(Task task) async {
    // Convert the Task object to a map for sending to the backend
    Map<String, dynamic> data = {
      "title": task.title
      
    };

    var body = json.encode(data);

    // Use the task's id in the URL
    var url = Uri.parse(baseUrl + '/edit/${task.id}');

    // Send a PUT request to the back-end with the updated data
    http.Response response = await http.put(
      url,
      headers: headers,
      body: body,
    );

    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      Map responseMap = jsonDecode(response.body);
      Task updatedTask = Task.fromMap(responseMap);
      return updatedTask;
    } else {
      print("Failed to edit task: ${response.statusCode}");
      return null;
    }
  }



 // Delete task function
  static Future<void> deleteTask(int id) async {
    var url = Uri.parse(baseUrl + '/delete/$id');

    http.Response response = await http.delete(
      url,
      headers: headers,
    );

    if (response.statusCode == 200) {
      print('Task deleted successfully');
    } else {
      print('Failed to delete the task: ${response.statusCode}');
    }
  }



}