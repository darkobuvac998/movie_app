import 'package:flutter/material.dart';

class Plot extends StatelessWidget {
  final String plot;
  const Plot({
    required this.plot,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Plot',
          style: Theme.of(context).textTheme.headline4?.copyWith(
                fontSize: 22,
                color: Colors.white70,
              ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          plot,
          overflow: TextOverflow.ellipsis,
          textDirection: TextDirection.ltr,
          textAlign: TextAlign.justify,
          style: Theme.of(context).textTheme.headline4,
          maxLines: 100,
        )
      ],
    );
  }
}
