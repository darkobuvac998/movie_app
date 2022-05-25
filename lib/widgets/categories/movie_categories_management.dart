import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/models/show_full.dart';

import 'new_movie_category.dart';

class MovieCategoriesManagement extends StatelessWidget {
  final bool showAddBtn;
  final Function? addMovieToCategory;
  const MovieCategoriesManagement({
    this.showAddBtn = false,
    this.addMovieToCategory,
    Key? key,
  }) : super(key: key);

  void _addNewCategory(BuildContext ctx) {
    showDialog(
        context: ctx,
        builder: (_) {
          return const Dialog(
            insetPadding: EdgeInsets.all(
              30,
            ),
            child: NewMovieCategory(),
          );
        });
  }

  Future<void> _changeCategoryShowStatus(
      QueryDocumentSnapshot<Map<String, dynamic>> doc) async {
    final user = FirebaseAuth.instance.currentUser;
    var path = 'user-categories/${user?.uid}/categories';
    await FirebaseFirestore.instance.collection(path).doc(doc.id).set(
      {
        'name': doc['name'],
        'show': !doc['show'],
      },
    );
  }

  Future<void> _addMovieToCategory(BuildContext ctx, String id) async {
    if (addMovieToCategory == null) {
      return;
    }
    final movie = addMovieToCategory!() as ShowFull?;

    if (movie == null) {
      return;
    }

    try {
      final user = FirebaseAuth.instance.currentUser;
      var path = 'user-categories/${user?.uid}/categories/$id/movies';

      await FirebaseFirestore.instance.collection(path).doc(movie.imdbID).set({
        'coverUrl': movie.poster,
        'title': movie.title,
        'id': movie.imdbID,
        'type': movie.type,
      });

      ScaffoldMessenger.of(ctx).showSnackBar(
          const SnackBar(content: Text('Movie added successfully!')));
    } catch (error) {
      ScaffoldMessenger.of(ctx)
          .showSnackBar(const SnackBar(content: Text('Error occured!')));
    }

    // await FirebaseFirestore.instance.collection(path).doc()
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    final user = FirebaseAuth.instance.currentUser;
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade800,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 5,
      ),
      child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection('user-categories/${user?.uid}/categories')
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

          return Container(
            height: deviceSize.height * 0.5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: const EdgeInsets.only(
                    top: 5,
                  ),
                  child: Text(
                    'Category manager',
                    style: Theme.of(context).textTheme.headline4?.copyWith(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w300,
                        ),
                  ),
                ),
                const Divider(
                  height: 10,
                  thickness: 2,
                ),
                if (docs.isNotEmpty)
                  Expanded(
                    child: ListView.separated(
                      separatorBuilder: (ctx, i) => const Divider(
                        height: 1,
                        thickness: 1,
                        // color: Colors.white,
                      ),
                      itemBuilder: (ctx, i) {
                        return ListTile(
                          tileColor: Colors.white60,
                          title: Text(
                            docs[i]['name'],
                            style:
                                Theme.of(context).textTheme.headline4?.copyWith(
                                      color: Colors.white70,
                                      fontSize: 18,
                                    ),
                          ),
                          trailing: !showAddBtn
                              ? IconButton(
                                  icon: Icon(
                                    !docs[i]['show']
                                        ? Icons.remove_red_eye_outlined
                                        : Icons.remove_red_eye,
                                  ),
                                  onPressed: () =>
                                      _changeCategoryShowStatus(docs[i]),
                                )
                              : IconButton(
                                  icon: const Icon(
                                    Icons.add,
                                  ),
                                  onPressed: () {
                                    _addMovieToCategory(context, docs[i].id);
                                    Navigator.of(context).pop();
                                  },
                                ),
                        );
                      },
                      itemCount: docs.length,
                    ),
                  ),
                if (docs.isEmpty)
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Text(
                            'There is no added categories!',
                            style:
                                Theme.of(context).textTheme.headline4?.copyWith(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                          ),
                        ),
                      ],
                    ),
                  ),
                const Divider(
                  height: 10,
                  thickness: 2,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => _addNewCategory(context),
                      child: Text(
                        'Add',
                        style: Theme.of(context).textTheme.headline4?.copyWith(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                      ),
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text(
                        'Close',
                        style: Theme.of(context).textTheme.headline4?.copyWith(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
