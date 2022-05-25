import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/models/show_short.dart';
import 'package:movie_app/widgets/buttons/bottom_border_button_bar.dart';
import 'package:movie_app/widgets/categories/movie_categories_management.dart';
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

  void _manageCategories(BuildContext ctx) {
    showDialog(
      context: ctx,
      builder: (_) => const Dialog(
        child: MovieCategoriesManagement(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final path = 'user-categories/${user?.uid}/categories';
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
        leading: IconButton(
          icon: const Icon(
            Icons.category_rounded,
            size: 35,
          ),
          onPressed: () => _manageCategories(context),
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
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection(path)
            .where(
              'show',
              isEqualTo: true,
            )
            .snapshots(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Something went wrong',
                style: Theme.of(context).textTheme.headline4?.copyWith(
                      color: Colors.white,
                      fontSize: 20,
                    ),
              ),
            );
          } else if (snapshot.data?.docs == null) {
            return Center(
              child: Text(
                'There is no added categories!',
                style: Theme.of(context).textTheme.headline4?.copyWith(
                      color: Colors.white,
                      fontSize: 20,
                    ),
              ),
            );
          }

          final docs = snapshot.data?.docs
              as List<QueryDocumentSnapshot<Map<String, dynamic>>>;

          print(docs[0].id);

          return Container(
            child: ListView.builder(
              itemCount: docs.length,
              itemBuilder: (ctx, i) =>
                  StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                      stream: FirebaseFirestore.instance
                          .collection('$path/${docs[i].id}/movies')
                          .snapshots(),
                      builder: (ctx, snapshotInner) {
                        if (snapshotInner.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (snapshotInner.hasError) {
                          return Center(
                            child: Text(
                              'Something went wrong',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4
                                  ?.copyWith(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                            ),
                          );
                        } else if (snapshotInner.data?.docs == null) {
                          return Center(
                            child: Text(
                              'There is no movies!',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4
                                  ?.copyWith(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                            ),
                          );
                        }

                        final innerDocs = snapshotInner.data?.docs;

                        List<ShowShort> items = innerDocs!
                            .map(
                              (e) => ShowShort(
                                title: e['title'],
                                year: '2019',
                                imdbID: e['id'],
                                type: e['type'],
                                poster: e['coverUrl'],
                              ),
                            )
                            .toList();

                        return Category(
                          title: docs[i]['name'],
                          items: items,
                        );
                      }),
            ),
          );
        },
      ),
    );
  }
}
