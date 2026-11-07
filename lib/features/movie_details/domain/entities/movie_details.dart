class MovieDetails {
  final int id;
  final String title;
  final String overview;
  final String? posterPath;
  final String? backdropPath;
  final double rating;
  final String releaseDate;
  final int? runtime;
  final String? tagline;
  final List<String> genres;

  MovieDetails({
    required this.id,
    required this.title,
    required this.overview,
    this.posterPath,
    this.backdropPath,
    required this.rating,
    required this.releaseDate,
    this.runtime,
    this.tagline,
    required this.genres,
  });
}
