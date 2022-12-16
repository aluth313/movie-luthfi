import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/common/constants.dart';
import 'package:ditonton/domain/entities/episode.dart';
import 'package:flutter/material.dart';

class EpisodeCard extends StatelessWidget {
  final Episode episode;

  const EpisodeCard({super.key, required this.episode});

  @override
  Widget build(BuildContext context) {
    String _showDuration(int runtime) {
      final int hours = runtime ~/ 60;
      final int minutes = runtime % 60;

      if (hours > 0) {
        return '${hours}h ${minutes}m';
      } else {
        return '${minutes}m';
      }
    }

    return Container(
      width: 250,
      margin: EdgeInsets.only(right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
            child: CachedNetworkImage(
              height: 150,
              width: double.infinity,
              fit: BoxFit.cover,
              imageUrl: episode.stillPath != null
                  ? 'https://image.tmdb.org/t/p/w500${episode.stillPath}'
                  : 'https://www.rrcampus.com/images/no-video.jpg',
              placeholder: (context, url) => Center(
                child: CircularProgressIndicator(),
              ),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  'Episode ${episode.episodeNumber.toString()}',
                  style: kSubtitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                _showDuration(episode.runtime ?? 0),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            episode.overview,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
