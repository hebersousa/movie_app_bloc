import 'package:flutter/material.dart';
import 'package:movie_app_bloc/blocs/images_bloc.dart';
import 'package:movie_app_bloc/application_state_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MovieDetailBottomScreen extends StatelessWidget {
  final idMovie;

  MovieDetailBottomScreen(this.idMovie);

  @override
  Widget build(BuildContext context) {
    ImagesBloc? bloc = ApplicationStateProvider.of(context)?.imagesBloc;

    var iconPlaceHolder = Padding(
      padding: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 60.0),
      child: Icon(Icons.movie_creation, color: Colors.brown[100],),
    );

    Widget getImage(url){
      return CachedNetworkImage(
          imageUrl: url,
          placeholder: (_,url)=> iconPlaceHolder,
          height: 60.0,
      );
    }

    return StreamBuilder<List<String>?>(
      stream: bloc?.imagesStream,
      builder: (_, snapshot) {
        if (snapshot.hasData) {
            return ListView(
              scrollDirection: Axis.horizontal,
              children: snapshot.data?.map((url) => getImage(url)).toList() ?? []);

        } else if (snapshot.hasError) {
            return new Center(child: Text('SEM IMAGENS',style: TextStyle(color: Colors.brown[100]),));

        } else {
            return new Center(child: CircularProgressIndicator(),  );

        }
      },
    );
  }
}
