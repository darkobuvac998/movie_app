import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/models/show_full.dart';

import '../models/urls.dart';
import '../models/show_short.dart';

class Movies with ChangeNotifier {
  List<ShowShort> _items = [];
  bool _canLoadMore = true;
  int _pageNumber = 0;

  List<ShowShort> get items {
    return [..._items];
  }

  bool get canLoadMoreMovies {
    return _canLoadMore;
  }

  void enableToLoadMoreMovies(bool value) {
    _canLoadMore = value;
    notifyListeners();
  }

  Future<void> fetchData(String term) async {
    var url = Uri.parse('${Urls.search}$term');
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      List<ShowShort> loadedItems = [];

      extractedData['Search']
          ?.forEach((element) => loadedItems.add(ShowShort.fromMap(element)));

      // _items = loadedItems;
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> searchMovies(String term, String type) async {
    if (_canLoadMore && _pageNumber <= 5) {
      _pageNumber += 1;
      var url = Uri.parse('${Urls.search}$term&page=$_pageNumber&type=$type');
      try {
        final response = await http.get(url);
        final extractedData =
            json.decode(response.body) as Map<String, dynamic>;
        List<ShowShort> loadedItems = [];

        if (extractedData.length == 2) {
          _canLoadMore = false;
          _pageNumber = 0;
          notifyListeners();
          return;
        }
        extractedData['Search']
            ?.forEach((element) => loadedItems.add(ShowShort.fromMap(element)));

        _items = [..._items, ...loadedItems];
        if (_pageNumber == 5) {
          _canLoadMore = false;
        }
        notifyListeners();
      } catch (error) {
        rethrow;
      }
    }
  }

  // Future<void> getFavoriteMovies() async {
  //   final user = FirebaseAuth.instance.currentUser;
  //   var path = 'user-favorites/${user?.uid}/favorites';
  //   final result = await FirebaseFirestore.instance.collection(path).snapshots();
  //   print(result.);
  // }

  void clearData() {
    this._pageNumber = 0;
    this._items = [];
    notifyListeners();
  }
}
