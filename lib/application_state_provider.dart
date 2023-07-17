import 'package:flutter/material.dart';
import 'package:movie_app_bloc/blocs/images_bloc.dart';
import 'package:movie_app_bloc/blocs/movies_bloc.dart';

class ApplicationStateProvider extends InheritedWidget{

  late ImagesBloc _imagesBloc;
  late MoviesBloc _moviesBloc;

  ApplicationStateProvider({Key? key, Widget? child})
      : super(key: key, child: child!){

    _imagesBloc = ImagesBloc();
    _moviesBloc = MoviesBloc();

  }


  @override
  bool updateShouldNotify(_) => true;

  static ApplicationStateProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ApplicationStateProvider>();

  }


   ImagesBloc get imagesBloc => _imagesBloc;
   MoviesBloc get moviesBloc => _moviesBloc;

}