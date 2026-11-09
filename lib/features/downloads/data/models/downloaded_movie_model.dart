class DownloadedMovieModel {
  final int id;
  final String title;
  final String overview;
  final String? posterPath;
  final String? backdropPath;
  final double rating;
  final String releaseDate;

  DownloadedMovieModel({
    required this.id,
    required this.title,
    required this.overview,
    this.posterPath,
    this.backdropPath,
    required this.rating,
    required this.releaseDate,
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
