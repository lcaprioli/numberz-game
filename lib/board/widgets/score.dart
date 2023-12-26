import 'package:flutter/material.dart';
import 'package:numbers/shared/utils/media_query.dart';

class Score extends StatelessWidget {
  const Score(
    this.score,
    this.isMobile,
  );

  final int score;
  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    return Flex(
      mainAxisAlignment: MainAxisAlignment.start,
      direction: isMobile ? Axis.horizontal : Axis.vertical,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Score',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: MediaQueryUtils.isMobile(context) ? 27 : 32,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '$score',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: MediaQueryUtils.isMobile(context) ? 27 : 32,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
