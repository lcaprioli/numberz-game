import 'package:flutter/material.dart';

class Clock extends StatelessWidget {
  const Clock({
    Key? key,
    required this.counter,
  }) : super(key: key);

  final int counter;

  @override
  Widget build(BuildContext context) {
    var _percent = ((20 - counter) / 20) * 100;
    var _rotation = (_percent / 100) * 6;

    Matrix4 matrix1 = new Matrix4.translationValues(0.0, 0.0, 0.0);
    Matrix4 matrix2 = new Matrix4.translationValues(0.0, 0.0, 0.0);
    Matrix4 matrix3 = new Matrix4.translationValues(0.0, 0.0, 0.0);
    Matrix4 matrix4 = new Matrix4.translationValues(0.0, 0.0, 0.0);

    bool quart1 = true;
    bool quart2 = true;
    bool quart3 = true;
    bool quart4 = true;

    if (_percent <= 25) {
      matrix1.rotateZ(_rotation);
    } else if (_percent >= 25 && _percent <= 50) {
      quart1 = false;
      matrix2.rotateZ(_rotation - 1.5);
    } else if (_percent > 50 && _percent < 75) {
      quart1 = false;
      quart2 = false;
      matrix3.rotateZ(_rotation - 3);
    } else {
      quart1 = false;
      quart2 = false;
      quart3 = false;
      matrix4.rotateZ(_rotation - 4.5);
    }
    return SizedBox(
      width: 50,
      height: 50,
      child: ClipOval(
        child: Stack(
          children: [
            Container(
              width: 50,
              height: 50,
              color: Colors.black,
            ),
            Visibility(
              visible: quart1,
              child: Align(
                alignment: Alignment(1, -1),
                child: Transform(
                  transform: matrix1,
                  origin: Offset(0, 25),
                  child: Container(
                    width: 25,
                    height: 25,
                    color: Colors.yellow,
                  ),
                ),
              ),
            ),
            Visibility(
              visible: quart2,
              child: Align(
                alignment: Alignment(1, 1),
                child: Transform(
                  transform: matrix2,
                  origin: Offset(0, 0),
                  child: Container(
                    width: 25,
                    height: 25,
                    color: Colors.yellow,
                  ),
                ),
              ),
            ),
            Visibility(
              visible: quart3,
              child: Align(
                alignment: Alignment(-1, 1),
                child: Transform(
                  transform: matrix3,
                  origin: Offset(25, 0),
                  child: Container(
                    width: 25,
                    height: 25,
                    color: Colors.yellow,
                  ),
                ),
              ),
            ),
            Visibility(
              visible: quart4,
              child: Align(
                alignment: Alignment(-1, -1),
                child: Transform(
                  transform: matrix4,
                  origin: Offset(25, 25),
                  child: Container(
                    width: 25,
                    height: 25,
                    color: Colors.yellow,
                  ),
                ),
              ),
            ),
            Visibility(
              visible: !quart3,
              child: Align(
                alignment: Alignment(1, -1),
                child: Container(
                  width: 25,
                  height: 25,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
