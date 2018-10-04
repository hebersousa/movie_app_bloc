import 'package:rxdart/subjects.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:async';
import 'package:movie_app_bloc/api.dart';
import 'package:movie_app_bloc/models/movie.dart';

class MoviesBloc {


  API _api = API();

  final _moviesController = BehaviorSubject<List<Movie>>(seedValue: []);
  final _buscaController = BehaviorSubject<String>(seedValue: '');
  final _loadingController = BehaviorSubject<bool>(seedValue: false);


  bool _endLoading = false;

  int _page = 0;

  Stream<List<Movie>> get moviesStream => _moviesController.stream;
  Stream<bool> get loadingStream => _loadingController.stream;

  set busca(String busca) => _buscaController.sink.add(busca);



  MoviesBloc(){

    _buscaController.stream.listen( (busca){

      _moviesController.sink.add([]);
      _endLoading = false;
      _page = 0;

       loadMore();


    });
  }

  Future<Null> loadMore() async{

    String busca = _buscaController.value;

    if(busca.length == 0)
         _moviesController.addError("sem resultado");

    else
    if(!_loadingController.value  && !_endLoading ) {

        _loadingController.sink.add(true);

        _page++;


      var list = await _api.get(busca, _page);


      _loadingController.sink.add(false);

      if (list.isEmpty) {
        _endLoading = true;
        _moviesController.addError("sem resultado");
      }


       if(busca.length >0) {

         List<Movie> movies = _moviesController.value;
         movies.addAll( list );
         _moviesController.sink.add(movies);
       }

    }

  }


  void dispose(){
    _moviesController.close();
    _buscaController.close();
    _loadingController.close();
  }
}
