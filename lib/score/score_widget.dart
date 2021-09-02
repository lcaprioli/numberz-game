import 'package:flutter/material.dart';

class Score extends StatelessWidget {
  const Score(this.score, this.isMobile);
  final int score;
  final bool isMobile;
  @override
  Widget build(BuildContext context) {
    return Flex(
      mainAxisAlignment: MainAxisAlignment.center,
      direction: isMobile ? Axis.horizontal : Axis.vertical,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Score',
            style: Theme.of(context).textTheme.headline5,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            '$score',
            style: Theme.of(context).textTheme.headline5,
          ),
        ),
        Container(),
      ],
    );
  }
}
