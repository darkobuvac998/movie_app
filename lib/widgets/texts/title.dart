import 'package:flutter/material.dart';

class Title extends StatelessWidget {
  final String title;
  const Title({
    required this.title,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      maxLines: 10,
      overflow: TextOverflow.ellipsis,
      style: Theme.of(context).textTheme.headline5?.copyWith(
            fontSize: 20,
            color: Colors.white70,
            fontWeight: FontWeight.bold,
          ),
    );
  }
}
