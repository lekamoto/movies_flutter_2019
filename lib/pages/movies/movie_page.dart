import 'package:flutter/material.dart';
import 'package:flutter_movies_udemy/pages/movies/movie.dart';
import 'package:flutter_movies_udemy/pages/movies/movies_bloc.dart';

class MoviePage extends StatefulWidget {
  final Movie movie;

  MoviePage(this.movie);

  @override
  _MoviePageState createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  
  final _bloc = MoviesBloc();
  
  final favoritado = false;

  Movie get movie => widget.movie;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
    );
  }

  _body() {
    return CustomScrollView(slivers: <Widget>[
      SliverAppBar(
        backgroundColor: Colors.deepOrange,
        expandedHeight: 350,
        pinned: false,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.favorite,
              size: 34,
              color: favoritado ? Colors.red : Colors.white,
            ),
            onPressed: () {
              _onClickFavoritar();
            },
          ),
        ],
        flexibleSpace: FlexibleSpaceBar(
          centerTitle: false,
          title: Text(widget.movie.title),
          background: Container(
            child: Image.network(
              widget.movie.urlFoto,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
      SliverList(delegate: _sliver())
    ]);
  }

  _sliver() {
    return SliverChildListDelegate(
      [
        Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  _card(Icons.favorite, movie.vote_count),
                  _card(Icons.star, movie.vote_average),
                ],
              ),
              Row(
                children: <Widget>[
                  _card(Icons.movie, movie.popularity),
                  _card(Icons.date_range, movie.release_date),
                ],
              )
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.all(26),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              colors: [Colors.red, Colors.deepOrange],
            ),
          ),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(
                    Icons.description,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    "Descrição",
                    style: TextStyle(
                      fontSize: 26,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 26,
              ),
              Text(
                movie.overview,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  letterSpacing: 1,
                ),
              ),
              SizedBox(
                height: 26,
              ),
            ],
          ),
        ),
      ],
    );
  }

  _card(IconData icone, dynamic texto) {
    return Container(
      child: Expanded(
        flex: 1,
        child: InkWell(
          onTap: (){
            print("Tap > $texto");
          },
          child: Container(
            padding: EdgeInsets.only(top: 30, bottom: 30, left: 15, right: 15),
            margin: EdgeInsets.all(15),
            decoration: new BoxDecoration(
              border: Border.all(width: 1.0, color: Colors.grey),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: <Widget>[
                Icon(
                  icone,
                  color: Colors.deepOrange,
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                  "$texto",
                  style: TextStyle(fontSize: 18, color: Colors.black),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onClickFavoritar() {
    final b = _bloc.favoritar(movie);
    print(b);
  }

  @override
  void dispose() {
    super.dispose();

    _bloc.close();
  }
}
