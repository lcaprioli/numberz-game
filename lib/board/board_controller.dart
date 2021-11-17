import 'dart:async';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'board_consts.dart';
import 'models/tile_model.dart';

typedef StateFunction = void Function(List<Point> points);

class BoardController {
  BoardController(
    this.width,
    this.height, {
    required this.audioCache,
    //  required this.updateScreen,
  });

  final int width;
  final int height;
  final AudioCache? audioCache;
  // final StateFunction selectTileFunction;
  //final StateFunction burnTilesFunction;
//  final VoidCallback updateScreen;
  int burnTime = BoardConsts().timeGap;
  int totalTime = BoardConsts().gameTime;
  int bonusTime = 0;

  AudioPlayer? fryPlayer;
  AudioPlayer? blopPlayer;

  List<List<TileModel>> tiles = [];
  List<Set<int>> selectedTiles = List.generate(9, (index) => <int>{});

  List<ValueNotifier<List<TileModel>>> columns = [];

  int score = 0;
  int level = 0;
  int round = 0;
  int lastSpawn = Random().nextInt(5) + 1;
  bool isMuted = true;
  Future<void> setInitial() async {
    for (var i = 0; i < width; i++) {
      columns.add(ValueNotifier<List<TileModel>>([]));
      final _tmplist = [];
      for (var a = 0; a < (height * 2); a++) {
        _tmplist.add(
          TileModel(
            customKey: GlobalKey(debugLabel: '$i - $a'),
            number: Random().nextInt(5) + 1,
            point: Point(i, a),
          ),
        );

        //  updateScreen();
        //insertAction(i);
      }
      columns[i].value = List.from(_tmplist);

      ///    tiles[i] = tiles[i].setNumber(spawnReplacement());
    }
  }

  void reduceTimer() {
    if (bonusTime > 0) {
      bonusTime = bonusTime - 1;
    } else {
      if (burnTime == 0) {
        decrease();
        burnTime = BoardConsts().timeGap;
        round++;
        if (round % BoardConsts().levelScale == 0) {
          level++;
        }
      } else {
        burnTime = burnTime - 1;
      }
      if (totalTime == 0) {
        gameOver();
        totalTime = BoardConsts().gameTime;
      } else {
        totalTime = totalTime - 1;
      }
    }
  }

  void gameOver() {}
/* 
  void moveDown(int column, int row) async {
    removeAction(column, row);
    //  await Future.delayed(Duration(seconds: 2));

    insertAction(column);
  }
 */
  int spawnReplacement() {
    if (combinationCount() < 3) {
      return lastSpawn;
    }
    lastSpawn = Random().nextInt(5) + 1;
    return lastSpawn;
  }

  int combinationCount() {
    /*   int _matchCount = 0;
    for (var i = 0; i < width; i++) {
      for (var a = 0; a < height - 1; a++) {
        if (tiles[i][a].number == tiles[i][a + 1].number) {
          _matchCount++;
        }
      }
    }
    for (var i = 0; i < height; i++) {
      for (var a = 0; a < width - 1; a++) {
        if (tiles[a][i].number == tiles[a + 1][i].number) {
          _matchCount++;
        }
      }
    } */

    // return _matchCount;
    return 3;
  }

  void decrease() async {
    var _targetTiles = <List<int>>[];
    var _maxLevel = (level > 2) ? 2 : level;
    for (var i = 0; i < width; i++) {
      for (var a = 0; a < height; a++) {
        if (tiles[i][a].number < (5 - _maxLevel)) {
          tiles[i][a] = tiles[i][a].setNumber(tiles[i][a].number + 1);
        } else {
          _targetTiles.add([i, a]);
        }
        var _targetCount = _targetTiles.length;
        while (_targetTiles.length > (_targetCount / 3) * 2) {
          var _randomPick = Random().nextInt(_targetTiles.length);
          if (score >= 10) score = score - 10;
          tiles[_targetTiles[_randomPick].first]
                  [_targetTiles[_randomPick].last] =
              tiles[_targetTiles[_randomPick].first]
                      [_targetTiles[_randomPick].last]
                  .burn();
          _targetTiles.removeAt(_randomPick);
        }
      }
    }
    if (!isMuted) fryPlayer = await audioCache?.play('fry.mp3');
    await Future.delayed(Duration(seconds: 2));
    for (var i = 0; i < width; i++) {
      for (var a = 0; a < height; a++) {
        if (tiles[i][a].burned) {
          tiles[i].removeAt(a);
          //removeItem(Point(i, a));
        }
      }
    }
  }

  void pointerDown(PointerMoveEvent event) async {
    for (var i = 0; i < width; i++) {
      for (var a = 0; a < columns[i].value.length; a++) {
        final box = columns[i]
            .value[a]
            .customKey
            .currentContext
            ?.findRenderObject() as RenderBox;
        final result = BoxHitTestResult();
        Offset localRed = box.globalToLocal(event.position);
        if (box.hitTest(result, position: localRed)) {
          selectedTiles[i].add(a);
          columns[i].value[a] = columns[i].value[a].hit();

          //selectedTiles.add(columns[i].value[a].customKey);
        }
      }
    }
    for (var i = 0; i < selectedTiles.length; i++) {
      if (selectedTiles[i].length > 0) {
        columns[i].value = List.from(columns[i].value);
      }
    }
    // updateScreen();
  }

