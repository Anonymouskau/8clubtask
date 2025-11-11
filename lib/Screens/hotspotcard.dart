import 'package:flutter/material.dart';

class HotspotCard extends StatelessWidget {
  const HotspotCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 390,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 0), // ✅ bottom = 0 (no space)
      child: const Text(
        "What kind of Hotspots do you want to host?",
        style: TextStyle(
          fontFamily: 'SpaceGrotesk',
          fontSize: 28,
          fontWeight: FontWeight.w700,
          height: 1.28,
          letterSpacing: -0.84,
          color: Colors.white,
        ),
      ),
    );
  }
}
