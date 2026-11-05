import 'package:netflix_clone/features/home/domain/entities/movie.dart';

class MovieModel extends Movie {
  MovieModel({
    required super.id,
    required super.title,
    required super.overview,
    super.posterPath,
    super.backdropPath,
    required super.rating,
    required super.releaseDate,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? "",
      overview: json['overview'] ?? "",
      posterPath: json['poster_path'],
      backdropPath: json['backdrop_path'],
      rating: (json['vote_average'] as num?)?.toDouble() ?? 0.0,
      releaseDate: json['release_date'] ?? "",
    );
  }
}
