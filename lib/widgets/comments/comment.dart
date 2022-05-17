import 'package:flutter/material.dart';

import '../buttons/comment_reaction_button.dart';

class Comment extends StatelessWidget {
  final String data;
  final int likes;
  final int dislikes;
  final String? userName;
  const Comment({
    required this.data,
    required this.likes,
    required this.dislikes,
    this.userName,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(
        8,
      ),
      decoration: BoxDecoration(
        color: Colors.grey.shade700,
        borderRadius: BorderRadius.circular(
          5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                userName ?? 'User',
                style: Theme.of(context).textTheme.headline4?.copyWith(
                      color: Colors.white60,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0.2,
                    ),
              ),
              Row(
                children:  [
                  CommentReactionButton(
                    icon: Icons.thumb_up_alt_outlined,
                    votes: likes,
                  ),
                  CommentReactionButton(
                    icon: Icons.thumb_down_alt_outlined,
                    votes: dislikes,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            data,
            overflow: TextOverflow.ellipsis,
            maxLines: 50,
            textAlign: TextAlign.justify,
            style: Theme.of(context).textTheme.headline4?.copyWith(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                  letterSpacing: 0.2,
                ),
          ),
        ],
      ),
    );
  }
}
