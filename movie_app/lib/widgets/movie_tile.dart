import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/features/movie_details/details_screen.dart';
import 'package:movie_app/models/movie_model.dart';

class MovieSuggestionTile extends StatelessWidget {
  final MovieModel movie;

  const MovieSuggestionTile({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: movie.posterUrl.isNotEmpty
          ? CachedNetworkImage(
              imageUrl: movie.posterUrl,
              width: 50,
              height: 75,
              fit: BoxFit.cover,
              placeholder: (context, url) =>
                  Container(width: 50, height: 75, color: Colors.grey[300]),
              errorWidget: (context, url, error) => Container(
                width: 50,
                height: 75,
                color: Colors.grey[300],
                child: const Icon(Icons.movie),
              ),
            )
          : Container(
              width: 50,
              height: 75,
              color: Colors.grey[300],
              child: const Icon(Icons.movie),
            ),
      title: Text(
        movie.title,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (movie.releaseDate.isNotEmpty)
            Text('Release: ${movie.releaseDate.substring(0, 4)}'),
          Row(
            children: [
              const Icon(Icons.star, size: 16, color: Colors.amber),
              const SizedBox(width: 4),
              Text(movie.voteAverage.toStringAsFixed(1)),
            ],
          ),
        ],
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                DetailsScreen(movie: movie, movieId: movie.movieId),
          ),
        );
      },
    );
  }
}
