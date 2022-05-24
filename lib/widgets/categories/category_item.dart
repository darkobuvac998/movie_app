import 'package:flutter/material.dart';

import '../../screens/show_detail_screen.dart';

class CategoryItem extends StatelessWidget {
  final String coverUrl;
  final String title;
  final String id;
  const CategoryItem({
    required this.coverUrl,
    required this.title,
    required this.id,
    Key? key,
  }) : super(key: key);

  void _navigateToDetailScreen(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(
      ShowDetailScreen.routName,
      arguments: {
        'poster': coverUrl,
        'id': id,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _navigateToDetailScreen(
        context,
      ),
      child: Container(
        height: 150,
        width: 100,
        padding: const EdgeInsets.only(
          right: 4,
        ),
        child: Hero(
          tag: id,
          child: coverUrl != 'N/A'
              ? Image.network(
                  coverUrl,
                  fit: BoxFit.cover,
                )
              : Center(
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.headline4?.copyWith(
                          color: Colors.white,
                        ),
                  ),
                ),
        ),
      ),
    );
  }
}
