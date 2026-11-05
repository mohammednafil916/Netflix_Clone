import 'package:netflix_clone/features/home/domain/entities/movie.dart';

class MovieModel extends Movie {
  MovieModel({
    required super.id,
    required super.title,
    required super.overview,
    super.posterPath,
    required super.rating,
    required super.releaseDate,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json['id'],
      title: json['title'],
      overview: json['overview'],
      posterPath: json['posterPath'],
      rating: (json['vote_average'] as num).toDouble(),
      releaseDate: json['releaseDate'],
    );
  }
}
