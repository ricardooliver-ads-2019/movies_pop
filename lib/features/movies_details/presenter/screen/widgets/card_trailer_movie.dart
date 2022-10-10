import 'package:flutter/material.dart';
import 'package:movies_pop/core/theme/app_colors.dart';
import 'package:movies_pop/core/theme/app_text_styles.dart';
import 'package:movies_pop/features/movies_details/domain/entities/trailer_movie_entity.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class CardTrailerMovie extends StatefulWidget {
  final List<TrailerMovieEntity> listTrailer;
  const CardTrailerMovie({Key? key, required this.listTrailer})
      : super(key: key);

  @override
  State<CardTrailerMovie> createState() => _CardTrailerMovieState();
}

class _CardTrailerMovieState extends State<CardTrailerMovie> {
  late YoutubePlayerController _controller;
  @override
  void initState() {
    super.initState();

    _controller = YoutubePlayerController(
      initialVideoId: returnKeyVideo(widget.listTrailer),
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String returnKeyVideo(List<TrailerMovieEntity> listTrailer) {
    var result = listTrailer.where((element) => element.regio == 'BR').toList();

    if (result.isEmpty) {
      return listTrailer.last.key;
    }

    return result.last.key;
  }

  @override
  Widget build(BuildContext context) {
    var mediaSize = MediaQuery.of(context).size;
    return Container(
      width: mediaSize.width,
      margin: const EdgeInsets.all(8.0),
      constraints: const BoxConstraints(maxWidth: 800),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Trailer',
            style: AppTextStyles.subTitleMovieDetails,
          ),
          const SizedBox(
            height: 10,
          ),
          Column(
            children: [
              Container(
                width: mediaSize.width,
                constraints:
                    const BoxConstraints(maxHeight: 320, minWidth: 300),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: YoutubePlayerBuilder(
                        player: YoutubePlayer(
                          controller: _controller,
                          showVideoProgressIndicator: true,
                          progressIndicatorColor: AppColors.secondary,
                        ),
                        builder: (context, player) {
                          return player;
                        }),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
