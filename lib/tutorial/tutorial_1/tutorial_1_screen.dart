//import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:numbers/board/widgets/tutorial_tile.dart';
import 'package:numbers/shared/templates/tutorial_body.dart';
import 'package:numbers/shared/templates/tutorial_text.dart';
import 'package:numbers/shared/utils/media_query.dart';
import 'package:numbers/tutorial/tutorial_1/tutorial_1_controller.dart';

class Tutorial1Screen extends StatefulWidget {
  const Tutorial1Screen({
    Key? key,
  }) : super(key: key);

  @override
  _Tutorial1ScreenState createState() => _Tutorial1ScreenState();
}

class _Tutorial1ScreenState extends State<Tutorial1Screen> {
  @override
  Widget build(BuildContext context) {
    return TutorialBody(
      pos: 1,
      board: List.generate(Tutorial1Controller.columns.length, (columnIndex) {
        return Container(
          height: MediaQueryUtils.columnHeight(context),
          width: MediaQueryUtils.columnWidth(context),
          child: Stack(
            children: List.generate(
              Tutorial1Controller.columns[columnIndex].length,
              (index) => TutorialTile(
                tile: Tutorial1Controller.columns[columnIndex].reversed
                    .toList()[index],
                hasPointer: false,
                index: index,
              ),
            ),
          ),
        );
      }),
      text: TutorialText(
        'LOUKOUMADE é um típico doce grego frito delicioso. Seu objetivo no game é fritar as melhores combinações.',
      ),
    );
  }
}
