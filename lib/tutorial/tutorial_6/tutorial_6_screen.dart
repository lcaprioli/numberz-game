//import 'package:audioplayers/audioplayers.dart';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:numbers/board/models/tile_model.dart';
import 'package:numbers/board/widgets/clock.dart';
import 'package:numbers/board/widgets/tutorial_tile.dart';
import 'package:numbers/shared/templates/colors.dart';
import 'package:numbers/shared/templates/tutorial_body.dart';
import 'package:numbers/shared/templates/tutorial_text.dart';
import 'package:numbers/shared/utils/media_query.dart';

import 'tutorial_6_controller.dart';

class Tutorial6Screen extends StatefulWidget {
  const Tutorial6Screen({
    Key? key,
  }) : super(key: key);

  @override
  _Tutorial6ScreenState createState() => _Tutorial6ScreenState();
}

class _Tutorial6ScreenState extends State<Tutorial6Screen> {
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
      pos: 6,
      board: List.generate(Tutorial6Controller.columns.length, (columnIndex) {
        return Container(
          height: MediaQueryUtils.columnHeight(context),
          width: MediaQueryUtils.columnWidth(context),
          child: Stack(
            children: List.generate(
              Tutorial6Controller.columns[columnIndex].length,
              (index) => TutorialTile(
                tile: Tutorial6Controller.columns[columnIndex].reversed
                    .toList()[index],
                index: index,
              ),
            ),
          ),
        );
      }),
      text: TutorialText(
        'Sempre que ele completa uma volta, um número aleatório de doces aumentam +1 em seus valores. Ah! Lembra as sequências de 500 pontos com 1, 2, 3, 4 e 5? Se você fizer uma dessas, ambos marcadores param por alguns segundos!.',
      ),
      info: [
        Clock(counter: 10, amount: 12, color: TemplateColors.colorClockTotal),
        Clock(counter: 8, amount: 12, color: TemplateColors.colorClockBurn)
      ],
    );
  }
}
