class TutorialTileModel {
  const TutorialTileModel({
    required this.number,
    this.hasHit = false,
    this.disposed = false,
    this.burned = false,
    this.opaque = false,
  });

  final int number;
  final bool opaque;
  final bool hasHit;
  final bool disposed;
  final bool burned;
}
