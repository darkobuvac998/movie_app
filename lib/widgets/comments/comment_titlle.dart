import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'new_comment.dart';

class CommentsTitle extends StatelessWidget {
  final String movieId;
  final bool commentExists;
  const CommentsTitle({
    required this.movieId,
    required this.commentExists,
    Key? key,
  }) : super(key: key);

  void _addNewComment(BuildContext ctx) {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(
              5,
            ),
          ),
        ),
        context: ctx,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            behavior: HitTestBehavior.opaque,
            child: NewComment(
              movieId: movieId,
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          child: Text( commentExists ?
            'Comments' : 'There is no any comment',
            style: Theme.of(context).textTheme.headline4?.copyWith(
                  fontSize: 22,
                  color: Colors.white70,
                ),
          ),
        ),
        Card(
          color: Colors.transparent,
          child: IconButton(
            icon: const Icon(
              Icons.add,
            ),
            onPressed: () => _addNewComment(context),
          ),
        )
      ],
    );
  }
}
