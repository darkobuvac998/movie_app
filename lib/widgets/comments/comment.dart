import 'package:flutter/material.dart';

class Comment extends StatelessWidget {
  final String data;
  const Comment({
    required this.data,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(
            8,
          ),
          decoration: BoxDecoration(
            color: Colors.grey.shade700,
            borderRadius: BorderRadius.circular(
              5,
            ),
          ),
          child: Text(
            data,
            style: Theme.of(context).textTheme.headline4?.copyWith(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.2,
                ),
          ),
        )
      ],
    );
  }
}
