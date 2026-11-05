class MovieModel {
  final int id;
  final String title;
  final String overview;
  final String? posterPath;
  final double rating;
  final String releaseDate;

  MovieModel({
    required this.id,
    required this.title,
    required this.overview,
    this.posterPath,
    required this.rating,
    required this.releaseDate,
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
