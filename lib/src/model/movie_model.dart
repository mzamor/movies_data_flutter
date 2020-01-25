class Movies {
  List<Movie> items = new List();

  Movies();

  Movies.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    for (var item in jsonList) {
      final movie = new Movie.fromJSONMap(item);
      items.add(movie);
    }
  }
}

class Movie {
  String uniqueId;
  double popularity;
  int voteCount;
  bool video;
  String posterPath;
  int id;
  bool adult;
  String backdropPath;
  String originalLanguage;
  String originalTitle;
  List<int> genreIds;
  String title;
  double voteAverage;
  String overview;
  String releaseDate;

  Movie({
    this.popularity,
    this.voteCount,
    this.video,
    this.posterPath,
    this.id,
    this.adult,
    this.backdropPath,
    this.originalLanguage,
    this.originalTitle,
    this.genreIds,
    this.title,
    this.voteAverage,
    this.overview,
    this.releaseDate,
  });

  Movie.fromJSONMap(Map<String, dynamic> json) {
    this.popularity = json['popularity'] / 1;
    this.voteCount = json['vote_count'];
    this.video = json['video'];
    this.posterPath = json['poster_path'];
    this.id = json['id'];
    this.adult = json['adult'];
    this.backdropPath = json['backdrop_path'];
    this.originalLanguage = json['original_language'];
    this.originalTitle = json['original_title'];
    this.genreIds = json['genre_ids'].cast<int>();
    this.title = json['title'];
    this.voteAverage = json['vote_average'] / 1;
    this.overview = json['overview'];
    this.releaseDate = json['release_date'];
  }

  getPosterImg() {
    if (posterPath == null) {
      return 'https://sanitationsolutions.net/wp-content/uploads/2015/05/empty-image.png';
    } else {
      return 'https://image.tmdb.org/t/p/w500$posterPath';
    }
  }

  getBackgroundImg() {
    if (posterPath == null) {
      return 'https://sanitationsolutions.net/wp-content/uploads/2015/05/empty-image.png';
    } else {
      return 'https://image.tmdb.org/t/p/w500$backdropPath';
    }
  }
}
