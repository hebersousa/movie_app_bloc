import 'package:flutter/material.dart';
import 'package:movie_app_bloc/models/movie.dart';
import 'package:movie_app_bloc/screens/movie_detail/movie_detail_bottom_sc.dart';
import 'dart:async';
import 'package:movie_app_bloc/application_state_provider.dart';
import 'package:movie_app_bloc/blocs/images_bloc.dart';

class MovieDetailScreen extends StatelessWidget{

  final Movie movie;
  MovieDetailScreen(this.movie);



@override
Widget build( BuildContext context){

  ImagesBloc bloc = ApplicationStateProvider.of(context).imagesBloc;
  bloc.loadData(movie.id);
  //bloc.setMovieId(movie.id);

  var imagemFundo = movie.backdrop_path!=null?Image.network(movie.backdrop_path):Container();

  var closeButton = IconButton(
      icon: Icon(Icons.clear,color: Colors.white,),
      onPressed: ()=>Navigator.of(context).pop()
  );


  var ano =  movie.release_date;
  if(ano.isNotEmpty)  ano = "(${movie.release_date.substring(0,4)})";

  var titulo = Text("${movie.title} $ano",
    style: TextStyle(color: Colors.white, fontSize: 30.0),
  );

  var card = Card(child: new Padding(
    padding: const EdgeInsets.all(12.0),
    child: new Column(
      children: [
        new Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text("${movie.vote_average}",style: TextStyle(fontSize: 50.0, fontWeight: FontWeight.bold ),),
            movie.poster_path == null ? Icon(Icons.movie) : Image.network('https://image.tmdb.org/t/p/w92'+movie.poster_path),
          ],
        ),
        SizedBox(height: 10.0,),
        Text(movie.overview),
      ],
    ),
  ),);


  Future<Null> onrefresh() async{

    ImagesBloc bloc = ApplicationStateProvider.of(context).imagesBloc;
    await bloc.loadData(movie.id);
  }

  return new Scaffold(
    backgroundColor: Theme.of(context).cardColor,
    body: Stack(
      children: [
        imagemFundo,
        Opacity(opacity:0.5,child: Container(color: Theme.of(context).primaryColor, padding: const EdgeInsets.all(10.0))),


        new RefreshIndicator(
          onRefresh: onrefresh,
          child: new SingleChildScrollView(
            child: new Padding(
              padding: const EdgeInsets.fromLTRB(10.0, 150.0,10.0,8.0),
              child: Column(
                children:[
                  titulo,
                  SizedBox(height: 10.0,),
                  card,
                  SizedBox(height: 10.0,),
                  new SizedBox(child: MovieDetailBottomScreen(movie.id), height: 100.0,),
                  SizedBox(height: 10.0,),
                ],
              ),
            ),
          ),
        ),
        Positioned(child: closeButton ,top: 20.0,),

      ],
    ),

  );

}


}

