import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:netflix_clone/features/home/presentation/providers/home_provider.dart';
import 'package:netflix_clone/features/home/presentation/widgets/movie_card.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final movies = ref.watch(popularMoviesProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "NETFLIX",
          style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
        ),
      ),

      body: movies.when(
        loading: () {
          return Center(child: CircularProgressIndicator());
        },

        error: (error, stackTrace) {
          return Center(child: Text("Something went wrong: $error"));
        },

        data: (movieList) {
          if (movieList.isEmpty) {
            return Center(child: Text("No movies available"));
          }

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      "Popular on Netflix",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  SizedBox(height: 16),

                  SizedBox(
                    height: 230,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: movieList.length,
                      separatorBuilder: (context, index) {
                        return SizedBox(width: 12);
                      },
                      itemBuilder: (context, index) {
                        final movie = movieList[index];

                        return MovieCard(movie: movie);
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
