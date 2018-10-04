import 'package:flutter/material.dart';
import 'package:movie_app_bloc/api.dart';
import 'package:movie_app_bloc/screens/movie_sc.dart';
import 'package:movie_app_bloc/application_state_provider.dart';


void main() => runApp(new MyApp());

class MyApp extends StatelessWidget{

  @override
  Widget build(BuildContext build){

    return new ApplicationStateProvider(
      child: MaterialApp(
        title: "Movie App",
        theme: ThemeData(
            primarySwatch: Colors.brown
        ),
        home: MovieScreen(),


      ),
    );
  }

}