import 'package:flutter/material.dart';

class TileModel {
  TileModel({
    required this.key,
    required this.number,
    this.hasHit = false,
    this.disposed = false,
    this.burned = false,
  });

  final GlobalKey key;
  final int number;
  final bool hasHit;
  final bool disposed;
  final bool burned;

  TileModel hit() {
    return TileModel(
      key: key,
      number: number,
      hasHit: true,
      disposed: disposed,
      burned: burned,
    );
  }

  TileModel setNumber(int newNumber) {
    return TileModel(
      key: key,
      number: newNumber,
      hasHit: hasHit,
      disposed: disposed,
      burned: burned,
    );
  }

  TileModel unHit() {
    return TileModel(
      key: key,
      number: number,
      hasHit: false,
      disposed: disposed,
      burned: burned,
    );
  }

  TileModel dispose() {
    return TileModel(
      key: key,
      number: number,
      hasHit: hasHit,
      disposed: true,
      burned: burned,
    );
  }

  TileModel unDispose() {
    return TileModel(
      key: key,
      number: number,
      hasHit: hasHit,
      disposed: false,
      burned: false,
    );
  }

  TileModel burn() {
    return TileModel(
      key: key,
      number: number,
      hasHit: hasHit,
      disposed: disposed,
      burned: true,
    );
  }
}
