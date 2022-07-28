import 'dart:async';

import 'package:asuka/asuka.dart' as asuka;
import 'package:flutter/material.dart';
import 'package:movies_pop/core/dependencies/get_it/dependencies.dart';
import 'package:movies_pop/core/routes/app_routes.dart';
import 'package:movies_pop/core/theme/color_schemes.dart';

void main() {
  runZonedGuarded(() async {
    await getItDependencies();
    runApp(const MyApp());
  }, (Object error, StackTrace stackTrace) {
    debugPrint(error.toString());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        builder: asuka.builder,
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
        darkTheme: ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
        initialRoute: '/main_navigation_page',
        onGenerateRoute: AppRoutes.onGenerateRoute);
  }
}
