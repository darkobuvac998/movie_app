import 'dart:convert';

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

  Future<void> searchMovies(String term) async {
    if (_canLoadMore) {
      _pageNumber += 1;
      var url = Uri.parse('${Urls.search}$term&page=$_pageNumber');
      try {
        final response = await http.get(url);
        final extractedData =
            json.decode(response.body) as Map<String, dynamic>;
        List<ShowShort> loadedItems = [];
        print(extractedData);
        print(extractedData.length);
        if (extractedData.length == 2) {
          _canLoadMore = false;
          _pageNumber = 0;
          return;
        }
        extractedData['Search']
            ?.forEach((element) => loadedItems.add(ShowShort.fromMap(element)));

        _items = [..._items, ...loadedItems];
        notifyListeners();
      } catch (error) {
        rethrow;
      }
    }
  }

  void clearData() {
    this._items = [];
    notifyListeners();
  }
}
