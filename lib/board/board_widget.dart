import 'package:flutter/material.dart';
import 'package:numbers/board/board_controller.dart';

import 'widgets/tile.dart';

class BoardWidget extends StatefulWidget {
  const BoardWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final BoardController controller;

  @override
  _BoardWidgetState createState() => _BoardWidgetState();
}

class _BoardWidgetState extends State<BoardWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerMove: widget.controller.pointerDown,
      onPointerUp: widget.controller.pointerUp,
      child: Container(
        padding: EdgeInsets.all(15),
        constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height - 150),
        child: GridView.count(
          shrinkWrap: true,
          crossAxisCount: widget.controller.width,
          children: List.generate(widget.controller.width * widget.controller.height, (index) {
            return Tile(tile: widget.controller.tiles[index]);
          }),
        ),
      ),
    );
  }
}
