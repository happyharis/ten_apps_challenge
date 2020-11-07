import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ten_apps_challenge/movies_app/movie.dart';

class MoviesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movies App'),
      ),
      body: FutureBuilder<Movies>(
        future: fetchMovies(),
        builder: (context, snapshot) {
          if (!snapshot.hasData ||
              snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          final movies = snapshot.data.data;

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (var movie in movies)
                  Container(
                    margin: EdgeInsets.all(18),
                    padding: EdgeInsets.all(18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Flexible(
                              child: Text(
                                movie.name + ' (${movie.releaseDate.year})',
                                style: Theme.of(context).textTheme.headline6,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Text('Rating: ' + movie.rate.toString() + '/10'),
                        SizedBox(height: 10),
                        Text(movie.overwatch),
                      ],
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}

Future<Movies> fetchMovies() async {
  final response = await http.get('https://www.fluttermovie.top/api/Movies/');

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Movies.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}
