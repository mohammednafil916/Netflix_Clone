import 'package:dio/dio.dart';
import 'package:netflix_clone/core/network/dio_client.dart';
import 'package:netflix_clone/features/home/data/models/movie_model.dart';

class HomeRemoteDataSource {
  Future<List<MovieModel>> fetchPopularMovies() async {
    try {
      final response = await DioClient.dio.get('/movie/popular');

      if (response.statusCode == 200) {
        final List movies = response.data['results'];

        return movies.map((movie) {
          return MovieModel.fromJson(movie);
        }).toList();
      } else {
        throw Exception('Failed to load popural movies');
      }
    } on DioException catch (e) {
      throw Exception('API Error: ${e.message}');
    }
  }

  Future<List<MovieModel>> fetchTrendingMovies() async {
    try {
      final response = await DioClient.dio.get('/trending/movie/day');

      if (response.statusCode == 200) {
        final List movies = response.data['results'];

        return movies.map((movie) {
          return MovieModel.fromJson(movie);
        }).toList();
      } else {
        throw Exception('Failed to load trending movies');
      }
    } on DioException catch (e) {
      throw Exception('API Error: ${e.message}');
    }
  }
}
