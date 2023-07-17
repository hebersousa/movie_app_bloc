import 'package:movie_app_bloc/api_key.dart';
import 'dart:async';
import 'package:movie_app_bloc/models/movie.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


class API {

  var urlQuery = "https://api.themoviedb.org/3/search/movie?api_key=$API_KEY";
  var API_URL =  "https://api.themoviedb.org/3/";


  Future<List<Movie>> get(String query, int page) async{

    List<Movie> list = [];
    var uri =Uri.parse("$urlQuery&query=$query&page=$page");
    await http.get(uri)
        .then( (res){

         Map result = json.decode(res.body);

         if(result.containsKey('results') && result['results'].length > 0)
         (result['results']).forEach( (movie) => list.add(Movie.fromJSON(movie)) );
      }).catchError( (print));

    return list;
  }



  Future<List<String>> listImages(int idMovie) async{

    var url = Uri.parse("${API_URL}movie/$idMovie/images?api_key=$API_KEY");

    return await http.get(url).then( (res){
      Map map = json.decode(res.body);
      
      if(map.containsKey('backdrops')){
        return map['backdrops'].map( (entrada)=> entrada['file_path']).toList().cast<String>();
      }else{
        return [];
      }
    });

  }



}