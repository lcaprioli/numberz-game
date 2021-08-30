import 'package:flutter/material.dart';

class Tile {
  Tile({
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

  Tile hit() {
    return Tile(
      key: key,
      number: number,
      hasHit: true,
      disposed: disposed,
      burned: burned,
    );
  }

  Tile setNumber(int newNumber) {
    return Tile(
      key: key,
      number: newNumber,
      hasHit: hasHit,
      disposed: disposed,
      burned: burned,
    );
  }

  Tile unHit() {
    return Tile(
      key: key,
      number: number,
      hasHit: false,
      disposed: disposed,
      burned: burned,
    );
  }

  Tile dispose() {
    return Tile(
      key: key,
      number: number,
      hasHit: hasHit,
      disposed: true,
      burned: burned,
    );
  }

  Tile unDispose() {
    return Tile(
      key: key,
      number: number,
      hasHit: hasHit,
      disposed: false,
      burned: false,
    );
  }

  Tile burn() {
    return Tile(
      key: key,
      number: number,
      hasHit: hasHit,
      disposed: disposed,
      burned: true,
    );
  }
}
