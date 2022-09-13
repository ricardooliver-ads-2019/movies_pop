import 'package:flutter/material.dart';

class SinopseMovie extends StatelessWidget {
  final String description;
  const SinopseMovie({Key? key, required this.description}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaSize = MediaQuery.of(context).size;
    return Container(
      width: mediaSize.width,
      margin: const EdgeInsets.all(8.0),
      constraints: const BoxConstraints(maxWidth: 800),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Sinopse:',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.start,
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            description,
            style: const TextStyle(
              color: Colors.black87,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }
}
