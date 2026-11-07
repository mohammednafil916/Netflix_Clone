import 'package:netflix_clone/features/movie_details/data/datasources/movie_details_remote_data_source.dart';
import 'package:netflix_clone/features/movie_details/data/models/movie_details_model.dart';
import 'package:netflix_clone/features/movie_details/domain/entities/movie_details.dart';
import 'package:netflix_clone/features/movie_details/domain/repositories/movie_details_repository.dart';

class MovieDetailsRepositoryImpl implements MovieDetailsRepository {
  final MovieDetailsRemoteDataSource remoteDataSource;

  MovieDetailsRepositoryImpl(this.remoteDataSource);

  @override
  Future<MovieDetails> getMovieDetails(int movieId) async {
    final json = await remoteDataSource.fetchMovieDetails(movieId);

    return MovieDetailsModel.fromJson(json);
  }
}
