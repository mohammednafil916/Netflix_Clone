import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:netflix_clone/core/network/dio_client.dart';
import 'package:netflix_clone/features/movie_details/data/datasources/movie_details_remote_data_source.dart';
import 'package:netflix_clone/features/movie_details/data/repositories/movie_details_repository_impl.dart';
import 'package:netflix_clone/features/movie_details/domain/entities/movie_details.dart';
import 'package:netflix_clone/features/movie_details/domain/repositories/movie_details_repository.dart';

// 1. Remote Data Source Provider
final movieDetailsRemoteDataSourceProvider =
    Provider<MovieDetailsRemoteDataSource>((ref) {
      return MovieDetailsRemoteDataSource(DioClient.dio);
    });

// 2. Repository Provider
final movieDetailsRepositoryProvider = Provider<MovieDetailsRepository>((ref) {
  final remoteDataSource = ref.watch(movieDetailsRemoteDataSourceProvider);

  return MovieDetailsRepositoryImpl(remoteDataSource);
});

class MovieDetailsNotifier extends AsyncNotifier<MovieDetails> {
  final int movieId;

  MovieDetailsNotifier(this.movieId);

  @override
  Future<MovieDetails> build() async {
    final repository = ref.watch(movieDetailsRepositoryProvider);

    return repository.getMovieDetails(movieId);
  }
}

final movieDetailsProvider =
    AsyncNotifierProvider.family<MovieDetailsNotifier, MovieDetails, int>(
      MovieDetailsNotifier.new,
    );
