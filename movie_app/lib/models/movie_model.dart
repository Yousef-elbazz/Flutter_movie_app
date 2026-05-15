class MovieModel {
  String title;
  String backDropPath;
  String originalTitle;
  String overView;
  String posterPath;
  String releaseDate;
  double voteAverage;
  int movieId;

  MovieModel({
    required this.title,
    required this.backDropPath,
    required this.originalTitle,
    required this.overView,
    required this.posterPath,
    required this.releaseDate,
    required this.voteAverage,
    required this.movieId,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      title: json["title"],
      backDropPath: json["backdrop_path"],
      originalTitle: json["original_title"],
      overView: json["overview"],
      posterPath: json["poster_path"],
      releaseDate: json["release_date"],
      voteAverage: json["vote_average"].toDouble(),
      movieId: json["id"],
    );
  }

  Map<String, dynamic> toJson() => {
    "title": title,
    "backdrop_path": backDropPath,
    "original_title": originalTitle,
    "overview": overView,
    "poster_path": posterPath,
    "release_date": releaseDate,
    "vote_average": voteAverage,
    "id": movieId,
  };

  String get posterUrl {
    return 'https://image.tmdb.org/t/p/w500$posterPath';
  }
}
