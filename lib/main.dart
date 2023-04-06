import 'package:flutter/material.dart';
import 'package:flutter_provider_todo_app/home.dart';
import 'package:flutter_provider_todo_app/provider/todo_provider.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(MultiProvider(providers: [
   ChangeNotifierProvider(create: (_)=>TodoProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage()
    );
  }
}
