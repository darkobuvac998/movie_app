import 'package:flutter/material.dart';

class CommentReactionButton extends StatelessWidget {
  final IconData icon;
  final int votes;
  const CommentReactionButton({
    required this.icon,
    required this.votes,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: 80,
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                icon,
                size: 15,
              ),
            ),
            Expanded(
              child: FittedBox(
                fit: BoxFit.cover,
                alignment: Alignment.center,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 4,
                  ),
                  child: Text(
                    '$votes',
                    style: Theme.of(context).textTheme.headline4?.copyWith(
                          color: Colors.white60,
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0.2,
                        ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
