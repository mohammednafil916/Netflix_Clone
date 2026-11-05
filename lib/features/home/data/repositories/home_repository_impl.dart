import 'package:netflix_clone/features/home/data/datasources/home_remote_data_source.dart';
import 'package:netflix_clone/features/home/domain/entities/movie.dart';
import 'package:netflix_clone/features/home/domain/repositories/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remoteDataSource;

  HomeRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Movie>> fetchPopularMovies() async {
    return await remoteDataSource.fetchPopularMovies();
  }

  @override
  Future<List<Movie>> fetchTrendingMovies() async {
    return await remoteDataSource.fetchTrendingMovies();
  }
}
