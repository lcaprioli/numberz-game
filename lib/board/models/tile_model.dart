import 'package:flutter/material.dart';

class TileModel {
  TileModel({
    required this.customKey,
    required this.number,
    required this.point,
    this.hasHit = false,
    this.disposed = false,
    this.burned = false,
  });

  final GlobalKey customKey;
  final int number;
  Point point;
  bool hasHit;
  bool disposed;
  bool burned;

  TileModel hit() {
    return TileModel(
      customKey: customKey,
      number: number,
      hasHit: true,
      disposed: disposed,
      burned: burned,
      point: point,
    );
  }

  TileModel setNumber(int newNumber) {
    return TileModel(
      customKey: customKey,
      number: newNumber,
      hasHit: hasHit,
      disposed: disposed,
      burned: burned,
      point: point,
    );
  }

  TileModel unHit() {
    return TileModel(
      customKey: customKey,
      number: number,
      hasHit: false,
      disposed: disposed,
      burned: burned,
      point: point,
    );
  }

  TileModel dispose() {
    return TileModel(
      customKey: customKey,
      number: number,
      hasHit: hasHit,
      disposed: true,
      burned: burned,
      point: point,
    );
  }

  TileModel unDispose() {
    return TileModel(
      customKey: customKey,
      number: number,
      hasHit: hasHit,
      disposed: false,
      burned: false,
      point: point,
    );
  }

  TileModel burn() {
    return TileModel(
      customKey: customKey,
      number: number,
      hasHit: hasHit,
      disposed: disposed,
      burned: true,
      point: point,
    );
  }

  TileModel setPoint(Point point) {
    return TileModel(
      customKey: customKey,
      number: number,
      hasHit: hasHit,
      disposed: disposed,
      burned: true,
      point: point,
    );
  }
}

class Point {
  Point(this.column, this.row);

  final int column;
  int row;
}
