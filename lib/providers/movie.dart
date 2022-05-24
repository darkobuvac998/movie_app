import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../models/show_full.dart';
import '../models/urls.dart';

class Movie with ChangeNotifier {
  ShowFull? _movie = null;
  bool _isFavorite = false;

  ShowFull? get movie {
    return _movie;
  }

  bool get isFavorite {
    return _isFavorite;
  }

  Future<void> getMovie(String imdbId) async {
    var url = Uri.parse('${Urls.byImdbId}$imdbId');
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final ShowFull loadedMovie = ShowFull.fromMap(extractedData);
      _movie = loadedMovie;

      var userId = FirebaseAuth.instance.currentUser?.uid;
      var path = 'user-favorites/$userId/favorites';
      var favorite =
          await FirebaseFirestore.instance.collection(path).doc(imdbId).get();

      if (favorite.data() == null) {
        _isFavorite = false;
      } else {
        _isFavorite = favorite.data()!['favorite'] as bool;
      }

      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> addToFavorites() async {
    var oldStatus = _isFavorite;
    try {
      var userId = FirebaseAuth.instance.currentUser?.uid;
      var path = 'user-favorites/$userId/favorites';
      await FirebaseFirestore.instance.collection(path).doc(_movie?.imdbID).set(
        {
          'favorite': !_isFavorite,
          'type': _movie?.type,
          'title': _movie?.title,
          'coverUrl': _movie?.poster,
        },
      );
      _isFavorite = !oldStatus;
      notifyListeners();
    } catch (error) {
      _isFavorite = oldStatus;
      notifyListeners();
      rethrow;
    }
  }
}
