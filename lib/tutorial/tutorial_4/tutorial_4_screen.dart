//import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
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
  @override
  Widget build(BuildContext context) {
    return TutorialBody(
      pos: 3,
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
