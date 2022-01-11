//import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
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
  @override
  Widget build(BuildContext context) {
    return TutorialBody(
      pos: 1,
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
