import 'package:flutter/material.dart';

class WatchedMoviesScreen extends StatefulWidget {
  const WatchedMoviesScreen({Key? key}) : super(key: key);

  @override
  State<WatchedMoviesScreen> createState() => _WatchedMoviesScreenState();
}

class _WatchedMoviesScreenState extends State<WatchedMoviesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: const Center(
        child: Text('watched_Movies_Screen'),
      ),
    );
  }
}
