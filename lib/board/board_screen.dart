import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import 'board_consts.dart';
import 'board_controller.dart';
import 'board_functions.dart';
import 'board_tile_model.dart';
import 'board_widgets.dart';

class BoardScreen extends StatefulWidget {
  BoardScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _BoardScreenState createState() => _BoardScreenState();
}

class _BoardScreenState extends State<BoardScreen> {
  late Timer _refresh;
  late Timer _timer;
  late BoardFunctions functions;
  final controller = BoardController();

  @override
  void initState() {
    functions = BoardFunctions(controller);
    controller.tiles = List.generate(
      BoardConsts.width * BoardConsts.height,
      (index) => Tile(
        key: GlobalKey(),
        number: Random().nextInt(5) + 1,
      ),
    );
    functions.setInitial();
    _refresh = Timer.periodic(Duration(milliseconds: 150), (t) {
      setState(() {
        functions.moveDown(t);
      });
    });
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (controller.seconds == 0) {
          functions.decrease();
          controller.seconds = 20;
        } else {
          controller.seconds = controller.seconds - 1;
        }
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
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Score: ${controller.score}'),
            Text('Timer: ${controller.seconds}'),
          ],
        ),
      ),
      body: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Listener(
              onPointerMove: functions.pointerDown,
              onPointerUp: functions.pointerUp,
              child: Container(
                padding: EdgeInsets.all(15),
                constraints: BoxConstraints(maxWidth: 325),
                child: GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: BoardConsts.width,
                  children: List.generate(BoardConsts.width * BoardConsts.height, (index) {
                    return BoardWidgets().buildTile(controller.tiles[index], context);
                  }),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                width: 20,
                height: MediaQuery.of(context).size.height - 60,
                color: Colors.brown,
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      width: 20,
                      height: ((MediaQuery.of(context).size.height - 60) / 100) *
                          (controller.seconds / 20) *
                          100,
                      child: Container(
                        color: Colors.red,
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
