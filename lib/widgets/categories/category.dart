import 'package:flutter/material.dart';

import '../../models/show_short.dart';
import 'category_item.dart';

class Category extends StatelessWidget {
  final String title;
  final List<ShowShort> items;
  const Category({
    required this.title,
    required this.items,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 5,
      ),
      width: double.infinity,
      height: 200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.headline4,
          ),
          const SizedBox(
            height: 5,
          ),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: items.length,
              itemBuilder: (ctx, i) => CategoryItem(
                coverUrl: items[i].poster,
                title: items[i].title,
                id: items[i].imdbID,
              ),
            ),
          )
        ],
      ),
    );
  }
}
