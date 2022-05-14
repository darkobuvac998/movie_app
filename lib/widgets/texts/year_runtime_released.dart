import 'package:flutter/material.dart';

class YearRuntimeReleased extends StatelessWidget {
  final String year;
  final String runtime;
  final String released;
  const YearRuntimeReleased({
    required this.year,
    required this.runtime,
    required this.released,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          'Year: $year',
          style: Theme.of(context).textTheme.headline4,
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          'Runtime: $runtime',
          style: Theme.of(context).textTheme.headline4,
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          'Released: $released',
          style: Theme.of(context).textTheme.headline4,
        ),
      ],
    );
  }
}
