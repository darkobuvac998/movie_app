import 'package:flutter/material.dart';

class Directors extends StatelessWidget {
  final String director;
  final String writer;
  const Directors({
    required this.director,
    required this.writer,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            'Director: $director',
            style: Theme.of(context).textTheme.headline4,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            'Writer: $writer',
            style: Theme.of(context).textTheme.headline4,
          ),
        ],
      ),
    );
  }
}
