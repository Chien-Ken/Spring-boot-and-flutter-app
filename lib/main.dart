import 'package:flutter/material.dart';
import 'package:flutter_springboot/Screens/home.dart';
import 'package:flutter_springboot/provider/TaskData.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Taskdata>(
      create: (context) => Taskdata(),
      child: MaterialApp(
       debugShowCheckedModeBanner: false,
       home: HomeScreen(),
      ),
    );
  }
}




