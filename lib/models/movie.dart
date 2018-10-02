
class Movie {
  final String title;
  final String poster_path;
  final String overview;
  final int id;
  String vote_average;
  String release_date;
  String backdrop_path;

  Movie(this.title, this.poster_path, this.overview, this.id);

  Movie.fromJSON(Map json)
      : title= json['title'],
        poster_path= json['poster_path'],
        overview= json['overview'],
        id = json['id'],
        vote_average= json['vote_average'].toString(),
        release_date= json['release_date'],
        backdrop_path= json['backdrop_path'];

  @override
  String toString() {
    print(title);
    return super.toString();
  }


}