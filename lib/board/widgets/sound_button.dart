import 'package:flutter/material.dart';

class SoundButton extends StatelessWidget {
  const SoundButton({
    required this.onTap,
    required this.isMuted,
  });

  final VoidCallback onTap;
  final bool isMuted;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: ClipOval(
          child: Container(
            height: 60,
            width: 60,
            color: Colors.blue.shade800,
            child: Icon(
              isMuted ? Icons.music_off : Icons.music_note,
              size: 33,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
