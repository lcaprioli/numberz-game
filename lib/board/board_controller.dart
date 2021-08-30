import 'dart:math';

import '../main.dart';

class BoardController {
  List<Tile> tiles = [];
  Set<int> selectedTiles = {};
  int lastSpawn = Random().nextInt(5) + 1;
  int score = 0;
  int seconds = 20;
}
