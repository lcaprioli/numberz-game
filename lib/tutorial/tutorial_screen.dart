import 'dart:async';

//import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:numbers/board/board_consts.dart';
import 'package:numbers/board/models/tile_model.dart';
import 'package:numbers/board/widgets/sound_button.dart';
import 'package:numbers/board/widgets/tile.dart';
import 'package:numbers/game_over/game_over.dart';
import 'package:numbers/main.dart';
import 'package:numbers/shared/templates/main_body.dart';
import 'package:numbers/shared/templates/tutorial_body.dart';
import 'package:numbers/shared/utils/media_query.dart';
import 'package:numbers/tutorial/tutorial_controller.dart';

class TutorialScreen extends StatefulWidget {
  TutorialScreen({
    Key? key,
    required this.title,
    required this.isMobile,
  }) : super(key: key);

  final String title;
  final bool isMobile;

  @override
  _TutorialScreenState createState() => _TutorialScreenState();
}

class _TutorialScreenState extends State<TutorialScreen> {
  late TutorialController controller;

  @override
  void initState() {
    controller = TutorialController(
      BoardConsts.width,
      BoardConsts.height,
      //     audioCache: audioCache,
    );
    controller.setInitial();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TutorialBody(
      content: Expanded(
        child: Stack(
          children: [
            Flex(
              direction: widget.isMobile ? Axis.vertical : Axis.horizontal,
              children: [
                Flexible(
                  flex: 8,
                  fit: FlexFit.tight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          padding: EdgeInsets.all(15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(controller.columns.length,
                                (columnIndex) {
                              return Container(
                                height: MediaQueryUtils.columnHeight(context),
                                width: MediaQueryUtils.columnWidth(context),
                                child: Stack(
                                  children: List.generate(
                                    controller
                                        .columns[columnIndex].value.length,
                                    (index) =>
                                        ValueListenableBuilder<List<TileModel>>(
                                            valueListenable:
                                                controller.columns[columnIndex],
                                            builder: (_, list, __) {
                                              return Tile(
                                                tile: list.reversed
                                                    .toList()[index],
                                                index: index,
                                                isMobile: widget.isMobile,
                                              );
                                            }),
                                  ),
                                ),
                              );
                            }),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  flex: 4,
                  fit: FlexFit.tight,
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: widget.isMobile ? 10 : 40,
                      left: 40,
                      right: 40,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [],
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
