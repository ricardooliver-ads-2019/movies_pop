import 'package:flutter/material.dart';
import 'package:movies_pop/features/watch_movies/widgets/stars.dart';

class WatchMoviesScreen extends StatefulWidget {
  const WatchMoviesScreen({Key? key}) : super(key: key);

  @override
  State<WatchMoviesScreen> createState() => _WatchMoviesScreenState();
}

class _WatchMoviesScreenState extends State<WatchMoviesScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: Center(
          child: Stars(
        value: 6.3 / 2,
        color: Colors.yellow.shade800,
        size: 20,
      )),
    );
  }
}
