import 'package:flutter/material.dart';

class Score extends StatelessWidget {
  const Score(this.score, this.isMobile, this.level, this.round);
  final int score;
  final int level;
  final int round;
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
            'Round',
            style: Theme.of(context).textTheme.headline5,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            '$round',
            style: Theme.of(context).textTheme.headline5,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Level',
            style: Theme.of(context).textTheme.headline5,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            '$level',
            style: Theme.of(context).textTheme.headline5,
          ),
        ),
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
