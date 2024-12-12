import 'package:flutter/material.dart';
import 'package:flutter_springboot/provider/TaskData.dart';
import 'package:flutter_springboot/widgets/task_title.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({Key? key}) : super(key: key);

  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  TextEditingController _controller = TextEditingController();
  String taskTitle = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: ListView(
        children: [
          const Text(
            'Add Task',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 30,
              color: Colors.green,
            ),
          ),
          TextField(
            autofocus: true,
            controller: _controller,
            onChanged: (val) {
              setState(() {
                taskTitle = val;  // Directly assigning the input value to taskTitle
              });
            },
              style: GoogleFonts.roboto(),  // Use Roboto font in the TextField
            decoration: InputDecoration(labelText: 'Enter task'),
          ),
          const SizedBox(height: 10),
          TextButton(
            onPressed: () {
              if (taskTitle.isNotEmpty) {
                Provider.of<Taskdata>(context, listen: false)
                    .addTask(taskTitle);
                Navigator.pop(context);
              }
            },
            child: const Text(
              'Add',
              style: TextStyle(color: Colors.white),
            ),
            style: TextButton.styleFrom(backgroundColor: Colors.green),
          ),
        ],
      ),
    );
  }
}
