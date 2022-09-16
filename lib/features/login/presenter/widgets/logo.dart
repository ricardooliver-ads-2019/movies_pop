import 'package:flutter/material.dart';
import 'package:movies_pop/core/theme/app_images.dart';

class Logo extends StatelessWidget {
  const Logo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaSize = MediaQuery.of(context).size;
    return Container(
      width: mediaSize.width * 0.5,
      height: mediaSize.height * 0.20,
      constraints: const BoxConstraints(
        maxHeight: 300,
        minHeight: 170,
        maxWidth: 300,
        minWidth: 170,
      ),
      child: const Image(image: AssetImage(AppImages.logo)),
    );
  }
}
