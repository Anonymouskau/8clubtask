import 'package:flutter/material.dart';

class VideoPreviewWidget extends StatelessWidget {
  final VoidCallback onPlay;
  final VoidCallback onDelete;

  const VideoPreviewWidget({
    super.key,
    required this.onPlay,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      decoration: BoxDecoration(
        color: const Color(0xFF111111),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Stack(
        children: [
          Center(
            child: GestureDetector(
              onTap: onPlay,
              child: const Icon(Icons.play_circle_fill,
                  color: Colors.white, size: 44),
            ),
          ),
          Positioned(
            right: 8,
            top: 8,
            child: GestureDetector(
              onTap: onDelete,
              child: const Icon(Icons.delete_outline, color: Colors.white70),
            ),
          )
        ],
      ),
    );
  }
}
