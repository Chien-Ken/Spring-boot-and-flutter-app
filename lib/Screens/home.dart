import 'package:flutter/material.dart';
import 'package:flutter_springboot/Screens/add_task_screen.dart';
import 'package:flutter_springboot/Service/Database_Service.dart';
import 'package:flutter_springboot/model/Task.dart';
import 'package:flutter_springboot/provider/TaskData.dart';
import 'package:flutter_springboot/widgets/task_title.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Task>? tasks;

 getTasks() async {
    tasks = await DatabaseService.getTasks();
    Provider.of<Taskdata>(context, listen: false).tasks = tasks!;
    setState(() {
    tasks = tasks; // This is to ensure that the screen gets updated initially
  });
  }


  @override
  void initState() {
    super.initState();
    getTasks();
  }

 
  @override
  Widget build(BuildContext context) {
    
    return tasks == null
        ? const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              title: Text(
                'Todo Tasks (${Provider.of<Taskdata>(context).tasks.length})',
              ),
              centerTitle: true,
              backgroundColor: Colors.green,
            ),
            body: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Consumer<Taskdata>(
                builder: (context, tasksData, child) {
                  return ListView.builder(
                      itemCount: tasksData.tasks.length,
                      itemBuilder: (context, index) {
                        Task task = tasksData.tasks[index];
                        return TaskTile(
                          task: task,
                          tasksData: tasksData,
                        );
                      });
                },
              ),
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.green,
              child: const Icon(
                Icons.add,
              ),
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return const AddTaskScreen();
                    });
              },
            ),
          );
  }
}