import 'package:netflix_clone/features/home/domain/entities/movie.dart';

abstract class HomeRepository {
  Future<List<Movie>> fetchPopularMovies();
  Future<List<Movie>> fetchTrendingMovies();
  Future<List<Movie>> fetchNowPlayingMovies();
}
