import 'package:flutter/material.dart';
import 'package:movie_app/widgets/buttons/bottom_border_button_bar.dart';
import 'package:movie_app/widgets/profile_badge.dart';
import 'package:provider/provider.dart';

import '../providers/movies.dart';
import '../widgets/buttons/bottom_border_button.dart';
import '../widgets/categories/category.dart';

class HomeScreen extends StatefulWidget {
  final VoidCallback onProfileBadgeTap;
  const HomeScreen({
    required this.onProfileBadgeTap,
    Key? key,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentButtonIndex = 0;

  void _onButtonTap(int index) {
    setState(() {
      _currentButtonIndex = index;
    });
  }

  Future<void> _refreshItems(BuildContext ctx) async {
    return Future.delayed(Duration.zero, () async {
      return await Provider.of<Movies>(ctx, listen: false)
          .fetchData('harry potter');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(
              12.0,
            ),
            child: ProfileBadge(
              onTap: widget.onProfileBadgeTap,
            ),
          ),
        ],
        leading: const Icon(
          Icons.movie_filter,
          size: 35,
        ),
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
      ),
      body: FutureBuilder(
        future: _refreshItems(context),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return RefreshIndicator(
            onRefresh: () => _refreshItems(context),
            child: Consumer<Movies>(
              builder: (ctx, movies, _) => Column(
                children: [
                  Category(
                    items: movies.items,
                    title: 'Popular',
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
