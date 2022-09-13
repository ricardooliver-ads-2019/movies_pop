import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CardMoviesSkeleton extends StatelessWidget {
  const CardMoviesSkeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaSize = MediaQuery.of(context).size;

    return Shimmer.fromColors(
      highlightColor: Colors.white,
      baseColor: Colors.grey.shade300,
      child: Column(
        children: [
          Container(
            width: mediaSize.width * 0.40,
            height: mediaSize.height * 0.30,
            constraints: const BoxConstraints(
                maxWidth: 200, minWidth: 170, minHeight: 270, maxHeight: 270),
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    height: 20,
                    width: 140,
                    color: Colors.grey,
                  ),
                  const SizedBox(
                    height: 05,
                  ),
                  Container(
                    height: 20,
                    width: 140,
                    color: Colors.grey,
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
