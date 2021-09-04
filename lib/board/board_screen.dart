import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:numbers/score/score_widget.dart';

import 'board_consts.dart';
import 'board_controller.dart';
import 'board_tile_model.dart';
import 'board_widget.dart';

class BoardScreen extends StatefulWidget {
  BoardScreen({Key? key, required this.title, required this.isMobile}) : super(key: key);

  final String title;
  final bool isMobile;
  @override
  _BoardScreenState createState() => _BoardScreenState();
}

class _BoardScreenState extends State<BoardScreen> {
  late BoardController controller;
  late Timer _refresh;
  late Timer _timer;
  @override
  void initState() {
    controller = BoardController(
      widget.isMobile ? BoardConsts.mobileWidth : BoardConsts.desktopWidth,
      widget.isMobile ? BoardConsts.mobileHeight : BoardConsts.desktopHeight,
    );
    controller.tiles = List.generate(
      controller.width * controller.height,
      (index) => Tile(
        key: GlobalKey(),
        number: Random().nextInt(5) + 1,
      ),
    );
    controller.setInitial();
    _refresh = Timer.periodic(Duration(milliseconds: 150), (t) {
      setState(() {
        controller.moveDown(t);
      });
    });
    _timer = Timer.periodic(Duration(milliseconds: 1000), (timer) {
      setState(() {
        controller.reduceTimer();
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();

    _refresh.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildRowDecoration(),
        Expanded(
          child: Container(
            color: Colors.amber,
            child: Flex(
              direction: widget.isMobile ? Axis.vertical : Axis.horizontal,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  flex: 9,
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        BoardWidget(controller: controller),
                        Container(
                          height: 20,
                          color: Colors.brown,
                          child: Row(
                            children: [
                              Flexible(
                                flex: 60 - ((controller.seconds / 20) * 60).round(),
                                child: Container(
                                  height: 20,
                                  color: Colors.black,
                                ),
                              ),
                              Flexible(
                                flex: ((controller.seconds / 20) * 60).round(),
                                child: Container(
                                  height: 20,
                                  color: Colors.yellow,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Flexible(
                  flex: widget.isMobile ? 1 : 3,
                  child: Container(
                    color: Colors.green,
                    child: Score(controller.score, widget.isMobile, controller.level, controller.round),
                  ),
                )
              ],
            ),
          ),
        ),
        if (!widget.isMobile) buildRowDecoration(),
      ],
    );
  }

  Row buildRowDecoration() {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 65,
            color: Colors.red,
            child: SizedBox.shrink(),
          ),
        )
      ],
    );
  }
}
