import 'package:flutter/material.dart';

class Languages extends StatelessWidget {
  final List<String> languages;
  const Languages({
    required this.languages,
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
              'Languages',
              style: Theme.of(context).textTheme.headline4?.copyWith(
                    fontSize: 22,
                    color: Colors.white70,
                  ),
            ),
            const SizedBox(
              height: 10,
            ),
            ...languages.map(
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
