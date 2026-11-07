import 'package:netflix_clone/features/home/domain/entities/movie.dart';
import 'package:netflix_clone/features/search/data/datasources/search_remote_data_source.dart';
import 'package:netflix_clone/features/search/data/models/search_movie_model.dart';
import 'package:netflix_clone/features/search/domain/repositories/search_repository.dart';

class SearchRepositoryImpl implements SearchRepository {
  final SearchRemoteDataSource remoteDataSource;

  SearchRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Movie>> searchMovies(String query) async {
    final results = await remoteDataSource.searchMovies(query);

    return results.map((json) => SearchMovieModel.fromJson(json)).toList();
  }
}
