import 'package:flutter/material.dart';
import 'package:movie_app/providers/movies.dart';
import 'package:movie_app/widgets/buttons/bottom_border_button_bar.dart';
import 'package:provider/provider.dart';

import '../widgets/buttons/bottom_border_button.dart';
import '../widgets/grids/movie_grid.dart';
import '../widgets/inputs/serach_bar.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  int _currentButtonIndex = 0;
  void _onButtonTap(int index) {
    setState(() {
      _currentButtonIndex = index;
    });
  }

  String _searchTerm = '';

  void _serachMovies(String term) async {
    if (_searchTerm != term) {
      Provider.of<Movies>(context, listen: false).enableToLoadMoreMovies(true);

      _searchTerm = term;
      Provider.of<Movies>(context, listen: false).clearData();
    }
    Provider.of<Movies>(context, listen: false).searchMovies(term);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BottomBorderButtonBar(
          currentIndex: _currentButtonIndex,
          onTap: _onButtonTap,
          items: [
            BottomBorderButton(
              child: const Text(
                'Movies',
              ),
              onPressed: () {},
            ),
            BottomBorderButton(
              child: const Text(
                'Series',
              ),
              onPressed: () {},
            ),
          ],
        ),
        bottom: SearchBar(
          onSearch: _serachMovies,
        ),
      ),
      body: Consumer<Movies>(
        builder: (ctx, movies, _) {
          if (movies.items.isEmpty) {
            return Center(
              child: Text(
                'Nothing to show!',
                style: Theme.of(context).textTheme.headline4?.copyWith(
                      color: Colors.white,
                    ),
              ),
            );
          }
          return MovieGrid(
            onLoadMore: () => _serachMovies(_searchTerm),
            items: movies.items,
          );
        },
      ),
    );
  }
}
