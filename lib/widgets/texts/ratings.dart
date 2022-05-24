import 'package:flutter/material.dart';

import '../../models/rating.dart';

class Ratings extends StatelessWidget {
  final List<Rating>? ratings;
  const Ratings({
    required this.ratings,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Ratings',
          style: Theme.of(context).textTheme.headline4?.copyWith(
                fontSize: 22,
                color: Colors.white70,
              ),
        ),
        const SizedBox(
          height: 10,
        ),
        if (ratings != null)
          ...ratings!.map(
            (rating) {
              return Text(
                '- ${rating.source} (${rating.value})',
                style: Theme.of(context).textTheme.headline4,
              );
            },
          ),
      ],
    );
  }
}
