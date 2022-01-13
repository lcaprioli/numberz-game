import 'package:flutter/material.dart';

class RowDecoration extends StatelessWidget {
  const RowDecoration({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 65,
            child: Image.asset(
              'assets/images/pattern.png',
              repeat: ImageRepeat.repeatX,
              color: Color(0xFF0be1f7),
              colorBlendMode: BlendMode.multiply,
            ),
          ),
        )
      ],
    );
  }
}

class ChiefDecoration extends StatelessWidget {
  const ChiefDecoration({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.height / 2,
      child: Image.asset(
        'assets/images/greek.png',
        fit: BoxFit.contain,
      ),
    );
  }
}
