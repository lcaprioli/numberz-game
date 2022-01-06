import 'dart:async';

//import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:numbers/board/models/tile_model.dart';
import 'package:numbers/board/models/tutorial_tile_model.dart';

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
  List<ValueNotifier<List<TutorialTileModel>>> columns = [];

  final score = ValueNotifier<int>(0);
  int level = 0;
  int round = 0;
  int lastSpawn = 0;
  bool isMuted = true;

  Future<void> setInitial() async {
    columns.add(ValueNotifier<List<TutorialTileModel>>([]));

    columns[0].value = List.from([
      TutorialTileModel(
        customKey: GlobalKey(),
        number: 2,
        opaque: true,
      ),
      TutorialTileModel(
        customKey: GlobalKey(),
        number: 5,
      ),
      TutorialTileModel(
        customKey: GlobalKey(),
        number: 5,
      ),
      TutorialTileModel(
        customKey: GlobalKey(),
        number: 4,
      ),
      TutorialTileModel(
        customKey: GlobalKey(),
        number: 1,
      ),
    ]);
    columns.add(ValueNotifier<List<TutorialTileModel>>([]));

    columns[1].value = List.from([
      TutorialTileModel(
        customKey: GlobalKey(),
        number: 5,
      ),
      TutorialTileModel(
        customKey: GlobalKey(),
        number: 2,
        opaque: true,
      ),
      TutorialTileModel(
        customKey: GlobalKey(),
        number: 2,
        opaque: true,
      ),
      TutorialTileModel(
        customKey: GlobalKey(),
        number: 2,
      ),
      TutorialTileModel(
        customKey: GlobalKey(),
        number: 1,
      ),
    ]);
    columns.add(ValueNotifier<List<TutorialTileModel>>([]));

    columns[2].value = List.from([
      TutorialTileModel(
        customKey: GlobalKey(),
        number: 5,
      ),
      TutorialTileModel(
        customKey: GlobalKey(),
        number: 2,
        opaque: true,
      ),
      TutorialTileModel(
        customKey: GlobalKey(),
        number: 1,
      ),
      TutorialTileModel(
        customKey: GlobalKey(),
        number: 1,
      ),
      TutorialTileModel(
        customKey: GlobalKey(),
        number: 4,
      ),
    ]);
    columns.add(ValueNotifier<List<TutorialTileModel>>([]));

    columns[3].value = List.from([
      TutorialTileModel(
        customKey: GlobalKey(),
        number: 2,
        opaque: true,
      ),
      TutorialTileModel(
        customKey: GlobalKey(),
        number: 5,
      ),
      TutorialTileModel(
        customKey: GlobalKey(),
        number: 3,
      ),
      TutorialTileModel(
        customKey: GlobalKey(),
        number: 5,
      ),
      TutorialTileModel(
        customKey: GlobalKey(),
        number: 5,
      ),
    ]);
    columns.add(ValueNotifier<List<TutorialTileModel>>([]));

    columns[4].value = List.from([
      TutorialTileModel(
        customKey: GlobalKey(),
        number: 3,
      ),
      TutorialTileModel(
        customKey: GlobalKey(),
        number: 4,
      ),
      TutorialTileModel(
        customKey: GlobalKey(),
        number: 2,
      ),
      TutorialTileModel(
        customKey: GlobalKey(),
        number: 5,
      ),
      TutorialTileModel(
        customKey: GlobalKey(),
        number: 2,
      ),
    ]);
  }
}
