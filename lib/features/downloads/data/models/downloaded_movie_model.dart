import 'package:netflix_clone/features/home/domain/entities/movie.dart';

class DownloadedMovieModel extends Movie {
  DownloadedMovieModel({
    required super.id,
    required super.title,
    required super.overview,
    super.posterPath,
    super.backdropPath,
    required super.rating,
    required super.releaseDate,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'overview': overview,
      'posterPath': posterPath,
      'backdropPath': backdropPath,
      'rating': rating,
      'releaseDate': releaseDate,
    };
  }

  factory DownloadedMovieModel.fromJson(Map<String, dynamic> json) {
    return DownloadedMovieModel(
      id: json['id'],
      title: json['title'],
      overview: json['overview'],
      posterPath: json['posterPath'],
      backdropPath: json['backdropPath'],
      rating: (json['rating'] as num).toDouble(),
      releaseDate: json['releaseDate'],
    );
  }
}
