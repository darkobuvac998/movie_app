import 'package:flutter/material.dart';

class Actors extends StatelessWidget {
  final List<String> actors;
  const Actors({
    required this.actors,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
      ),
      height: 100,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Actors',
              style: Theme.of(context).textTheme.headline4?.copyWith(
                    fontSize: 22,
                    color: Colors.white70,
                  ),
            ),
            const SizedBox(
              height: 10,
            ),
            ...actors.map(
              (e) {
                var data = e.trim();
                return Text(
                  '- $data',
                  style: Theme.of(context).textTheme.headline4,
                );
              },
            ).toList(),
          ],
        ),
      ),
    );
  }
}
