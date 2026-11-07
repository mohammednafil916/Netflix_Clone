import 'package:netflix_clone/features/home/domain/entities/movie.dart';

abstract class SearchRepository {
  Future<List<Movie>> searchMovies(String query);
}
