//import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
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
  @override
  Widget build(BuildContext context) {
    return TutorialBody(
      pos: 2,
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
              ),
            ),
          ),
        );
      }),
      text: TutorialText(
        '222222222222 Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis sapien ante, dictum sit amet sagittis nec, sollicitudin eget nisi. Nunc euismod.',
      ),
    );
  }
}
