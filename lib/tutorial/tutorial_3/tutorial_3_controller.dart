//import 'package:audioplayers/audioplayers.dart';
import 'package:numbers/board/models/tile_model.dart';
import 'package:numbers/board/models/tutorial_tile_model.dart';

typedef StateFunction = void Function(List<Point> points);

class Tutorial3Controller {
  const Tutorial3Controller();

  static const List<List<TutorialTileModel>> columns = [
    [
      TutorialTileModel(
        number: 2,
      ),
      TutorialTileModel(
        number: 5,
      ),
      TutorialTileModel(
        number: 5,
      ),
      TutorialTileModel(
        number: 4,
      ),
      TutorialTileModel(
        number: 1,
      ),
    ],
    [
      TutorialTileModel(
        number: 5,
      ),
      TutorialTileModel(
        number: 2,
      ),
      TutorialTileModel(
        number: 2,
      ),
      TutorialTileModel(
        number: 2,
      ),
      TutorialTileModel(
        number: 1,
      ),
    ],
    [
      TutorialTileModel(
        number: 5,
      ),
      TutorialTileModel(
        number: 2,
        opaque: true,
      ),
      TutorialTileModel(
        number: 1,
        opaque: true,
      ),
      TutorialTileModel(
        number: 1,
      ),
      TutorialTileModel(
        number: 4,
      ),
    ],
    [
      TutorialTileModel(
        number: 2,
      ),
      TutorialTileModel(
        number: 5,
      ),
      TutorialTileModel(
        number: 3,
      ),
      TutorialTileModel(
        number: 5,
      ),
      TutorialTileModel(
        number: 5,
      ),
    ],
    [
      TutorialTileModel(
        number: 3,
      ),
      TutorialTileModel(
        number: 4,
      ),
      TutorialTileModel(
        number: 2,
      ),
      TutorialTileModel(
        number: 5,
      ),
      TutorialTileModel(
        number: 2,
      ),
    ],
  ];
}
