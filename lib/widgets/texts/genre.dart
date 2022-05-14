import 'package:flutter/material.dart';

class Genre extends StatelessWidget {
  final List<String> genres;
  const Genre({
    required this.genres,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ...genres.map(
            (e) {
              final data = e.trim();
              return Container(
                padding: const EdgeInsets.all(
                  5,
                ),
                margin: const EdgeInsets.only(
                  right: 5,
                ),
                decoration: BoxDecoration(
                  color: Colors.grey.shade700,
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(
                    10,
                  ),
                ),
                child: Text(
                  data,
                  style: Theme.of(context).textTheme.headline4?.copyWith(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                      ),
                ),
              );
            },
          ).toList(),
        ],
      ),
    );
  }
}
