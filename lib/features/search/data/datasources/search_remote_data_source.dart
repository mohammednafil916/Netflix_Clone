import 'package:dio/dio.dart';

class SearchRemoteDataSource {
  final Dio dio;

  SearchRemoteDataSource(this.dio);

  Future<List<dynamic>> searchMovies(String query) async {
    try {
      final response = await dio.get(
        '/search/movie',
        queryParameters: {'query': query},
      );

      if (response.statusCode == 200) {
        return response.data['results'];
      } else {
        throw Exception('Failed to search movies');
      }
    } on DioException catch (e) {
      throw Exception(e.response?.data?['status_message'] ?? e.message);
    }
  }
}
