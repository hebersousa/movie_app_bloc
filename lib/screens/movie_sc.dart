import 'package:flutter/material.dart';
import 'package:movie_app_bloc/api.dart';
import 'package:movie_app_bloc/models/movie.dart';
import 'package:movie_app_bloc/screens/movie_detail/movie_detail_sc.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MovieScreen extends StatefulWidget{

  @override
  _MovieScreenState createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen>{

  int _page;
  String _busca ="";
  List<Movie> _movies = [];
  API _api = new API();
TextEditingController txtController = TextEditingController();

  bool isLoading = false;
  bool fimCarregamento = false;

    void buscaDados(var busca) async {
      setState((){
        _busca = busca;
        _movies =[];
        fimCarregamento = false;
      });

      if(busca.length > 0 ) {
        setState(() {
            _page = 0;
        });
        loadMore();
      }
    }

    void loadMore() async{

      if(!isLoading && _busca.length > 0) {
        setState(() {
          isLoading = true;
          _page++;
        });

        var list = await _api.get(_busca, _page);

        if (list.isEmpty)
          fimCarregamento = true;

          setState(() {
            isLoading = false;
            if(_busca.length >0)
              _movies.addAll(list);

          });
      }
    }

    Widget buildProgressIndicator(){
       return Center(child:
          fimCarregamento?Padding(padding: const EdgeInsets.all(10.0),)
          : Padding(
              padding: const EdgeInsets.all(10.0),
              child:new SizedBox(child: CircularProgressIndicator(strokeWidth: 2.0,), height: 15.0,width: 15.0,)));
    }

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
          buscaDados(valor);
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
                buscaDados('');
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
              Flexible(child: buildResults(context))
        ]) ,
      );
    }

  Widget buildResults(BuildContext context){
      if(_movies.isEmpty && !isLoading){
        return new Center(child: Icon(Icons.movie_creation,size: 200.0,color: Colors.grey[300],));
      }else{
        return ListView.builder(

          itemCount:  _movies.length+1,
          itemBuilder: (context, index) {
            if(index == _movies.length && !fimCarregamento ) {
              loadMore();
            }

            if(index == _movies.length )
                return buildProgressIndicator();
            else

             return buildItem(_movies[index]);

          },
        );

      }
  }

  Widget buildItem(Movie movie){

       return new Column(
         children: <Widget>[
           ListTile(
            title:Text(movie.title, style: TextStyle(color: Theme.of(context).accentColor)),
            leading: CachedNetworkImage(imageUrl: movie.poster_path,
              placeholder: Icon(Icons.movie_creation),
              height: 60.0,
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