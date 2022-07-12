import 'package:flutter/material.dart';
import 'package:movies_pop/core/dependencies/get_it/dependencies.dart';

void main() {
  getItDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: null);
  }
}
