import 'package:flutter/material.dart';

class MainBody extends StatelessWidget {
  const MainBody({Key? key, required this.content}) : super(key: key);

  final Widget content;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          'assets/images/bg.png',
          fit: BoxFit.cover,
        ),
        content,
      ],
    ));
  }
}
