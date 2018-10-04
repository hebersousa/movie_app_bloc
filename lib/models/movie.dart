
class Movie {
  final String title;
  String poster_path;
  final String overview;
  final int id;
  String vote_average;
  String release_date;
  String backdrop_path;



  Movie.fromJSON(Map json)
      : title= json['title'],
        overview= json['overview'],
        id = json['id'],
        vote_average= json['vote_average'].toString(),
        release_date= json['release_date'],
        poster_path = "https://image.tmdb.org/t/p/w92${json['poster_path']}",
        backdrop_path = 'https://image.tmdb.org/t/p/w400${json['backdrop_path']}';


  @override
  String toString() {
    print(title);
    return super.toString();
  }


}