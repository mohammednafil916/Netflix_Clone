import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:netflix_clone/features/home/domain/entities/movie.dart';
import 'package:netflix_clone/features/downloads/data/models/downloaded_movie_model.dart';
import 'package:netflix_clone/features/downloads/domain/repositories/downloads_repository.dart';

class DownloadsRepositoryImpl implements DownloadsRepository {
  static const String _downloadsKey = 'downloaded_movies';

  @override
  Future<List<Movie>> getDownloadedMovies() async {
    final prefs = await SharedPreferences.getInstance();
    final savedData = prefs.getString(_downloadsKey);

    if (savedData == null) {
      return [];
    }

    final List<dynamic> decodedData = jsonDecode(savedData);

    return decodedData
        .map(
          (movie) =>
              DownloadedMovieModel.fromJson(movie as Map<String, dynamic>),
        )
        .toList();
  }

  @override
  Future<void> saveMovie(Movie movie) async {
    final prefs = await SharedPreferences.getInstance();
    final movies = await getDownloadedMovies();
    // Avoid saving the same movie twice.
    if (movies.any((item) => item.id == movie.id)) {
      return;
    }

    final downloadedMovie = DownloadedMovieModel(
      id: movie.id,
      title: movie.title,
      overview: movie.overview,
      posterPath: movie.posterPath,
      backdropPath: movie.backdropPath,
      rating: movie.rating,
      releaseDate: movie.releaseDate,
    );

    movies.add(downloadedMovie);

    final encodedData = jsonEncode(
      movies.map((movie) {
        return DownloadedMovieModel(
          id: movie.id,
          title: movie.title,
          overview: movie.overview,
          posterPath: movie.posterPath,
          backdropPath: movie.backdropPath,
          rating: movie.rating,
          releaseDate: movie.releaseDate,
        ).toJson();
      }).toList(),
    );

    await prefs.setString(_downloadsKey, encodedData);
  }

  @override
  Future<void> removeMovie(int movieId) async {
    final prefs = await SharedPreferences.getInstance();
    final movies = await getDownloadedMovies();
    movies.removeWhere((movie) => movie.id == movieId);

    final encodedData = jsonEncode(
      movies.map((movie) {
        return DownloadedMovieModel(
          id: movie.id,
          title: movie.title,
          overview: movie.overview,
          posterPath: movie.posterPath,
          backdropPath: movie.backdropPath,
          rating: movie.rating,
          releaseDate: movie.releaseDate,
        ).toJson();
      }).toList(),
    );

    await prefs.setString(_downloadsKey, encodedData);
  }

  @override
  Future<bool> isMovieDownloaded(int movieId) async {
    final movies = await getDownloadedMovies();

    return movies.any((movie) => movie.id == movieId);
  }
}
