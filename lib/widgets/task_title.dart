import 'package:flutter/material.dart';
import 'package:flutter_springboot/Screens/add_task_screen.dart';
import 'package:flutter_springboot/Screens/edit_task_screen.dart';
import 'package:flutter_springboot/model/Task.dart';
import 'package:flutter_springboot/provider/TaskData.dart';

class TaskTile extends StatefulWidget {
  
  final Task task;
  final Taskdata tasksData;

  const TaskTile({Key? key, required this.task, required this.tasksData})
      : super(key: key);

  @override
  State<TaskTile> createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Checkbox(
          activeColor: Colors.green,
          value: widget.task.done,
          onChanged: (checkbox) {
            widget.tasksData.upDateTask(widget.task);
          },
        ),
        title: Text(
          widget.task.title,
          style: TextStyle(
            decoration:
                widget.task.done ? TextDecoration.lineThrough : TextDecoration.none,
          ),
        ),
        trailing: SizedBox(
          width: 250, // Set width to prevent overflow
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end, // Align buttons properly
            children: [
              ElevatedButton(
                onPressed: () {
                   showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return  EditTaskScreen(task: widget.task, taskdata: widget.tasksData);
                    });

                },
                child: const Text('Edit'),
              ),
              IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  widget.tasksData.deleteTask(widget.task.id);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}