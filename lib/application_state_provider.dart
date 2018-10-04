import 'package:flutter/material.dart';
import 'package:movie_app_bloc/blocs/images_bloc.dart';

class ApplicationStateProvider extends InheritedWidget{

  ImagesBloc _imagesBloc;

  ApplicationStateProvider({Key key, Widget child})
      : super(key: key, child: child){

    _imagesBloc = ImagesBloc();
  }


  @override
  bool updateShouldNotify(_) => true;

  static ApplicationStateProvider of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(ApplicationStateProvider)
    as ApplicationStateProvider);
  }


   ImagesBloc get imagesBloc => _imagesBloc;

}