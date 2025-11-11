import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../riverpod/riverpod_stateprovider.dart';
import 'audio_preview.dart';
import 'video_preview.dart';

class NextScreen extends ConsumerStatefulWidget {
  const NextScreen({super.key});

  @override
  ConsumerState<NextScreen> createState() => _NextScreenState();
}

class _NextScreenState extends ConsumerState<NextScreen> {
  final TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final hasAudio = ref.watch(audioRecordedProvider);
    final hasVideo = ref.watch(videoRecordedProvider);

    return Scaffold(
      backgroundColor: Colors.black,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: EdgeInsets.only(
                left: 24,
                right: 24,
                top: 24,
                bottom: MediaQuery.of(context).viewInsets.bottom + 24,
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Why do you want to host with us?",
                        style: TextStyle(
                          fontFamily: "SpaceGrotesk",
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.8,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        "Tell us about your intent and what motivates you to create experiences.",
                        style: TextStyle(
                          fontFamily: "SpaceGrotesk",
                          fontSize: 14,
                          color: Colors.white70,
                        ),
                      ),
                      const SizedBox(height: 30),

                      // Text Input
                      TextField(
                        controller: textController,
                        maxLines: 10,
                        maxLength: 600,
                        style: const TextStyle(color: Colors.white, fontSize: 16),
                        decoration: InputDecoration(
                          hintText: "/ Start typing here",
                          hintStyle: const TextStyle(color: Colors.white38),
                          filled: true,
                          fillColor: const Color(0xFF1A1A1A),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Colors.white24),
                          ),
                          counterStyle: const TextStyle(color: Colors.white54),
                        ),
                      ),

                      // Recorded Audio Preview
                      if (hasAudio) ...[
                        const SizedBox(height: 24),
                        AudioPreviewWidget(
                          duration: "00:59",
                          onPlay: () => print("PLAY AUDIO"),
                          onDelete: () => ref
                              .read(audioRecordedProvider.notifier)
                              .state = false,
                        ),
                      ],

                      // Recorded Video Preview
                      if (hasVideo) ...[
                        const SizedBox(height: 24),
                        VideoPreviewWidget(
                          onPlay: () => print("PLAY VIDEO"),
                          onDelete: () => ref
                              .read(videoRecordedProvider.notifier)
                              .state = false,
                        ),
                      ],

                      const SizedBox(height: 24),

                      // Bottom Row (always visible)
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 54,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(color: Colors.white24),
                              ),
                              child: Row(
                                children: [
                                  // Audio Button
                                  Expanded(
                                    child: AbsorbPointer(
                                      absorbing: hasVideo, // disable if video recorded
                                      child: Opacity(
                                        opacity: hasVideo ? 0.4 : 1.0,
                                        child: GestureDetector(
                                          onTap: () => ref
                                              .read(audioRecordedProvider.notifier)
                                              .state = true,
                                          child: const Center(
                                            child: Icon(Icons.mic,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(width: 1, color: Colors.white24),
                                  // Video Button
                                  Expanded(
                                    child: AbsorbPointer(
                                      absorbing: hasAudio, // disable if audio recorded
                                      child: Opacity(
                                        opacity: hasAudio ? 0.4 : 1.0,
                                        child: GestureDetector(
                                          onTap: () => ref
                                              .read(videoRecordedProvider.notifier)
                                              .state = true,
                                          child: const Center(
                                            child: Icon(Icons.videocam,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 14),
                          // Next Button
                          Expanded(
                            child: GestureDetector(
                              onTap: () =>
                                  print("✅ Message: ${textController.text}"),
                              child: Container(
                                height: 54,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF2A2A2A),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: const Center(
                                  child: Text(
                                    "Next =>",
                                    style: TextStyle(
                                      fontFamily: 'SpaceGrotesk',
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
