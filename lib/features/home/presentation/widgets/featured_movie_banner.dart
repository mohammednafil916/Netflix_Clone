import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:netflix_clone/features/home/domain/entities/movie.dart';

class FeaturedMovieBanner extends StatelessWidget {
  final Movie movie;

  const FeaturedMovieBanner({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 420,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Movie backdrop
          if (movie.backdropPath != null)
            CachedNetworkImage(
              imageUrl: 'https://image.tmdb.org/t/p/w780${movie.backdropPath}',
              fit: BoxFit.cover,
            )
          else
            Container(color: Colors.grey.shade900),

          // Dark gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, Colors.black54, Colors.black],
              ),
            ),
          ),

          // Movie information
          Positioned(
            bottom: 30,
            left: 20,
            right: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'FEATURED MOVIE',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),

                SizedBox(height: 10),

                Text(
                  movie.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 8),

                Text(
                  movie.overview,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.white70, fontSize: 13),
                ),

                SizedBox(height: 12),

                Text(
                  '⭐ ${movie.rating.toStringAsFixed(1)}',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
