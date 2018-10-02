import 'package:flutter/material.dart';
import 'package:movie_app_bloc/models/movie.dart';
import 'package:movie_app_bloc/api.dart';
import 'dart:async';

class MovieDetailScreen extends StatefulWidget{

  Movie movie;
  MovieDetailScreen(this.movie);

@override
  _MovieDetailState createState() => new _MovieDetailState();


}


class _MovieDetailState extends State<MovieDetailScreen>{

  final API api = new API();
  List<String> _images = [];

  @override
  initState() {
    super.initState();

    _images = [];
    api.listImages(widget.movie.id).then( (list){
      setState(() {
         _images = list;
      });

    });

  }

  Widget build( BuildContext context){

    var imagemFundo = widget.movie.backdrop_path!=null?Image.network('https://image.tmdb.org/t/p/w400'+widget.movie.backdrop_path):Container();

    var closeButton = IconButton(
            icon: Icon(Icons.clear,color: Colors.white,),
            onPressed: ()=>Navigator.of(context).pop()
    );


    var ano =  widget.movie.release_date;
    if(ano.isNotEmpty)  ano = "(${widget.movie.release_date.substring(0,4)})";

    var titulo = Text("${widget.movie.title} $ano",
                      style: TextStyle(color: Colors.white, fontSize: 30.0),
    );

    var card = Card(child: new Padding(
      padding: const EdgeInsets.all(12.0),
      child: new Column(
        children: [
          new Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text("${widget.movie.vote_average}",style: TextStyle(fontSize: 50.0, fontWeight: FontWeight.bold ),),
              widget.movie.poster_path == null ? Icon(Icons.movie) : Image.network('https://image.tmdb.org/t/p/w92'+widget.movie.poster_path),
            ],
          ),
          SizedBox(height: 10.0,),
          Text(widget.movie.overview),
        ],
      ),
    ),);


    Widget buildHorizontalList(){

      if(_images.length > 0){

        return ListView(
          scrollDirection: Axis.horizontal,
          children: _images.map( (elemento){

            return Image.network('https://image.tmdb.org/t/p/w200$elemento');
          }
          ).toList());
      }
     return Container();

    }


    return new Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      body: Stack(
        children: [
          imagemFundo,
          Opacity(opacity:0.5,child: Container(color: Theme.of(context).primaryColor, padding: const EdgeInsets.all(10.0))),

          new SingleChildScrollView(
            child: new Padding(
              padding: const EdgeInsets.fromLTRB(10.0, 150.0,10.0,8.0),
              child: Column(
                children:[
                  titulo,
                  SizedBox(height: 10.0,),
                  card,
                  SizedBox(height: 10.0,),
                  new SizedBox(child: buildHorizontalList(), height: 100.0,),
                  SizedBox(height: 10.0,),
                ],
              ),
            ),
          ),
          Positioned(child: closeButton ,top: 20.0,),

        ],
      ),

    );

  }
}


