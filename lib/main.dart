import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:numbers/board/board_controller.dart';
import 'package:numbers/board/board_functions.dart';
import 'package:numbers/board/board_widgets.dart';

import 'board/board_consts.dart';
import 'board/board_tile_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Timer? _refresh;
  Timer? _timer;
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
