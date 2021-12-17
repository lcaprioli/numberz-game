import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Clock extends StatelessWidget {
  const Clock({
    required this.counter,
    required this.amount,
    required this.title,
    required this.color,
  });

  final int counter;
  final int amount;
  final String title;
  final Color color;
  @override
  Widget build(BuildContext context) {
    final _size = 70.0;
    final _halfSize = _size / 2;
    var _percent = ((amount - counter) / amount) * 100;
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
    return Column(
      children: [
        Container(
          width: _size + 2,
          height: _size + 2,
          child: PhysicalModel(
            elevation: 2,
            shadowColor: Colors.black,
            clipBehavior: Clip.antiAlias,
            shape: BoxShape.circle,
            color: Colors.black,
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: PhysicalModel(
                clipBehavior: Clip.antiAlias,
                shape: BoxShape.circle,
                color: Colors.black,
                child: Stack(
                  children: [
                    Container(
                      width: _size,
                      height: _size,
                      color: Colors.black,
                    ),
                    Visibility(
                      visible: quart1,
                      child: Align(
                        alignment: Alignment(1, -1),
                        child: Transform(
                          transform: matrix1,
                          origin: Offset(0, _halfSize),
                          child: Container(
                            width: _halfSize,
                            height: _halfSize,
                            color: color,
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
                            width: _halfSize,
                            height: _halfSize,
                            color: color,
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
                          origin: Offset(_halfSize, 0),
                          child: Container(
                            width: _halfSize,
                            height: _halfSize,
                            color: color,
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
                          origin: Offset(_halfSize, _halfSize),
                          child: Container(
                            width: _halfSize,
                            height: _halfSize,
                            color: color,
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: !quart3,
                      child: Align(
                        alignment: Alignment(1, -1),
                        child: Container(
                          width: _halfSize,
                          height: _halfSize,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      width: _size * .87,
                      height: _size * .87,
                      child: Container(
                        transform: Matrix4.skewX(.02),
                        child: ClipOval(
                          child: ColorFiltered(
                            colorFilter: ColorFilter.mode(
                              Colors.white.withOpacity(0.1),
                              BlendMode.multiply,
                            ),
                            child: Container(
                              color: Colors.white.withOpacity(0.1),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Text(
          '$title',
          style: GoogleFonts.gfsNeohellenic(
            textStyle: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 32.0,
            ),
          ),
        ),
        Text(
          '$counter',
          style: GoogleFonts.gfsNeohellenic(
            textStyle: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 32.0,
            ),
          ),
        ),
      ],
    );
  }
}