  void pointerUp(PointerUpEvent event) async {
    //return;
    for (var a = 0; a < width; a++) {
      for (var x = 0; x < columns[a].value.length; x++) {
        columns[a].value[x] = columns[a].value[x].unHit();
      }
    }
    for (var i = 0; i < selectedTiles.length; i++) {
      if (selectedTiles[i].length > 0) {
        columns[i].value = List.from(columns[i].value);
      }
    }
//    updateScreen();

    for (var i = 0; i < selectedTiles.length; i++) {
      final _deleteList = selectedTiles[i].toList();
      _deleteList.sort((a, b) => b.compareTo(a));
      print(_deleteList);
      //var _deleteList = selectedTiles[i];
      var _newList = columns[i].value;
      //  var _isReversed = _deleteList.toList().first > _deleteList.toList().last;
      //   print(_isReversed);
      for (var a = 0; a < _deleteList.length; a++) {
        _newList.removeAt(_deleteList[a]);
        _newList.add(
          TileModel(
            customKey: GlobalKey(),
            number: Random().nextInt(5) + 1,
            point: Point(
                i,
                columns[i]
                        .value
                        .where((element) => element.disposed == false)
                        .length -
                    1),
          ),
        );
      }
      columns[i].value = List.from(_newList);

      /* for (var x = _row; x < columns[_column].length; x++) {
        //      if (!columns[_column][x].disposed)
        columns[_column][x].point.row = columns[_column][x].point.row - 1;
      } */

      //columns[_column].removeAt(_points[i].row);

      //columns[_column].removeAt(_row);
    }
    selectedTiles = List.generate(9, (index) => <int>{});
    //updateScreen();
  }

/* 
  void pointerUpp(PointerUpEvent event) async {
    if (selectedTiles.length > 1) {
       var sequence = false;
       var sequenceInverse = false;
      var sequenceCount = 0;
      var match = true;

      for (var i = 0; i < selectedTiles.length - 1; i++) {
        var pos = selectedTiles.elementAt(i);
        removeAction(pos.x, pos.y);

        var num = tiles[pos.x][pos.y].number;
        var pos2 = selectedTiles.elementAt(i + 1);
        var next = tiles[pos2.x][pos2.y].number;

        if (num == next + 1) {
             sequence = true;
          sequenceCount++;
        } else {
           sequence = false;
        }
      }
      if (sequenceCount != selectedTiles.length - 1) {
        sequenceCount = 0;
        for (var i = 0; i < selectedTiles.length - 1; i++) {
          var pos = selectedTiles.elementAt(i);
          var num = tiles[pos.x][pos.y].number;
          var pos2 = selectedTiles.elementAt(i + 1);
          var next = tiles[pos2.x][pos2.y].number;

          if (num == next - 1) {
             sequenceInverse = true;
            sequenceCount++;
          } else {
             sequenceInverse = false;
          }
        }
      }
      for (var i = 0; i < selectedTiles.length - 1; i++) {
        var pos = selectedTiles.elementAt(i);
        var num = tiles[pos.x][pos.y].number;
        var pos2 = selectedTiles.elementAt(i + 1);
        var next = tiles[pos2.x][pos2.y].number;

        if (num != next) {
          match = false;
        }
      }

      if (match || sequenceCount == selectedTiles.length - 1) {
        for (var i = 0; i < selectedTiles.length; i++) {
          var pos = selectedTiles.elementAt(i);

              tiles[selectedTiles.elementAt(i)] =
              tiles[selectedTiles.elementAt(i)].dispose();  
           removeItem(Point(pos.x, pos.y));
        }
        if (!isMuted) blopPlayer = await audioCache?.play('blop.mp3');
      }

      if (match) {
        score += (BoardConsts().matchScore * selectedTiles.length);
      } else if (sequenceCount > BoardConsts().sequenceBonus) {
        score += (BoardConsts().sequenceBonusScore * selectedTiles.length);
        bonusTime = BoardConsts().bonusGap;
      } else if (sequenceCount == selectedTiles.length - 1) {
        score += (BoardConsts().sequenceScore * selectedTiles.length);
      }
    }
    selectedTiles = {};
    for (var i = 0; i < width; i++) {
      for (var a = 0; a < height; a++) {
        tiles[i][a] = tiles[i][a].unHit();
      }
    }
  }
 */
/*   void removeItem(Point point) {
    tiles[point.x].removeAt(point.y);
    //  removeAction(point);
    tiles[point.x].insert(
      tiles[point.x].length,
      TileModel(
        key: GlobalKey(),
        number: spawnReplacement(),
        point: Point(point.x, tiles[point.x].length),
      ),
    );
  } */
}
