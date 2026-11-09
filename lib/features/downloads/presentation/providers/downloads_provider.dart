import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:netflix_clone/features/home/domain/entities/movie.dart';
import 'package:netflix_clone/features/downloads/data/repositories/downloads_repository_impl.dart';
import 'package:netflix_clone/features/downloads/domain/repositories/downloads_repository.dart';

// Repository Provider
final downloadsRepositoryProvider = Provider<DownloadsRepository>((ref) {
  return DownloadsRepositoryImpl();
});

// Downloads State Provider
final downloadsProvider = AsyncNotifierProvider<DownloadsNotifier, List<Movie>>(
  DownloadsNotifier.new,
);

class DownloadsNotifier extends AsyncNotifier<List<Movie>> {
  late DownloadsRepository repository;

  @override
  Future<List<Movie>> build() async {
    repository = ref.watch(downloadsRepositoryProvider);
    return repository.getDownloadedMovies();
  }

  // Save movie
  Future<void> saveMovie(Movie movie) async {
    await repository.saveMovie(movie);
    state = AsyncData(await repository.getDownloadedMovies());
  }

  // Remove movie
  Future<void> removeMovie(int movieId) async {
    await repository.removeMovie(movieId);
    state = AsyncData(await repository.getDownloadedMovies());
  }

  // Check whether movie is saved
  Future<bool> isMovieDownloaded(int movieId) {
    return repository.isMovieDownloaded(movieId);
  }
}
