//import 'package:audioplayers/audioplayers.dart';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:numbers/board/models/tile_model.dart';
import 'package:numbers/board/widgets/tutorial_tile.dart';
import 'package:numbers/shared/templates/tutorial_body.dart';
import 'package:numbers/shared/templates/tutorial_text.dart';
import 'package:numbers/shared/utils/media_query.dart';

import 'tutorial_3_controller.dart';

class Tutorial3Screen extends StatefulWidget {
  const Tutorial3Screen({
    Key? key,
  }) : super(key: key);

  @override
  _Tutorial3ScreenState createState() => _Tutorial3ScreenState();
}

class _Tutorial3ScreenState extends State<Tutorial3Screen> {
  late Timer? _timer;
  int actualIndex = 0;
  final animation = [
    Point(2, 2),
    Point(2, 3),
  ];

  @override
  void initState() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (actualIndex == animation.length - 1) {
          actualIndex = 0;
        } else {
          actualIndex++;
        }
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TutorialBody(
      pos: 3,
      board: List.generate(Tutorial3Controller.columns.length, (columnIndex) {
        return Container(
          height: MediaQueryUtils.columnHeight(context),
          width: MediaQueryUtils.columnWidth(context),
          child: Stack(
            children: List.generate(
              Tutorial3Controller.columns[columnIndex].length,
              (index) => TutorialTile(
                tile: Tutorial3Controller.columns[columnIndex].reversed
                    .toList()[index],
                index: index,
                hasPointer: animation[actualIndex].column == columnIndex &&
                    animation[actualIndex].row == index,
              ),
            ),
          ),
        );
      }),
      text: TutorialText(
        'Combinações em ordem crescente ou decrescente valem 30 pontos por doce.',
      ),
    );
  }
}
