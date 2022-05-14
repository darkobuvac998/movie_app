import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/models/show_full.dart';

import '../models/urls.dart';
import '../models/show_short.dart';

class Movies with ChangeNotifier {
  List<ShowShort> _items = [];

  List<ShowShort> get items {
    return [..._items];
  }

  Future<void> fetchData(String term) async {
    var url = Uri.parse('${Urls.search}$term');
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;

      List<ShowShort> loadedItems = [];

      extractedData['Search']
          ?.forEach((element) => loadedItems.add(ShowShort.fromMap(element)));

      _items = loadedItems;
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }
}
