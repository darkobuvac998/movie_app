import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../models/show_full.dart';
import '../models/urls.dart';

class Movie with ChangeNotifier {
  ShowFull? _movie = null;

  ShowFull? get movie {
    return _movie;
  }

  Future<void> getMovie(String imdbId) async {
    var url = Uri.parse('${Urls.byImdbId}$imdbId');

    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      // print(extractedData);
      final ShowFull loadedMovie = ShowFull.fromMap(extractedData);
      _movie = loadedMovie;
      print(movie);
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }
}
