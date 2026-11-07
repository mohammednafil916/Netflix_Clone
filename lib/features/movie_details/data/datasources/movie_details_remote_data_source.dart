import 'package:dio/dio.dart';

class MovieDetailsRemoteDataSource {
  final Dio dio;

  MovieDetailsRemoteDataSource(this.dio);

  Future<Map<String, dynamic>> fetchMovieDetails(int movieId) async {
    try {
      final response = await dio.get('/movie/$movieId');

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Failed to fetch movie details');
      }
    } on DioException catch (e) {
      throw Exception(e.response?.data?['status_message'] ?? e.message);
    }
  }
}
