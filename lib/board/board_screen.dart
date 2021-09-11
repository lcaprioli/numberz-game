import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:numbers/score/score_widget.dart';

import 'board_consts.dart';
import 'board_controller.dart';
import 'board_tile_model.dart';
import 'board_widget copy.dart';
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
          child: Stack(
            children: [
              Flex(
                direction: widget.isMobile ? Axis.vertical : Axis.horizontal,
                children: [
                  Flexible(
                    flex: 8,
                    fit: FlexFit.tight,
                    child: Container(
                      padding: EdgeInsets.all(30.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          BoardWidget(controller: controller),
                          //   BoardWidgetStack(controller: controller),
                          /*          Container(
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
                          ), */
                        ],
                      ),
                    ),
                  ),
                  Flexible(
                    flex: widget.isMobile ? 1 : 4,
                    fit: FlexFit.tight,
                    child: Score(
                      controller.score,
                      widget.isMobile,
                      controller.level,
                      controller.round,
                    ),
                  )
                ],
              ),
              Visibility(
                visible: !widget.isMobile,
                child: Positioned(
                  right: 20,
                  bottom: 0,
                  width: 450,
                  child: Image.asset(
                    'assets/images/greek.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(left: 20, top: 20, child: Counter(counter: controller.seconds))
            ],
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
            child: Image.asset(
              'assets/images/pattern.png',
              repeat: ImageRepeat.repeatX,
              color: Color(0xFF0be1f7),
              colorBlendMode: BlendMode.multiply,
            ),
          ),
        )
      ],
    );
  }
}

class Counter extends StatelessWidget {
  const Counter({
    Key? key,
    required this.counter,
  }) : super(key: key);

  final int counter;

  @override
  Widget build(BuildContext context) {
    var _percent = ((20 - counter) / 20) * 100;
    //print(_percent);
    var _rotation = (_percent / 100) * 6;
    //print(_rotation);
    Matrix4 matrix1 = new Matrix4.translationValues(0.0, 0.0, 0.0);
    Matrix4 matrix2 = new Matrix4.translationValues(0.0, 0.0, 0.0);
    Matrix4 matrix3 = new Matrix4.translationValues(0.0, 0.0, 0.0);
    Matrix4 matrix4 = new Matrix4.translationValues(0.0, 0.0, 0.0);

    bool quart1 = true;
    bool quart2 = true;
    bool quart3 = true;
    bool quart4 = true;

    if (_percent <= 25) {
      matrix1.rotateZ(_rotation);
      print('1');
    } else if (_percent >= 25 && _percent <= 50) {
      print('2');
      quart1 = false;
      matrix2.rotateZ(_rotation - 1.5);
    } else if (_percent > 50 && _percent < 75) {
      print('3');
      quart1 = false;
      quart2 = false;
      matrix3.rotateZ(_rotation - 3);
    } else {
      print('4');
      quart1 = false;
      quart2 = false;
      quart3 = false;
      matrix4.rotateZ(_rotation - 4.5);
    }
    return SizedBox(
      width: 50,
      height: 50,
      child: ClipOval(
        child: Stack(
          children: [
            Container(
              width: 50,
              height: 50,
              color: Colors.black,
            ),
            Visibility(
              visible: quart1,
              child: Align(
                alignment: Alignment(1, -1),
                child: Transform(
                  transform: matrix1,
                  origin: Offset(0, 25),
                  child: Container(
                    width: 25,
                    height: 25,
                    color: Colors.yellow,
                  ),
                ),
              ),
            ),
            Visibility(
              visible: quart2,
              child: Align(
                alignment: Alignment(1, 1),
                child: Transform(
                  transform: matrix2,
                  origin: Offset(0, 0),
                  child: Container(
                    width: 25,
                    height: 25,
                    color: Colors.yellow,
                  ),
                ),
              ),
            ),
            Visibility(
              visible: quart3,
              child: Align(
                alignment: Alignment(-1, 1),
                child: Transform(
                  transform: matrix3,
                  origin: Offset(25, 0),
                  child: Container(
                    width: 25,
                    height: 25,
                    color: Colors.yellow,
                  ),
                ),
              ),
            ),
            Visibility(
              visible: quart4,
              child: Align(
                alignment: Alignment(-1, -1),
                child: Transform(
                  transform: matrix4,
                  origin: Offset(25, 25),
                  child: Container(
                    width: 25,
                    height: 25,
                    color: Colors.yellow,
                  ),
                ),
              ),
            ),
            Visibility(
              visible: !quart3,
              child: Align(
                alignment: Alignment(1, -1),
                child: Container(
                  width: 25,
                  height: 25,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
