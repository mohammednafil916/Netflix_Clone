import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:netflix_clone/features/home/presentation/providers/home_provider.dart';
import 'package:netflix_clone/features/home/presentation/widgets/movie_card.dart';
import 'package:netflix_clone/features/home/presentation/widgets/featured_movie_banner.dart';
import 'package:netflix_clone/core/widgets/movie_shimmer.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final movies = ref.watch(popularMoviesProvider);
    final trendingMovies = ref.watch(trendingMoviesProvider);
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text(
          "NETFLIX",
          style: GoogleFonts.bebasNeue(
            color: Colors.red,
            fontSize: 32,
            letterSpacing: 2.5,
          ),
        ),
      ),

      body: movies.when(
        loading: () {
          return const MovieShimmer();
        },

        error: (error, stackTrace) {
          return Center(child: Text("Something went wrong: $error"));
        },

        data: (movieList) {
          if (movieList.isEmpty) {
            return Center(child: Text("No movies available"));
          }

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Featured Movie Banner
                FeaturedMovieBanner(movies: movieList.take(5).toList()),

                SizedBox(height: 20),

                // Popular Movies Heading
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    "Popular on Netflix",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),

                SizedBox(height: 16),

                // Horizontal Movie List
                SizedBox(
                  height: 230,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(horizontal: 16),
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
                SizedBox(height: 25),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'Trending Now',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),

                SizedBox(height: 16),

                trendingMovies.when(
                  loading: () {
                    return const MovieShimmer();
                  },

                  error: (error, stackTrace) {
                    return Padding(
                      padding: EdgeInsets.all(16),
                      child: Text("Failed to load trending movies: $error"),
                    );
                  },

                  data: (trendingList) {
                    return SizedBox(
                      height: 230,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: trendingList.length,
                        separatorBuilder: (context, index) =>
                            SizedBox(width: 12),
                        itemBuilder: (context, index) {
                          return MovieCard(movie: trendingList[index]);
                        },
                      ),
                    );
                  },
                ),

                SizedBox(height: 25),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    "Now Playing",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),

                SizedBox(height: 16),

                nowPlayingMovies.when(
                  loading: () {
                    return const MovieShimmer();
                  },

                  error: (error, stackTrace) {
                    return Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text("Failed to load movies: $error"),
                    );
                  },

                  data: (nowPlayingList) {
                    return SizedBox(
                      height: 230,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        itemCount: nowPlayingList.length,
                        separatorBuilder: (context, index) =>
                            SizedBox(width: 12),
                        itemBuilder: (context, index) {
                          return MovieCard(movie: nowPlayingList[index]);
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
