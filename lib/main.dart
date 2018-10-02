import 'package:flutter/material.dart';
import 'package:movie_app_bloc/api.dart';
import 'package:movie_app_bloc/screens/movie_sc.dart';


void main() => runApp(new MyApp());

class MyApp extends StatelessWidget{

  @override
  Widget build(BuildContext build){

    return MaterialApp(
      title: "Movie App",
      theme: ThemeData(
          primarySwatch: Colors.brown
      ),
      home: MovieScreen(),


    );
  }

}