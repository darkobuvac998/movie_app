import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../comments/comment.dart';

class Comments extends StatelessWidget {
  final List<QueryDocumentSnapshot<Map<String, dynamic>>> docs;
  const Comments({
    required this.docs,
    Key? key,
  }) : super(key: key);

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
              data: docs[i]['comment'],
              likes: docs[i]['likes'],
              dislikes: docs[i]['dislikes'],
            ),
          );
        },
      ),
    );
  }
}
