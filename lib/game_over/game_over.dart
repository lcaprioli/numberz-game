import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GameOver extends StatefulWidget {
  const GameOver({required this.score, Key? key}) : super(key: key);
  final int score;
  @override
  _GameOverState createState() => _GameOverState();
}

class _GameOverState extends State<GameOver> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Game Over',
            textAlign: TextAlign.center,
            style: GoogleFonts.gfsNeohellenic(
              textStyle: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 38.0,
              ),
            ),
          ),
          SizedBox(
            height: 8.0,
          ),
          Text(
            'Your score: ${widget.score}',
            textAlign: TextAlign.center,
            style: GoogleFonts.gfsNeohellenic(
              textStyle: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 32.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
