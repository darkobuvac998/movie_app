import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../comments/comment.dart';

class Comments extends StatelessWidget {
  final List<QueryDocumentSnapshot<Map<String, dynamic>>> docs;
  final String movieId;
  const Comments({
    required this.movieId,
    required this.docs,
    Key? key,
  }) : super(key: key);

  void _like(String id, int likes) async {
    await FirebaseFirestore.instance
        .collection('movie-comments/$movieId/comments')
        .doc(id)
        .update(
      {
        'likes': likes,
      },
    );
  }

  void _dislike(String id, int dislikes) async {
    await FirebaseFirestore.instance
        .collection('movie-comments/$movieId/comments')
        .doc(id)
        .update(
      {'dislikes': dislikes},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: docs.length,
        itemBuilder: (ctx, i) {
          return Container(
            margin: const EdgeInsets.only(
              bottom: 5,
            ),
            child: Comment(
              id: docs[i].id,
              data: docs[i]['comment'],
              likes: docs[i]['likes'],
              dislikes: docs[i]['dislikes'],
              userName: (docs[i].data())['userName'] ?? 'Unknown user',
              like: _like,
              dislike: _dislike,
            ),
          );
        },
      ),
    );
  }
}
