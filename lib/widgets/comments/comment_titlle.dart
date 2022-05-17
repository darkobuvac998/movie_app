import 'package:flutter/material.dart';

class CommentsTitle extends StatelessWidget {
  const CommentsTitle({Key? key}) : super(key: key);

  void _addNewComment(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (contx) {
          return const Center(
            child: Text(
              'New Comment!',
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
          child: Text(
            'Comments',
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
