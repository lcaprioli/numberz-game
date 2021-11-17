import 'package:flutter/material.dart';
import 'package:numbers/board/board_screen.dart';
import 'package:numbers/splash/splash.dart';

int bestScore = 0;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: BoardScreen(
        isMobile: false,
        title: '',
      ),
    );
  }
}
