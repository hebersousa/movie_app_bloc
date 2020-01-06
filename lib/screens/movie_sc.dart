import 'package:flutter/material.dart';
import 'package:movie_app_bloc/api.dart';
import 'package:movie_app_bloc/models/movie.dart';
import 'package:movie_app_bloc/screens/movie_detail/movie_detail_sc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:movie_app_bloc/application_state_provider.dart';

class MovieScreen extends StatefulWidget{

  @override
  _MovieScreenState createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen>{

TextEditingController txtController = TextEditingController();



    var progressIndicator = Padding(
        padding: const EdgeInsets.all(10.0),
        child:new SizedBox(child: CircularProgressIndicator(strokeWidth: 2.0,), height: 15.0,width: 15.0,));



    @override
    Widget build(BuildContext context){

      var titleApp = AppBar( title: Text('Movie App'));

      var field =  TextField(
        controller: txtController,
        decoration: InputDecoration(
            hintText: 'Busque um filme',
            border: InputBorder.none
        ),
        onChanged: (valor){
          ApplicationStateProvider.of(context).moviesBloc.busca = valor;

        },
      );

      var textField = new Container(
        padding: const EdgeInsets.only(left: 10.0),
        decoration: BoxDecoration(
              color: Colors.white,

              borderRadius:  BorderRadius.circular(8.0)
        ),
        child: new Row(
          children: <Widget>[
            new Expanded(
              child:field
            ),

            IconButton(icon: Icon(Icons.clear),
              onPressed: (){
              setState((){
                txtController.text = '';
                ApplicationStateProvider.of(context).moviesBloc.busca = '';
              });
              },)
          ],
        ),
      );

      return Scaffold(
        backgroundColor: Theme.of(context).primaryColorLight,
        appBar: titleApp,
        body: Column( children: [

              Container(  padding: const EdgeInsets.all(10.0),
                          child: textField
              ),
              Flexible(child: buildResultsStream())
        ]) ,
      );
    }


  Widget buildProgressIndicatorStream(){

      return StreamBuilder<bool>(
        stream: ApplicationStateProvider.of(context).moviesBloc.loadingStream,
        builder: (_, snapshot){

          if(snapshot.hasData && snapshot.data)
              return Center(child: progressIndicator);
          else
            return Padding(padding: const EdgeInsets.all(10.0),);

        },
      );
  }



  Widget buildResultsStream(){

    return StreamBuilder<List<Movie>>(
      stream: ApplicationStateProvider.of(context).moviesBloc.moviesStream,
      builder: (_,snapshot){

        if(snapshot.hasError){
          return new Center(child: Icon(Icons.movie_creation,size: 200.0,color: Colors.grey[300],));


        }else if(snapshot.hasData){

          return ListView.builder(

            itemCount:  snapshot.data.length + 1,
            itemBuilder: (context, index) {

              List<Movie> movies = snapshot.data;

              if(index < movies.length  ) {
                return buildItem( movies[index] );
              }
              else
              {
                ApplicationStateProvider.of(context).moviesBloc.loadMore();
                return buildProgressIndicatorStream();
              }

            },
          );
        }else{
          return Container();
        }


      },

    );

  }

  Widget buildItem(Movie movie){

       return new Column(
         children: <Widget>[
           ListTile(
            title:Text(movie.title, style: TextStyle(color: Theme.of(context).accentColor)),
            leading: CachedNetworkImage(
                imageUrl: "${movie.poster_path}",
                width: 60.0,
                placeholder: (context, url) => Icon(Icons.movie_creation),
            ),
            onTap: (){
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context)=>MovieDetailScreen(movie) )
              );

            },


      ),
           Divider()
         ]

       );
  }

  @override
  void dispose() {
    super.dispose();
  }

}