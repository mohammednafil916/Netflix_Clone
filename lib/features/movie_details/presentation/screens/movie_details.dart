import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:netflix_clone/features/movie_details/presentation/providers/movie_details_provider.dart';

class MovieDetailsScreen extends ConsumerWidget {
  final int movieId;

  const MovieDetailsScreen({super.key, required this.movieId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final movieState = ref.watch(movieDetailsProvider(movieId));

    return Scaffold(
      backgroundColor: Colors.black,
      body: movieState.when(
        loading: () {
          return Center(child: CircularProgressIndicator(color: Colors.red));
        },

        error: (error, stackTrace) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error_outline, color: Colors.red, size: 40),
                SizedBox(height: 12),
                Text(
                  'Failed to load movie details',
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () {
                    ref.invalidate(movieDetailsProvider(movieId));
                  },
                  child: Text('Retry'),
                ),
              ],
            ),
          );
        },

        data: (movie) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Backdrop Image
                Stack(
                  children: [
                    SizedBox(
                      height: 280,
                      width: double.infinity,
                      child: movie.backdropPath != null
                          ? CachedNetworkImage(
                              imageUrl:
                                  'https://image.tmdb.org/t/p/w780${movie.backdropPath}',
                              fit: BoxFit.cover,
                            )
                          : Container(color: Colors.grey.shade900),
                    ),

                    Positioned(
                      top: 40,
                      left: 16,
                      child: IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(Icons.arrow_back, color: Colors.white),
                      ),
                    ),
                  ],
                ),

                // Movie Information
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        movie.title,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      SizedBox(height: 8),

                      if (movie.tagline != null && movie.tagline!.isNotEmpty)
                        Text(
                          movie.tagline!,
                          style: TextStyle(
                            color: Colors.grey,
                            fontStyle: FontStyle.italic,
                          ),
                        ),

                      SizedBox(height: 16),

                      Text(
                        "⭐ ${movie.rating.toStringAsFixed(1)}  •  ${movie.releaseDate}  •  ${movie.runtime ?? 'N/A'} min",
                        style: TextStyle(color: Colors.grey, fontSize: 13),
                      ),

                      SizedBox(height: 12),

                      Text(
                        movie.genres.join(" • "),
                        style: TextStyle(color: Colors.white70, fontSize: 14),
                      ),

                      SizedBox(height: 24),

                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () {},
                          icon: Icon(Icons.play_arrow),
                          label: Text("Play"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.all(14),
                          ),
                        ),
                      ),

                      SizedBox(height: 24),

                      Text(
                        "Overview",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      SizedBox(height: 10),

                      Text(
                        movie.overview.isNotEmpty
                            ? movie.overview
                            : "No description available.",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 15,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
