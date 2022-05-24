import 'package:flutter/material.dart';
import 'package:movie_app/widgets/categories/category_item.dart';
import 'package:provider/provider.dart';

import '../../models/show_short.dart';
import '../../providers/movies.dart';

class MovieGrid extends StatelessWidget {
  final List<ShowShort> items;
  final Function onLoadMore;

  MovieGrid({
    required this.onLoadMore,
    required this.items,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final canLoadMore = Provider.of<Movies>(
      context,
    ).canLoadMoreMovies;
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 2,
      ),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 130.0,
          childAspectRatio: 0.7,
          crossAxisSpacing: 3.0,
          mainAxisSpacing: 4.0,
        ),
        itemBuilder: (ctx, i) {
          if (i < items.length) {
            return CategoryItem(
              coverUrl: items[i].poster,
              title: items[i].title,
              id: items[i].imdbID,
            );
          } else {
            onLoadMore();
            if (canLoadMore) {
              return Container(
                padding: const EdgeInsets.all(
                  50,
                ),
                child: const CircularProgressIndicator(),
              );
            }
            return Container();
          }
        },
        itemCount: items.length + 1,
      ),
    );
  }
}
