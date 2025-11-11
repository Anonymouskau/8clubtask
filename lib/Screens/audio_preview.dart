import 'package:flutter/material.dart';

class AudioPreviewWidget extends StatelessWidget {
  final String duration;
  final VoidCallback onPlay;
  final VoidCallback onDelete;

  const AudioPreviewWidget({
    super.key,
    required this.duration,
    required this.onPlay,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text(
              "Audio Recorded",
              style: TextStyle(
                color: Colors.white,
                fontFamily: "SpaceGrotesk",
                fontSize: 14,
              ),
            ),
            Text(" · $duration",
                style: const TextStyle(color: Colors.white54, fontSize: 14)),
            const Spacer(),
            GestureDetector(
              onTap: onDelete,
              child: const Icon(Icons.delete_outline, color: Colors.white70),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          decoration: BoxDecoration(
            color: const Color(0xFF1A1A1A),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              GestureDetector(
                onTap: onPlay,
                child: const Icon(Icons.play_arrow, color: Colors.white, size: 28),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Row(
                  children: List.generate(
                    20,
                    (i) => Expanded(
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 1.5),
                        height: i.isEven ? 16 : 8,
                        decoration: BoxDecoration(
                          color: Colors.white70,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
