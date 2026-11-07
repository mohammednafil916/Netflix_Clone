import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:netflix_clone/core/network/dio_client.dart';
import 'package:netflix_clone/features/home/domain/entities/movie.dart';
import 'package:netflix_clone/features/search/data/datasources/search_remote_data_source.dart';
import 'package:netflix_clone/features/search/data/repositories/search_repository_impl.dart';
import 'package:netflix_clone/features/search/domain/repositories/search_repository.dart';

// 1. Remote Data Source Provider
final searchRemoteDataSourceProvider = Provider<SearchRemoteDataSource>((ref) {
  return SearchRemoteDataSource(DioClient.dio);
});

// 2. Repository Provider
final searchRepositoryProvider = Provider<SearchRepository>((ref) {
  final remoteDataSource = ref.watch(searchRemoteDataSourceProvider);

  return SearchRepositoryImpl(remoteDataSource);
});

// 3. Search Movies Provider
final searchMoviesProvider = FutureProvider.family<List<Movie>, String>((
  ref,
  query,
) async {
  final repository = ref.watch(searchRepositoryProvider);

  if (query.trim().isEmpty) {
    return [];
  }

  return repository.searchMovies(query);
});
