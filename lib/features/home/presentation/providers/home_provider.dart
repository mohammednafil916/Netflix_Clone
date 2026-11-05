import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:netflix_clone/features/home/data/datasources/home_remote_data_source.dart';
import 'package:netflix_clone/features/home/data/repositories/home_repository_impl.dart';
import 'package:netflix_clone/features/home/domain/repositories/home_repository.dart';
import 'package:netflix_clone/features/home/domain/entities/movie.dart';

// Remote Data Source
final homeRemoteDataSourceProvider = Provider((ref) => HomeRemoteDataSource());

// Repository
final homeRepositoryProvider = Provider<HomeRepository>((ref) {
  final remoteDataSource = ref.watch(homeRemoteDataSourceProvider);

  return HomeRepositoryImpl(remoteDataSource: remoteDataSource);
});

class PopularMoviesNotifier extends AsyncNotifier<List<Movie>> {
  @override
  Future<List<Movie>> build() async {
    final repository = ref.watch(homeRepositoryProvider);

    return await repository.fetchPopularMovies();
  }
}

final popularMoviesProvider =
    AsyncNotifierProvider<PopularMoviesNotifier, List<Movie>>(
      PopularMoviesNotifier.new,
    );
