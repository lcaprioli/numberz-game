//import 'package:audioplayers/audioplayers.dart';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:numbers/board/models/tile_model.dart';
import 'package:numbers/board/widgets/tutorial_tile.dart';
import 'package:numbers/shared/templates/tutorial_body.dart';
import 'package:numbers/shared/templates/tutorial_text.dart';
import 'package:numbers/shared/utils/media_query.dart';

import 'tutorial_2_controller.dart';

class Tutorial2Screen extends StatefulWidget {
  const Tutorial2Screen({
    Key? key,
  }) : super(key: key);

  @override
  _Tutorial2ScreenState createState() => _Tutorial2ScreenState();
}

class _Tutorial2ScreenState extends State<Tutorial2Screen> {
  late Timer? _timer;
  int actualIndex = 0;
  final animation = [
    Point(0, 4),
    Point(1, 3),
    Point(1, 2),
    Point(2, 3),
    Point(3, 4)
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
      pos: 2,
      board: List.generate(Tutorial2Controller.columns.length, (columnIndex) {
        return Container(
          height: MediaQueryUtils.columnHeight(context),
          width: MediaQueryUtils.columnWidth(context),
          child: Stack(
            children: List.generate(
              Tutorial2Controller.columns[columnIndex].length,
              (index) => TutorialTile(
                tile: Tutorial2Controller.columns[columnIndex].reversed
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
        'Sequências com números iguais valem 10 pontos para cada doce.',
      ),
    );
  }
}
