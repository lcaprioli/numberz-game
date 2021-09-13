import 'dart:async';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'board_consts.dart';
import 'models/tile_model.dart';

class BoardController {
  BoardController(
    this.width,
    this.height, {
    required this.audioCache,
  });

  final int width;
  final int height;
  final AudioCache? audioCache;

  int seconds = BoardConsts().timeGap;
  AudioPlayer? fryPlayer;
  AudioPlayer? blopPlayer;

  List<TileModel> tiles = [];
  Set<int> selectedTiles = {};
  int score = 0;
  int level = 0;
  int round = 0;
  int lastSpawn = Random().nextInt(5) + 1;
  bool isMuted = true;
  void setInitial() {
    for (var i = 0; i < width * height; i++) {
      tiles[i] = tiles[i].setNumber(spawnReplacement());
    }
  }

  void reduceTimer() {
    if (seconds == 0) {
      decrease();
      seconds = BoardConsts().timeGap;
      round++;
      if (round % BoardConsts().levelScale == 0) {
        level++;
      }
    } else {
      seconds = seconds - 1;
    }
  }

  void moveDown(Timer t) {
    for (var i = 0; i < width * height; i++) {
      if (i > width - 1) {
        if (tiles[i].disposed) {
          tiles[i] = tiles[i].setNumber(tiles[i - width].number);
          tiles[i] = tiles[i].unDispose();
          tiles[i - width] = tiles[i - width].dispose();
        }
      } else {
        if (tiles[i].disposed) {
          tiles[i] = tiles[i].setNumber(spawnReplacement());
          tiles[i] = tiles[i].unDispose();
        }
      }
    }
  }

  int spawnReplacement() {
    if (combinationCount() < 3) {
      return lastSpawn;
    }
    lastSpawn = Random().nextInt(5) + 1;
    return lastSpawn;
  }

  int combinationCount() {
    int _matchCount = 0;
    for (var i = 0; i < width; i++) {
      for (var a = 0; a < height - 1; a++) {
        if (tiles[(a * width) + i].number == tiles[((a + 1) * width) + i].number) {
          _matchCount++;
        }
      }
    }
    for (var i = 0; i < height; i++) {
      for (var a = 0; a < width - 1; a++) {
        if (tiles[(i * width) + a].number == tiles[((i * width) + a) + 1].number) {
          _matchCount++;
        }
      }
    }

    return _matchCount;
  }

  void decrease() async {
    var _targetTiles = <int>[];
    var _maxLevel = (level > 2) ? 2 : level;
    for (var i = 0; i < width * height; i++) {
      if (tiles[i].number < (5 - _maxLevel)) {
        tiles[i] = tiles[i].setNumber(tiles[i].number + 1);
      } else {
        _targetTiles.add(i);
      }
      var _targetCount = _targetTiles.length;
      while (_targetTiles.length > (_targetCount / 3) * 2) {
        var _randomPick = Random().nextInt(_targetTiles.length);
        score = score - 10;
        tiles[_targetTiles[_randomPick]] = tiles[_targetTiles[_randomPick]].burn();
        _targetTiles.removeAt(_randomPick);
      }
    }
    if (!isMuted) fryPlayer = await audioCache?.play('fry.mp3');
    await Future.delayed(Duration(seconds: 2));
    for (var i = 0; i < width * height; i++) {
      if (tiles[i].burned) {
        tiles[i] = tiles[i].dispose();
      }
    }
  }

  void pointerDown(PointerMoveEvent event) async {
    for (var i = 0; i < width * height; i++) {
      final box = tiles[i].key.currentContext?.findRenderObject() as RenderBox;
      final result = BoxHitTestResult();
      Offset localRed = box.globalToLocal(event.position);
      if (box.hitTest(result, position: localRed)) {
        tiles[i] = tiles[i].hit();
        selectedTiles.add(i);
      }
    }
  }

  void pointerUp(PointerUpEvent event) async {
    if (selectedTiles.length > 1) {
      var sequence = true;
      var sequenceInverse = true;
      var sequenceCount = 0;
      var match = true;
      for (var i = 0; i < selectedTiles.length - 1; i++) {
        var num = tiles[selectedTiles.elementAt(i)].number;
        var next = tiles[selectedTiles.elementAt(i + 1)].number;

        if (num != next + 1) {
          sequence = false;
          sequenceCount++;
        }
      }
      for (var i = 0; i < selectedTiles.length - 1; i++) {
        var num = tiles[selectedTiles.elementAt(i)].number;
        var next = tiles[selectedTiles.elementAt(i + 1)].number;

        if (num != next - 1) {
          sequenceInverse = false;
          sequenceCount++;
        }
      }
      if (!sequence && !sequenceInverse) {
        for (var i = 0; i < selectedTiles.length - 1; i++) {
          var num = tiles[selectedTiles.elementAt(i)].number;
          var next = tiles[selectedTiles.elementAt(i + 1)].number;

          if (num != next) {
            match = false;
          }
        }
      } else {
        match = false;
      }

      if (match || sequence || sequenceInverse) {
        for (var i = 0; i < selectedTiles.length; i++) {
          tiles[selectedTiles.elementAt(i)] = tiles[selectedTiles.elementAt(i)].dispose();
        }
        if (!isMuted) blopPlayer = await audioCache?.play('blop.mp3');
      }

      if (match) {
        score += (BoardConsts().matchScore * selectedTiles.length);
      } else if (sequenceCount > BoardConsts().sequenceBonus) {
        score += (BoardConsts().sequenceBonusScore * selectedTiles.length);
      } else if (sequence || sequenceInverse) {
        score += (BoardConsts().sequenceScore * selectedTiles.length);
      }
    }
    selectedTiles = {};
    for (var i = 0; i < width * height; i++) {
      tiles[i] = tiles[i].unHit();
    }
  }
}
