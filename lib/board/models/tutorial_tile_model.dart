import 'package:flutter/material.dart';

class TutorialTileModel {
  TutorialTileModel({
    required this.customKey,
    required this.number,
    this.hasHit = false,
    this.disposed = false,
    this.burned = false,
    this.opaque = false,
  });

  final GlobalKey customKey;
  final int number;
  final bool opaque;
  bool hasHit;
  bool disposed;
  bool burned;

  TutorialTileModel hit() {
    return TutorialTileModel(
      customKey: customKey,
      number: number,
      hasHit: true,
      disposed: disposed,
      burned: burned,
    );
  }

  TutorialTileModel setNumber(int newNumber) {
    return TutorialTileModel(
      customKey: customKey,
      number: newNumber,
      hasHit: hasHit,
      disposed: disposed,
      burned: burned,
    );
  }

  TutorialTileModel unHit() {
    return TutorialTileModel(
      customKey: customKey,
      number: number,
      hasHit: false,
      disposed: disposed,
      burned: burned,
    );
  }

  TutorialTileModel dispose() {
    return TutorialTileModel(
      customKey: customKey,
      number: number,
      hasHit: hasHit,
      disposed: true,
      burned: burned,
    );
  }

  TutorialTileModel unDispose() {
    return TutorialTileModel(
      customKey: customKey,
      number: number,
      hasHit: hasHit,
      disposed: false,
      burned: false,
    );
  }

  TutorialTileModel burn() {
    return TutorialTileModel(
      customKey: customKey,
      number: number,
      hasHit: hasHit,
      disposed: disposed,
      burned: true,
    );
  }
}
