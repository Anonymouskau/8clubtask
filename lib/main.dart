import 'package:flutter/material.dart';
import 'package:hotspothosts/Screens/hotspotcard.dart';
import 'package:hotspothosts/Screens/nextscreen.dart';
import 'package:hotspothosts/Screens/slider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'riverpod/riverpod_stateprovider.dart';
void main() {
runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
  backgroundColor: const Color(0xFF2C2C2C),
  foregroundColor: Colors.white,
  elevation: 0,
  centerTitle: true,
  toolbarHeight: 80,

  leading: IconButton(
    icon: const Icon(Icons.arrow_back_sharp),
    onPressed: () => Navigator.pop(context),
  ),
  actions: [
    IconButton(
      icon: const Icon(Icons.close),
      onPressed: () => Navigator.pop(context),
    ),
  ],

  bottom: PreferredSize(
  preferredSize: const Size.fromHeight(4),
  child: Consumer(
    builder: (context, ref, child) {
      final progress = ref.watch(progressProvider);
      return Padding(
        padding: const EdgeInsets.only(left: 65, right: 65, bottom: 50),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: LinearProgressIndicator(
            minHeight: 3,
            value: progress, // ✅ controlled by provider now
            color: const Color(0xFF9196FF),
            backgroundColor: const Color(0x339196FF),
          ),
        ),
      );
    },
  ),
),

),

        body: Consumer(
  builder: (context, ref, child) {
    final step = ref.watch(currentStepProvider);

    return Column(
      children: [
        const SizedBox(height: 100),
        
        Expanded(
          child: step == 0 
            ? const ExperienceSliderScreen()
            : const NextScreen(),
        ),
      ],
    );
  },
),

      ),
    );
  }
}
