import 'package:flutter/material.dart';
import 'package:movies_pop/core/theme/app_text_styles.dart';

class SinopseMovie extends StatelessWidget {
  final String description;
  const SinopseMovie({Key? key, required this.description}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaSize = MediaQuery.of(context).size;
    return Container(
      width: mediaSize.width,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      constraints: const BoxConstraints(maxWidth: 800),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Sinopse:',
            style: AppTextStyles.subTitleMovieDetails,
            textAlign: TextAlign.start,
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            description,
            style: AppTextStyles.sinopseDescription,
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }
}
