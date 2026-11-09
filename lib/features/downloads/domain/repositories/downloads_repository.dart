import 'package:netflix_clone/features/home/domain/entities/movie.dart';

abstract class DownloadsRepository {
  Future<List<Movie>> getDownloadedMovies();

  Future<void> saveMovie(Movie movie);

  Future<void> removeMovie(int movieId);

  Future<bool> isMovieDownloaded(int movieId);
}
