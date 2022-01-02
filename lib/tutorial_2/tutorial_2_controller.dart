import 'dart:async';

//import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:numbers/board/models/tile_model.dart';

typedef StateFunction = void Function(List<Point> points);

class Tutorial2Controller {
  Tutorial2Controller(
    this.width,
    this.height,
  );

  final int width;
  final int height;

  final disabled = ValueNotifier<bool>(false);

  int bonusTime = 0;

  //AudioPlayer? fryPlayer;
  //AudioPlayer? blopPlayer;

  List<Set<int>> selectedTiles = [];
  List<Set<int>> expiringTiles = [];
  List<Set<int>> burnTiles = [];
  List<Point> selectedPoints = [];
  List<ValueNotifier<List<TileModel>>> columns = [];

  final score = ValueNotifier<int>(0);
  int level = 0;
  int round = 0;
  int lastSpawn = 0;
  bool isMuted = true;

  Future<void> setInitial() async {
    columns.add(ValueNotifier<List<TileModel>>([]));

    columns[0].value = List.from([
      TileModel(
        customKey: GlobalKey(),
        number: 2,
        point: Point(0, 0),
      ),
      TileModel(
        customKey: GlobalKey(),
        number: 5,
        point: Point(0, 1),
      ),
      TileModel(
        customKey: GlobalKey(),
        number: 5,
        point: Point(0, 2),
      ),
      TileModel(
        customKey: GlobalKey(),
        number: 4,
        point: Point(0, 3),
      ),
      TileModel(
        customKey: GlobalKey(),
        number: 1,
        point: Point(0, 4),
      ),
    ]);
    columns.add(ValueNotifier<List<TileModel>>([]));

    columns[1].value = List.from([
      TileModel(
        customKey: GlobalKey(),
        number: 5,
        point: Point(1, 0),
      ),
      TileModel(
        customKey: GlobalKey(),
        number: 2,
        point: Point(0, 1),
      ),
      TileModel(
        customKey: GlobalKey(),
        number: 2,
        point: Point(0, 2),
      ),
      TileModel(
        customKey: GlobalKey(),
        number: 2,
        point: Point(0, 3),
      ),
      TileModel(
        customKey: GlobalKey(),
        number: 1,
        point: Point(0, 4),
      ),
    ]);
    columns.add(ValueNotifier<List<TileModel>>([]));

    columns[2].value = List.from([
      TileModel(
        customKey: GlobalKey(),
        number: 5,
        point: Point(1, 0),
      ),
      TileModel(
        customKey: GlobalKey(),
        number: 2,
        point: Point(0, 1),
      ),
      TileModel(
        customKey: GlobalKey(),
        number: 1,
        point: Point(0, 2),
      ),
      TileModel(
        customKey: GlobalKey(),
        number: 1,
        point: Point(0, 3),
      ),
      TileModel(
        customKey: GlobalKey(),
        number: 4,
        point: Point(0, 4),
      ),
    ]);
    columns.add(ValueNotifier<List<TileModel>>([]));

    columns[3].value = List.from([
      TileModel(
        customKey: GlobalKey(),
        number: 2,
        point: Point(1, 0),
      ),
      TileModel(
        customKey: GlobalKey(),
        number: 5,
        point: Point(0, 1),
      ),
      TileModel(
        customKey: GlobalKey(),
        number: 3,
        point: Point(0, 2),
      ),
      TileModel(
        customKey: GlobalKey(),
        number: 5,
        point: Point(0, 3),
      ),
      TileModel(
        customKey: GlobalKey(),
        number: 5,
        point: Point(0, 4),
      ),
    ]);
    columns.add(ValueNotifier<List<TileModel>>([]));

    columns[4].value = List.from([
      TileModel(
        customKey: GlobalKey(),
        number: 3,
        point: Point(1, 0),
      ),
      TileModel(
        customKey: GlobalKey(),
        number: 4,
        point: Point(0, 1),
      ),
      TileModel(
        customKey: GlobalKey(),
        number: 2,
        point: Point(0, 2),
      ),
      TileModel(
        customKey: GlobalKey(),
        number: 5,
        point: Point(0, 3),
      ),
      TileModel(
        customKey: GlobalKey(),
        number: 2,
        point: Point(0, 4),
      ),
    ]);
  }
}
