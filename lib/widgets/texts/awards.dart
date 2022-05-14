import 'package:flutter/material.dart';

class Awards extends StatelessWidget {
  final String awards;
  const Awards({
    required this.awards,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Awards: ',
          style: Theme.of(context).textTheme.headline4?.copyWith(
                fontSize: 22,
                color: Colors.white70,
              ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          awards,
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
