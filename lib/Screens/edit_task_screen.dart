import 'package:flutter/material.dart';
import 'package:flutter_springboot/model/Task.dart';
import 'package:flutter_springboot/provider/TaskData.dart';

class EditTaskScreen extends StatefulWidget {
  final Task task;
  final Taskdata taskdata;

  const EditTaskScreen({Key? key, required this.task, required this.taskdata})
      : super(key: key);

  @override
  _EditTaskScreenState createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  TextEditingController _myController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initialize the controller with the current task title
    _myController.text = widget.task.title;
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: ListView(
        children: [
          const Text(
            'Edit Task',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 30,
              color: Colors.green,
            ),
          ),
          TextField(
            controller: _myController, // Use TextEditingController to manage text
            autofocus: true,
            onChanged: (value) {
              setState(() {
                _myController.text = value;
              });
            },
          ),
          const SizedBox(height: 10),
          TextButton(
            onPressed: () {
              if (_myController.text.isNotEmpty) {
                // Update the task title
                widget.task.title = _myController.text;
                

                // Call the editTask method with the updated task
                widget.taskdata.editTask(widget.task);
                Navigator.pop(context); // Close the modal
              }
            },
            child: const Text(
              'Save',
              style: TextStyle(color: Colors.white),
            ),
            style: TextButton.styleFrom(backgroundColor: Colors.green),
          ),
        ],
      ),
    );
  }
}
