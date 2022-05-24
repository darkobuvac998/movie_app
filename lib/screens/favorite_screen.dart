import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../widgets/buttons/bottom_border_button.dart';
import '../widgets/buttons/bottom_border_button_bar.dart';
import '../widgets/categories/category_item.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  int _currentButtonIndex = 0;
  void _onButtonTap(int index) {
    setState(() {
      _currentButtonIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
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
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection('user-favorites/${user?.uid}/favorites')
            .where(
              'type',
              isEqualTo: _currentButtonIndex == 0 ? 'movie' : 'series',
            )
            .where(
              'favorite',
              isEqualTo: true,
            )
            .snapshots(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text(
                'Something went wrong',
              ),
            );
          } else if (snapshot.data?.docs == null ||
              snapshot.data?.docs.length == 0) {
            return Center(
              child: Text(
                _currentButtonIndex == 0
                    ? 'There are no favorite movies.'
                    : 'There are no favorite series.',
                style: Theme.of(context).textTheme.headline4?.copyWith(
                      color: Colors.white,
                      fontSize: 20,
                    ),
              ),
            );
          }

          final docs = snapshot.data?.docs
              as List<QueryDocumentSnapshot<Map<String, dynamic>>>;

          return Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 5,
              vertical: 5,
            ),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 130.0,
                childAspectRatio: 0.7,
                crossAxisSpacing: 2.0,
                mainAxisSpacing: 4.0,
              ),
              itemBuilder: (ctx, i) {
                return CategoryItem(
                  coverUrl: docs[i]['coverUrl'],
                  title: docs[i]['title'],
                  id: docs[i].id,
                );
              },
              itemCount: docs.length,
            ),
          );
        },
      ),
    );
  }
}
