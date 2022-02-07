//import 'package:audioplayers/audioplayers.dart';

import 'package:flutter/material.dart';
import 'package:numbers/board/widgets/clock.dart';
import 'package:numbers/board/widgets/tutorial_tile.dart';
import 'package:numbers/shared/templates/colors.dart';
import 'package:numbers/shared/templates/tutorial_body.dart';
import 'package:numbers/shared/templates/tutorial_text.dart';
import 'package:numbers/shared/utils/media_query.dart';

import 'tutorial_5_controller.dart';

class Tutorial5Screen extends StatefulWidget {
  const Tutorial5Screen({
    Key? key,
  }) : super(key: key);

  @override
  _Tutorial5ScreenState createState() => _Tutorial5ScreenState();
}

class _Tutorial5ScreenState extends State<Tutorial5Screen> {
  @override
  Widget build(BuildContext context) {
    return TutorialBody(
      pos: 5,
      board: List.generate(Tutorial5Controller.columns.length, (columnIndex) {
        return Container(
          height: MediaQueryUtils.columnHeight(context),
          width: MediaQueryUtils.columnWidth(context),
          child: Stack(
            children: List.generate(
              Tutorial5Controller.columns[columnIndex].length,
              (index) => TutorialTile(
                tile: Tutorial5Controller.columns[columnIndex].reversed
                    .toList()[index],
                index: index,
              ),
            ),
          ),
        );
      }),
      text: TutorialText(
        'Há dois contadores no jogo: o amarelo e o laranja. O amarelo marca o tempo da partida que é de 60 segundos. O laranja é o marcador de fritura que gira de 10 em 10 segundos.',
      ),
      info: [
        Clock(counter: 10, amount: 12, color: TemplateColors.colorClockTotal),
        Clock(counter: 8, amount: 12, color: TemplateColors.colorClockBurn)
      ],
    );
  }
}
