import 'package:flutter/material.dart';
import 'package:numbers/board/board_controller.dart';

import 'board_widgets.dart';

class BoardWidgetStack extends StatefulWidget {
  const BoardWidgetStack({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final BoardController controller;

  @override
  _BoardWidgetStackState createState() => _BoardWidgetStackState();
}

class _BoardWidgetStackState extends State<BoardWidgetStack> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var _row = 0;
    var _column = 1;
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Listener(
          onPointerMove: widget.controller.pointerDown,
          onPointerUp: widget.controller.pointerUp,
          child: Container(
              padding: EdgeInsets.all(15),
              //        constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height - 150),
              /*    child: GridView.count(
              shrinkWrap: true,
              crossAxisCount: widget.controller.width,
              children: List.generate(widget.controller.width * widget.controller.height, (index) {
                return BoardWidgets().buildTile(widget.controller.tiles[index], context);
      _row = 0;
              }),
            ), */
              child: Stack(
                children: List.generate(widget.controller.width * widget.controller.height, (index) {
                  var _width = widget.controller.width;
                  var _height = widget.controller.height;
                  if (_row == _width) {
                    _column++;
                    _row = 0;
                  }
                  _row++;
                  return AnimatedAlign(
                    key: widget.controller.tiles[index].key,
                    duration: Duration(
                      milliseconds: 750,
                    ),
                    alignment: Alignment(
                      -1 + ((_row) * (2 / (_width + 1))),
                      -1 + ((_column) * (2 / (_height + 1))),
                    ),
                    child: BoardWidgets().buildTile(widget.controller.tiles[index], context),
                  );
                }),
                /*               children: List.generate(widget.controller.width * widget.controller.height, (index) {
              var _width = widget.controller.width;
              var _height = widget.controller.height;
              if (_row == _width) {
                _column++;
                _row = 0;
              }
              _row++;
              return Positioned(left: _row * 120, top: 20, child: Text('$_row / $_column'));
     */ /*   return AnimatedPositioned(
                left: _row * 20,
                top: _column * 20,
                width: 30,
                height: 30,
                child: BoardWidgets().buildTile(widget.controller.tiles[index], context),
                duration: Duration(
                  milliseconds: 250,
                ),
              );
            })),
             */
              )),
        ),
      ),
    );
  }
}
