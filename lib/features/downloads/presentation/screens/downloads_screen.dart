import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:netflix_clone/features/downloads/presentation/providers/downloads_provider.dart';
import 'package:go_router/go_router.dart';

class DownloadsScreen extends ConsumerWidget {
  const DownloadsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final downloadsState = ref.watch(downloadsProvider);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "Downloads",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),

      body: downloadsState.when(
        loading: () {
          return Center(child: CircularProgressIndicator(color: Colors.red));
        },

        error: (error, stackTrace) {
          return Center(
            child: Text(
              "Something went wrong: $error",
              style: TextStyle(color: Colors.white),
            ),
          );
        },

        data: (movies) {
          if (movies.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.download_outlined, color: Colors.grey, size: 70),
                  SizedBox(height: 16),
                  Text(
                    "No downloads yet",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Movies you save will appear here.",
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: EdgeInsets.all(16),
            itemCount: movies.length,
            itemBuilder: (context, index) {
              final movie = movies[index];

              return Padding(
                padding: EdgeInsets.only(bottom: 16),
                child: InkWell(
                  onTap: () {
                    context.push('/movie/${movie.id}');
                  },
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: movie.posterPath != null
                            ? CachedNetworkImage(
                                imageUrl:
                                    'https://image.tmdb.org/t/p/w200${movie.posterPath}',
                                width: 90,
                                height: 125,
                                fit: BoxFit.cover,
                              )
                            : Container(
                                width: 90,
                                height: 125,
                                color: Colors.grey.shade900,
                                child: Icon(Icons.movie, color: Colors.white),
                              ),
                      ),

                      SizedBox(width: 14),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              movie.title,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 6),
                            Text(
                              movie.releaseDate.isEmpty
                                  ? "Release date unavailable"
                                  : movie.releaseDate,
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 13,
                              ),
                            ),
                            SizedBox(height: 6),
                            Text(
                              '⭐ ${movie.rating.toStringAsFixed(1)}',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),

                      IconButton(
                        onPressed: () {
                          ref
                              .read(downloadsProvider.notifier)
                              .removeMovie(movie.id);
                        },
                        icon: Icon(Icons.delete_outline, color: Colors.red),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
