import 'package:flutter/material.dart';

class BoxImageMovie extends StatelessWidget {
  String urlImage;
  BoxImageMovie({
    Key? key,
    required this.urlImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaSize = MediaQuery.of(context).size;
    return Container(
      width: mediaSize.width >= 300 ? mediaSize.width * 0.47 : mediaSize.width,
      height: mediaSize.height * 0.50,
      constraints: const BoxConstraints(
        maxWidth: 180,
        maxHeight: 250,
        minHeight: 230,
      ),
      decoration: BoxDecoration(
        image: DecorationImage(
            image: NetworkImage(urlImage),
            filterQuality: FilterQuality.medium,
            fit: BoxFit.fill),
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}
