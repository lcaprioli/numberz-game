import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:numbers/board/board_controller.dart';

import 'board_consts.dart';

class BoardFunctions {
  final BoardController controller;

  BoardFunctions(this.controller);

  void setInitial() {
    for (var i = 0; i < BoardConsts.width * BoardConsts.height; i++) {
      controller.tiles[i] = controller.tiles[i].setNumber(spawnReplacement());
    }
  }

  void moveDown(Timer t) {
    for (var i = 0; i < BoardConsts.width * BoardConsts.height; i++) {
      if (i > BoardConsts.width - 1) {
        if (controller.tiles[i].disposed) {
          controller.tiles[i] =
              controller.tiles[i].setNumber(controller.tiles[i - BoardConsts.width].number);
          controller.tiles[i] = controller.tiles[i].unDispose();
          controller.tiles[i - BoardConsts.width] = controller.tiles[i - BoardConsts.width].dispose();
        }
      } else {
        if (controller.tiles[i].disposed) {
          controller.tiles[i] = controller.tiles[i].setNumber(spawnReplacement());
          controller.tiles[i] = controller.tiles[i].unDispose();
        }
      }
    }
  }

  int spawnReplacement() {
    if (combinationCount() < 3) {
      return controller.lastSpawn;
    }
    controller.lastSpawn = Random().nextInt(5) + 1;
    return controller.lastSpawn;
  }

  int combinationCount() {
    int _matchCount = 0;
    for (var i = 0; i < BoardConsts.width; i++) {
      for (var a = 0; a < BoardConsts.height - 1; a++) {
        if (controller.tiles[(a * BoardConsts.width) + i].number ==
            controller.tiles[((a + 1) * BoardConsts.width) + i].number) {
          _matchCount++;
        }
      }
    }
    for (var i = 0; i < BoardConsts.height; i++) {
      for (var a = 0; a < BoardConsts.width - 1; a++) {
        if (controller.tiles[(i * BoardConsts.width) + a].number ==
            controller.tiles[((i * BoardConsts.width) + a) + 1].number) {
          _matchCount++;
        }
      }
    }

    return _matchCount;
  }

  void decrease() async {
    for (var i = 0; i < BoardConsts.width * BoardConsts.height; i++) {
      if (controller.tiles[i].number < 5) {
        controller.tiles[i] = controller.tiles[i].setNumber(controller.tiles[i].number + 1);
      } else {
        controller.score = controller.score - 10;
        controller.tiles[i] = controller.tiles[i].burn();
      }
    }
    await Future.delayed(Duration(seconds: 1));
    for (var i = 0; i < BoardConsts.width * BoardConsts.height; i++) {
      if (controller.tiles[i].burned) {
        controller.tiles[i] = controller.tiles[i].dispose();
      }
    }
  }

  void pointerDown(PointerMoveEvent event) {
    for (var i = 0; i < BoardConsts.width * BoardConsts.height; i++) {
      final box = controller.tiles[i].key.currentContext?.findRenderObject() as RenderBox;
      final result = BoxHitTestResult();
      Offset localRed = box.globalToLocal(event.position);
      if (box.hitTest(result, position: localRed)) {
        controller.tiles[i] = controller.tiles[i].hit();
        controller.selectedTiles.add(i);
      }
    }
  }

  void pointerUp(PointerUpEvent event) {
    if (controller.selectedTiles.length > 1) {
      var sequence = true;
      var sequenceInverse = true;
      var match = true;
      for (var i = 0; i < controller.selectedTiles.length - 1; i++) {
        var num = controller.tiles[controller.selectedTiles.elementAt(i)].number;
        var next = controller.tiles[controller.selectedTiles.elementAt(i + 1)].number;

        if (num != next + 1) {
          sequence = false;
        }
      }
      for (var i = 0; i < controller.selectedTiles.length - 1; i++) {
        var num = controller.tiles[controller.selectedTiles.elementAt(i)].number;
        var next = controller.tiles[controller.selectedTiles.elementAt(i + 1)].number;

        if (num != next - 1) {
          sequenceInverse = false;
        }
      }
      if (!sequence && !sequenceInverse) {
        for (var i = 0; i < controller.selectedTiles.length - 1; i++) {
          var num = controller.tiles[controller.selectedTiles.elementAt(i)].number;
          var next = controller.tiles[controller.selectedTiles.elementAt(i + 1)].number;

          if (num != next) {
            match = false;
          }
        }
      } else {
        match = false;
      }

      if (match || sequence || sequenceInverse) {
        for (var i = 0; i < controller.selectedTiles.length; i++) {
          controller.tiles[controller.selectedTiles.elementAt(i)] =
              controller.tiles[controller.selectedTiles.elementAt(i)].dispose();
        }
      }
      if (match) {
        controller.score += (10 * controller.selectedTiles.length);
      } else if (sequence || sequenceInverse) {
        controller.score += (50 * controller.selectedTiles.length);
      }
    }
    controller.selectedTiles = {};
    for (var i = 0; i < BoardConsts.width * BoardConsts.height; i++) {
      controller.tiles[i] = controller.tiles[i].unHit();
    }
  }
}
