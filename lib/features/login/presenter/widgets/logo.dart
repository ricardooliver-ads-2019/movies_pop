import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaSize = MediaQuery.of(context).size;
    return Container(
      width: mediaSize.width * 0.5,
      height: mediaSize.height * 0.20,
      constraints: const BoxConstraints(
          maxHeight: 300, minHeight: 100, maxWidth: 300, minWidth: 100),
      child: const Image(image: AssetImage('assets/images/logo.png')),
    );
  }
}
