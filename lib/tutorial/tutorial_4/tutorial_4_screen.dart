//import 'package:audioplayers/audioplayers.dart';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:numbers/board/models/tile_model.dart';
import 'package:numbers/board/widgets/tutorial_tile.dart';
import 'package:numbers/shared/templates/tutorial_body.dart';
import 'package:numbers/shared/templates/tutorial_text.dart';
import 'package:numbers/shared/utils/media_query.dart';

import 'tutorial_4_controller.dart';

class Tutorial4Screen extends StatefulWidget {
  const Tutorial4Screen({
    Key? key,
  }) : super(key: key);

  @override
  _Tutorial4ScreenState createState() => _Tutorial4ScreenState();
}

class _Tutorial4ScreenState extends State<Tutorial4Screen> {
  late Timer? _timer;

  int actualIndex = 0;
  final animation = [
    Point(2, 2),
    Point(2, 3),
    Point(3, 2),
    Point(4, 3),
    Point(3, 3),
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
      pos: 4,
      board: List.generate(Tutorial4Controller.columns.length, (columnIndex) {
        return Container(
          height: MediaQueryUtils.columnHeight(context),
          width: MediaQueryUtils.columnWidth(context),
          child: Stack(
            children: List.generate(
              Tutorial4Controller.columns[columnIndex].length,
              (index) => TutorialTile(
                tile: Tutorial4Controller.columns[columnIndex].reversed
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
        'Agora, se você conseguir fazer uma sequência de 1/2/3/4/5 ganha 500 pontos!',
      ),
    );
  }
}
