import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:netflix_clone/features/home/presentation/providers/home_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final movies = ref.watch(popularMoviesProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('NETFLIX')),
      body: movies.when(
        loading: () {
          return const Center(child: CircularProgressIndicator());
        },

        error: (error, stackTrace) {
          return Center(child: Text('Something went wrong: $error'));
        },

        data: (movieList) {
          if (movieList.isEmpty) {
            return const Center(child: Text('No movies available'));
          }

          return ListView.builder(
            itemCount: movieList.length,
            itemBuilder: (context, index) {
              final movie = movieList[index];

              return ListTile(
                leading: movie.posterPath != null
                    ? CachedNetworkImage(
                        imageUrl:
                            'https://image.tmdb.org/t/p/w200${movie.posterPath}',
                        width: 60,
                        height: 90,
                        fit: BoxFit.cover,
                      )
                    : const SizedBox(
                        width: 60,
                        height: 90,
                        child: Icon(Icons.movie),
                      ),
                title: Text(movie.title),
                subtitle: Text('Rating: ${movie.rating}'),
              );
            },
          );
        },
      ),
    );
  }
}
