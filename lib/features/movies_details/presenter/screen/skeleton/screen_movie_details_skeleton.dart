import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ScreenMovieDetailsSkeleton extends StatelessWidget {
  const ScreenMovieDetailsSkeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaSize = MediaQuery.of(context).size;

    return Shimmer.fromColors(
      highlightColor: Colors.white,
      baseColor: Colors.grey.shade300,
      child: Center(
        child: SingleChildScrollView(
          child: Container(
            constraints: const BoxConstraints(
              maxWidth: 800,
            ),
            width: mediaSize.width,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: mediaSize.width >= 300
                                ? mediaSize.width * 0.47
                                : mediaSize.width,
                            height: mediaSize.height * 0.50,
                            constraints: const BoxConstraints(
                              maxWidth: 180,
                              maxHeight: 250,
                              minHeight: 230,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  height: 30,
                                  width: 170,
                                  color: Colors.grey,
                                ),
                                const SizedBox(
                                  height: 05,
                                ),
                                Container(
                                  height: 20,
                                  width: 155,
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
                                const SizedBox(
                                  height: 05,
                                ),
                                Container(
                                  height: 20,
                                  width: 140,
                                  color: Colors.grey,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  width: 140,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(
                                        height: 30,
                                        width: 30,
                                        decoration: BoxDecoration(
                                          color: Colors.grey,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                      Container(
                                        height: 30,
                                        width: 30,
                                        decoration: BoxDecoration(
                                          color: Colors.grey,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                      Container(
                                        height: 30,
                                        width: 30,
                                        decoration: BoxDecoration(
                                          color: Colors.grey,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: mediaSize.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          color: Colors.grey,
                          width: 70,
                          height: 25,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 20,
                          width: mediaSize.width * 0.90,
                          color: Colors.grey,
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Container(
                          height: 20,
                          width: mediaSize.width * 0.90,
                          color: Colors.grey,
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Container(
                          height: 20,
                          width: mediaSize.width * 0.80,
                          color: Colors.grey,
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Container(
                          height: 20,
                          width: mediaSize.width * 0.60,
                          color: Colors.grey,
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    //Card de imagens
                    width: mediaSize.width,
                    height: 230,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 10,
                      itemBuilder: ((context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 5),
                          child: Container(
                            width: mediaSize.width >= 300
                                ? mediaSize.width * 0.47
                                : mediaSize.width,
                            height: mediaSize.height * 0.50,
                            constraints: const BoxConstraints(
                              maxWidth: 180,
                              maxHeight: 250,
                              minHeight: 230,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    color: Colors.grey,
                    width: 70,
                    height: 25,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    //Card de Trailler
                    width: mediaSize.width,
                    height: 230,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 10,
                      itemBuilder: ((context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 5),
                          child: Container(
                            width: mediaSize.width >= 300
                                ? mediaSize.width * 0.47
                                : mediaSize.width,
                            height: mediaSize.height * 0.50,
                            constraints: const BoxConstraints(
                              minWidth: 300,
                              maxWidth: 400,
                              maxHeight: 150,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
